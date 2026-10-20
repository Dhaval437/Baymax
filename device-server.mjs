import http from 'node:http';
import { timingSafeEqual, randomBytes } from 'node:crypto';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';
import { readFile } from 'node:fs/promises';
import { inflateSync } from 'node:zlib';
import { learningStore, learningCommand } from './learning-store.mjs';
import { ResponseMetrics } from './response-metrics.mjs';
import { createLocalProvider } from './local-provider.mjs';
import { isWakePhrase, isGoodbye, isCareComplete, isDistressCue, normalizeRobotTranscript, isStatusRequest, WAKE_REPLY, CARE_END_REPLY } from './wake-response.mjs';
import { requestRobotState, spokenRobotStatus } from './robot-status.mjs';
import { ConversationMemory, replyProfile, spokenReply, followupWindow } from './conversation-policy.mjs';
import { conversationGesture } from './gesture-policy.mjs';
import { cachedSpeech } from './speech-cache.mjs';
import { replySegments, trimAudioEdges } from './reply-audio.mjs';

const MAX_RECORDING_BYTES = 60 * 16000 * 2 + 44;
const MAX_REPLY_BYTES = 60 * 24000 * 2;
const HISTORY_TTL = 5 * 60 * 1000;
const JOB_TTL = 8 * 60 * 1000;
const AUDIO_HEADERS = { 'Content-Type': 'application/octet-stream',
  'X-Audio-Format': 's16le; rate=24000; channels=1' };

function sameToken(received, expected) {
  if (!received?.startsWith('Bearer ') || !expected || expected.length < 32) return false;
  const a = Buffer.from(received.slice(7)), b = Buffer.from(expected);
  return a.length === b.length && timingSafeEqual(a, b);
}

async function readLimited(req, limit, progress = () => {}) {
  if (Number(req.headers['content-length']) > limit)
    throw Object.assign(new Error('Recording is too long.'), { status: 413 });
  const chunks = []; let size = 0;
  for await (const chunk of req) {
    size += chunk.length;
    if (size > limit) throw Object.assign(new Error('Recording is too long.'), { status: 413 });
    chunks.push(chunk);
    progress(size);
  }
  return Buffer.concat(chunks, size);
}

export function wavToPcm(wav, sampleRate = 24000) {
  if (wav.length < 44 || wav.toString('ascii', 0, 4) !== 'RIFF' || wav.toString('ascii', 8, 12) !== 'WAVE' ||
      wav.readUInt32LE(4) + 8 !== wav.length) throw new Error('Invalid or truncated WAV file.');
  let format, data;
  for (let offset = 12; offset + 8 <= wav.length;) {
    const kind = wav.toString('ascii', offset, offset + 4);
    const length = wav.readUInt32LE(offset + 4), begin = offset + 8;
    if (begin + length > wav.length) throw new Error('Truncated WAV chunk.');
    if (kind === 'fmt ' && length >= 16) format = {
      codec: wav.readUInt16LE(begin), channels: wav.readUInt16LE(begin + 2),
      rate: wav.readUInt32LE(begin + 4), byteRate: wav.readUInt32LE(begin + 8),
      align: wav.readUInt16LE(begin + 12), bits: wav.readUInt16LE(begin + 14)
    };
    if (kind === 'data') data = wav.subarray(begin, begin + length);
    offset = begin + length + (length & 1);
  }
  if (!format || format.codec !== 1 || format.channels !== 1 || format.rate !== sampleRate ||
      format.bits !== 16 || format.align !== 2 || format.byteRate !== sampleRate * 2 || !data?.length || data.length % 2)
    throw new Error(`Audio must be ${sampleRate / 1000} kHz, mono, signed 16-bit PCM.`);
  return data;
}

export function createDeviceServer({ env = process.env, provider = createLocalProvider(env), now = Date.now,
  learning = learningStore,
  loadWake = () => readFile(new URL('./.cache/wake-greeting.wav', import.meta.url)) } = {}) {
  const token = env.BAYMAX_DEVICE_TOKEN;
  if (!token || token.length < 32) throw new Error('Set BAYMAX_DEVICE_TOKEN to at least 32 random characters.');
  let busy = false, lastWake = -Infinity, lastTurn = -Infinity, wakePcm, job, awaitingWake = false;
  const memory = new ConversationMemory();
  const metrics = new ResponseMetrics();
  let previousHeard = '', pendingCorrection = '', pendingAt = 0;
  const memoryTtl = () => HISTORY_TTL + Math.min(memory.turns, 25) * 60000;
  const status = { state: 'idle', completed: 0, lastError: null };
  let live = { stage: 'idle', stageAt: now(), startedAt: null, finishedAt: null, heard: '', answer: '', outcome: '', timings: {} };
  const stage = name => {
    if (live.startedAt && live.stage !== 'idle') live.timings[live.stage] = now() - live.stageAt;
    live.stage = name; live.stageAt = now();
  };
  const speak = cachedSpeech(async text => {
    const pcm = wavToPcm(await provider.speak(text));
    if (pcm.length > MAX_REPLY_BYTES) throw new Error('Voice exceeds 60-second playback limit');
    return trimAudioEdges(pcm);
  });
  async function wakeAudio() {
    if (!wakePcm) {
      try {
        if ((await learning.load()).voice === 'fast') throw new Error('Use selected voice');
        wakePcm = trimAudioEdges(wavToPcm(await loadWake()));
      }
      catch { wakePcm = await speak(WAKE_REPLY); }
    }
    return wakePcm;
  }
  async function processRecording(recording, wake, publish, robotState = {}) {
    try {
      status.state = 'transcribing';
      stage('transcribing');
      const transcript = await provider.transcribe(recording, 'audio/wav');
      if (typeof transcript !== 'string') throw new Error('Invalid transcript');
      const heard = normalizeRobotTranscript(transcript);
      live.rawHeard = transcript.trim();
      live.heard = heard;
      const command = learningCommand(heard);
      if (command && (!(wake || awaitingWake) || isWakePhrase(heard))) {
        let answer;
        if (command.kind === 'heard') answer = previousHeard ? `I heard: ${previousHeard.slice(0, 240)}` : 'I have no previous phrase to repeat.';
        if (command.kind === 'correct') {
          pendingCorrection = command.phrase; pendingAt = now();
          answer = `You said: ${pendingCorrection}. Say remember this correction to save it.`;
        }
        if (command.kind === 'save') {
          if (pendingCorrection && now() - pendingAt < 120000) {
            await learning.remember(pendingCorrection); pendingCorrection = '';
            answer = 'Correction saved. I will use it as a recognition hint.';
          } else answer = 'First say: I said, followed by the correct words.';
        }
        if (command.kind === 'forget') {
          await learning.forget(); pendingCorrection = '';
          answer = 'Your saved corrections are deleted.';
        }
        if (command.kind === 'voice') {
          await learning.voice(command.mode); speak.clear(); wakePcm = null;
          answer = command.mode === 'fast' ? 'Fast voice is on. This voice sounds different, but responds faster.' :
            'The character voice is back on.';
        }
        live.answer = answer; stage('synthesizing');
        const pcm = await speak(answer);
        status.completed++; live.outcome = 'Learning command completed';
        awaitingWake = false;
        return { status: 200, pcm, end: false, windowMs: 60000, gesture: 'acknowledge' };
      }
      if (isStatusRequest(heard)) {
        const answer = spokenRobotStatus(robotState);
        live.answer = answer; live.statusReport = robotState; stage('synthesizing');
        const pcm = await speak(answer);
        status.completed++; live.outcome = 'Status audio ready for the robot';
        return { status: 200, pcm, end: robotState.conversation !== true, windowMs: 30000, gesture: 'gentle' };
      }
      wake = wake || awaitingWake;
      if (!heard || (wake && !isWakePhrase(heard))) { live.outcome = heard ? 'No wake phrase recognised. Try Baymax or ouch.' : 'No speech recognised.'; return { status: 204 }; }
      previousHeard = heard;
      if (now() - lastTurn > memoryTtl()) memory.clear();
      let pcm, end = false, answer, prepared;
      const greetingOnly = isDistressCue(heard) || (wake && !heard.replace(/\b(?:hey|hello|hi|baymax|ouch|o+w+|a+h+|a{3,})\b/gi, '').replace(/[\s.,!?]/g, ''));
      if (greetingOnly) {
        status.state = 'greeting'; stage('synthesizing'); live.answer = WAKE_REPLY; pcm = await wakeAudio(); answer = WAKE_REPLY;
      } else {
        end = isGoodbye(heard); status.state = 'thinking';
        stage('thinking');
        // Stop requests latch even if generating the final audio later fails.
        if (end) { awaitingWake = true; memory.clear(); lastWake = -Infinity; }
        if (!end) prepared = await memory.prepare(heard, provider.summarize?.bind(provider));
        answer = end ? (isCareComplete(heard) ? CARE_END_REPLY : 'Okay. I am here when you need me.') : spokenReply(await provider.reply(heard, prepared.messages));
        if (!answer) throw new Error('Empty reply');
        live.answer = answer; stage('synthesizing');
        status.state = 'speaking';
        if (publish) {
          const segments = replySegments(answer), audio = [];
          let totalBytes = 0;
          for (let i = 0; i < segments.length; i++) {
            const part = await speak(segments[i]);
            totalBytes += part.length;
            if (totalBytes > MAX_REPLY_BYTES) throw new Error('Voice exceeds 60-second playback limit');
            audio.push(part);
            publish({ status: 200, pcm: part, end, windowMs: followupWindow(heard, answer, memory.turns),
              gesture: conversationGesture(heard, answer, end), more: i < segments.length - 1 });
            if (i === 0) live.firstAudioReadyMs = now() - live.startedAt;
          }
          pcm = Buffer.concat(audio);
        } else pcm = await speak(answer);
      }
      if (pcm.length > MAX_REPLY_BYTES) throw new Error('Voice exceeds 60-second playback limit');
      lastTurn = now(); if (wake) lastWake = now();
      if (!end && wake) awaitingWake = false;
      if (end) memory.clear();
      else if (prepared) memory.commit(prepared, heard, answer);
      // A wake greeting resumes the existing session without adding noise to its memory.
      const windowMs = followupWindow(heard, answer, memory.turns);
      live.conversation = { ...memory.snapshot(), replyStyle: greetingOnly ? 'greeting' : replyProfile(heard, prepared?.messages).style,
        estimatedContextTokens: prepared?.estimatedTokens || 0, followupSeconds: end ? 0 : windowMs / 1000 };
      status.completed++;
      live.outcome = 'Audio ready for the robot'; live.audioSeconds = pcm.length / 48000;
      return { status: 200, pcm, end, windowMs, gesture: conversationGesture(heard, answer, end) };
    } catch (error) {
      if (error.code === 'NO_SPEECH') { live.outcome = 'No speech recognised.'; return { status: 204 }; }
      status.lastError = 'Speech processing failed. Check local model services.';
      console.error(status.lastError);
      live.outcome = status.lastError;
      return { status: 502 };
    } finally {
      stage('idle'); live.finishedAt = now(); status.state = 'idle'; busy = false;
      if (live.outcome === 'Audio ready for the robot') metrics.record(live.timings);
    }
  }
  function respond(res, result) {
    if (result.status === 200) {
      res.writeHead(200, { ...AUDIO_HEADERS, 'Content-Length': result.pcm.length,
        'X-Conversation': result.end ? 'end' : 'continue', 'X-Conversation-Window-Ms': result.windowMs,
        'X-Gesture': result.gesture, 'X-Reply-More': result.more ? '1' : '0' });
      res.end(result.pcm);
    } else { res.writeHead(result.status); res.end(); }
  }
  const server = http.createServer(async (req, res) => {
    res.setHeader('Cache-Control', 'no-store'); res.setHeader('X-Content-Type-Options', 'nosniff');
    const fail = (code, message) => { res.writeHead(code, { 'Content-Type': 'text/plain' }); res.end(message); };
    let url;
    try { url = new URL(req.url, 'http://localhost'); }
    catch { return fail(400, 'Invalid request URL.'); }
    if (!url.pathname.startsWith('/device/')) return fail(404, 'Not found.');
    if (!sameToken(req.headers.authorization, token)) return fail(401, 'Unauthorized.');
    if (req.method === 'GET' && url.pathname === '/device/ping') { res.writeHead(204); return res.end(); }
    if (req.method === 'GET' && url.pathname === '/device/status') {
      res.writeHead(200, { 'Content-Type': 'application/json' });
      return res.end(JSON.stringify({ ...status, busy, awaitingWake, mode: 'local', protocol: 2 }));
    }
    if (req.method === 'GET' && url.pathname.startsWith('/device/result/')) {
      if (!job || url.pathname !== `/device/result/${job.id}` || now() - job.created > JOB_TTL)
        return fail(404, 'Result expired.');
      if (job.segmented) {
        const index = Number(url.searchParams.get('part') || 0);
        if (!Number.isInteger(index) || index < 0 || index > 110) return fail(400, 'Invalid part.');
        return respond(res, job.parts[index] || (job.result && job.result.status !== 200 ? job.result :
          job.result ? { status: 404 } : { status: 202 }));
      }
      return respond(res, job.result || { status: 202 });
    }
    const wake = url.pathname === '/device/wake';
    if (req.method !== 'POST' || (!wake && url.pathname !== '/device/turn')) return fail(404, 'Not found.');
    if (busy) return fail(409, 'Baymax is busy.');
    // Do not discard audio before recognition: a repeated "ouch" must still work.
    if (req.headers['content-type']?.split(';')[0] !== 'audio/wav') return fail(415, 'Send a WAV recording.');
    busy = true; status.lastError = null; status.state = 'receiving';
    live = { stage: 'receiving', stageAt: now(), startedAt: now(), finishedAt: null, heard: '', answer: '', outcome: '', timings: {}, wake };
    let recording;
    try {
      live.upload = { receivedBytes: 0, expectedBytes: Number(req.headers['content-length']) || null };
      recording = await readLimited(req, MAX_RECORDING_BYTES, size => {
        live.upload.receivedBytes = size;
      });
      const encoding = req.headers['content-encoding'];
      if (encoding && encoding !== 'identity' && encoding !== 'deflate')
        throw Object.assign(new Error('Unsupported audio encoding'), { status: 415 });
      if (encoding === 'deflate') {
        recording = inflateSync(recording, { maxOutputLength: MAX_RECORDING_BYTES });
        live.upload.decodedBytes = recording.length;
      }
      try {
        const pcm = wavToPcm(recording, 16000);
        let sum = 0, squares = 0, peak = 0, clipped = 0;
        for (let i = 0; i < pcm.length; i += 2) {
          const sample = pcm.readInt16LE(i);
          sum += sample; squares += sample * sample;
          peak = Math.max(peak, Math.abs(sample));
          if (Math.abs(sample) >= 32760) clipped++;
        }
        const count = pcm.length / 2, mean = sum / count;
        live.microphone = { seconds: count / 16000, peak,
          rms: Math.round(Math.sqrt(squares / count)), dcOffset: Math.round(mean),
          speechRms: Math.round(Math.sqrt(Math.max(0, squares / count - mean * mean))),
          clippedPercent: Math.round(clipped / count * 10000) / 100 };
      }
      catch { throw Object.assign(new Error('Invalid WAV.'), { status: 400 }); }
    } catch (error) {
      busy = false; status.state = 'idle';
      stage('idle'); live.finishedAt = now(); live.outcome = 'Invalid microphone recording';
      return fail(error.status || 400, error.status === 413 ? 'Recording is too long.' : 'Expected a complete 16 kHz mono PCM16 WAV.');
    }
    if (url.searchParams.get('async') === '1') {
      // Polling avoids the ESP32 socket's 16-bit timeout overflow while the local models work.
      const current = job = { id: randomBytes(12).toString('hex'), created: now(), result: null,
        segmented: url.searchParams.get('segments') === '1', parts: [] };
      processRecording(recording, wake, current.segmented ? part => current.parts.push(part) : null, requestRobotState(req.headers)).then(result => {
        current.result = result;
        // Cached wake greetings use the same single-part protocol.
        if (current.segmented && !current.parts.length && result.status === 200) current.parts.push(result);
      });
      res.writeHead(202, { 'Content-Type': 'text/plain', 'Content-Length': current.id.length });
      return res.end(current.id);
    }
    respond(res, await processRecording(recording, wake, null, requestRobotState(req.headers)));
  });
  server.requestTimeout = 60000; server.headersTimeout = 10000;
  // Prepare fixed responses once, before accepting microphone requests.
  server.prepareSpeech = async () => {
    await wakeAudio();
    await speak(CARE_END_REPLY);
    await speak('Okay. I am here when you need me.');
  };
  // Local dashboard reads in-process; transcripts never enter the LAN status endpoint.
  server.dashboardSnapshot = () => ({ ...status, busy, awaitingWake, ...structuredClone(live),
    performance: metrics.snapshot() });
  const cleanup = setInterval(() => {
    if (!busy && now() - lastTurn > memoryTtl()) memory.clear();
    if (!busy && live.finishedAt && now() - live.finishedAt > HISTORY_TTL) {
      live = { stage: 'idle', stageAt: now(), startedAt: null, finishedAt: null, heard: '', answer: '', outcome: '', timings: {} };
    }
    if (job && now() - job.created > JOB_TTL) job = null;
  }, 30000).unref();
  server.on('close', () => clearInterval(cleanup));
  return server;
}

if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const port = Number(process.env.BAYMAX_DEVICE_PORT || 8788);
  const host = process.env.BAYMAX_DEVICE_HOST || '127.0.0.1';
  createDeviceServer().listen(port, host, () => console.log(`Baymax device server: ${host}:${port} (protocol 2).`));
}
