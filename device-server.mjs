import http from 'node:http';
import { timingSafeEqual, randomBytes } from 'node:crypto';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';
import { readFile } from 'node:fs/promises';
import { createLocalProvider } from './local-provider.mjs';
import { isWakePhrase, isGoodbye, WAKE_REPLY } from './wake-response.mjs';

const MAX_RECORDING_BYTES = 8 * 16000 * 2 + 44;
const MAX_REPLY_BYTES = 30 * 24000 * 2;
const HISTORY_TTL = 5 * 60 * 1000;
const JOB_TTL = 8 * 60 * 1000;
const AUDIO_HEADERS = { 'Content-Type': 'application/octet-stream',
  'X-Audio-Format': 's16le; rate=24000; channels=1' };

function sameToken(received, expected) {
  if (!received?.startsWith('Bearer ') || !expected || expected.length < 32) return false;
  const a = Buffer.from(received.slice(7)), b = Buffer.from(expected);
  return a.length === b.length && timingSafeEqual(a, b);
}

async function readLimited(req, limit) {
  if (Number(req.headers['content-length']) > limit)
    throw Object.assign(new Error('Recording is too long.'), { status: 413 });
  const chunks = []; let size = 0;
  for await (const chunk of req) {
    size += chunk.length;
    if (size > limit) throw Object.assign(new Error('Recording is too long.'), { status: 413 });
    chunks.push(chunk);
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
  loadWake = () => readFile(new URL('./.cache/wake-greeting.wav', import.meta.url)) } = {}) {
  const token = env.BAYMAX_DEVICE_TOKEN;
  if (!token || token.length < 32) throw new Error('Set BAYMAX_DEVICE_TOKEN to at least 32 random characters.');
  let busy = false, lastWake = -Infinity, lastTurn = -Infinity, wakePcm, job;
  const history = [];
  const status = { state: 'idle', completed: 0, lastError: null };
  let live = { stage: 'idle', stageAt: now(), startedAt: null, finishedAt: null, heard: '', answer: '', outcome: '', timings: {} };
  const stage = name => {
    if (live.startedAt && live.stage !== 'idle') live.timings[live.stage] = now() - live.stageAt;
    live.stage = name; live.stageAt = now();
  };
  async function wakeAudio() {
    if (!wakePcm) {
      try { wakePcm = wavToPcm(await loadWake()); }
      catch { wakePcm = wavToPcm(await provider.speak(WAKE_REPLY)); }
    }
    return wakePcm;
  }
  async function processRecording(recording, wake) {
    try {
      status.state = 'transcribing';
      stage('transcribing');
      const transcript = await provider.transcribe(recording, 'audio/wav');
      if (typeof transcript !== 'string') throw new Error('Invalid transcript');
      const heard = transcript.trim();
      live.heard = heard.slice(0, 1000);
      if (!heard || (wake && !isWakePhrase(heard))) { live.outcome = heard ? 'No wake phrase recognised. Try Baymax or ouch.' : 'No speech recognised.'; return { status: 204 }; }
      if (now() - lastTurn > HISTORY_TTL || wake) history.length = 0;
      let pcm, end = false, answer;
      if (wake) {
        status.state = 'greeting'; stage('synthesizing'); live.answer = WAKE_REPLY; pcm = await wakeAudio(); answer = WAKE_REPLY;
      } else {
        end = isGoodbye(heard); status.state = 'thinking';
        stage('thinking');
        answer = end ? 'Okay. I am here when you need me.' : String(await provider.reply(heard, history.slice())).trim().slice(0, 300);
        if (!answer) throw new Error('Empty reply');
        live.answer = answer; stage('synthesizing');
        status.state = 'speaking'; pcm = wavToPcm(await provider.speak(answer));
      }
      if (pcm.length > MAX_REPLY_BYTES) throw new Error('Voice exceeds 30-second playback limit');
      lastTurn = now(); if (wake) lastWake = now();
      if (end) history.length = 0;
      else {
        history.push({ role: 'user', content: heard.slice(0, 1000) }, { role: 'assistant', content: answer });
        if (history.length > 8) history.splice(0, history.length - 8);
      }
      status.completed++;
      live.outcome = 'Audio ready for the robot'; live.audioSeconds = pcm.length / 48000;
      return { status: 200, pcm, end };
    } catch (error) {
      if (error.code === 'NO_SPEECH') { live.outcome = 'No speech recognised.'; return { status: 204 }; }
      status.lastError = 'Speech processing failed. Check local model services.';
      console.error(status.lastError);
      live.outcome = status.lastError;
      return { status: 502 };
    } finally { stage('idle'); live.finishedAt = now(); status.state = 'idle'; busy = false; }
  }
  function respond(res, result) {
    if (result.status === 200) {
      res.writeHead(200, { ...AUDIO_HEADERS, 'Content-Length': result.pcm.length,
        'X-Conversation': result.end ? 'end' : 'continue' });
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
      return res.end(JSON.stringify({ ...status, busy, mode: 'local', protocol: 2 }));
    }
    if (req.method === 'GET' && url.pathname.startsWith('/device/result/')) {
      if (!job || url.pathname !== `/device/result/${job.id}` || now() - job.created > JOB_TTL)
        return fail(404, 'Result expired.');
      return respond(res, job.result || { status: 202 });
    }
    const wake = url.pathname === '/device/wake';
    if (req.method !== 'POST' || (!wake && url.pathname !== '/device/turn')) return fail(404, 'Not found.');
    if (busy) return fail(409, 'Baymax is busy.');
    if (wake && now() - lastWake < 20000) { res.writeHead(204); return res.end(); }
    if (req.headers['content-type']?.split(';')[0] !== 'audio/wav') return fail(415, 'Send a WAV recording.');
    busy = true; status.lastError = null; status.state = 'receiving';
    live = { stage: 'receiving', stageAt: now(), startedAt: now(), finishedAt: null, heard: '', answer: '', outcome: '', timings: {}, wake };
    let recording;
    try {
      recording = await readLimited(req, MAX_RECORDING_BYTES);
      try { wavToPcm(recording, 16000); }
      catch { throw Object.assign(new Error('Invalid WAV.'), { status: 400 }); }
    } catch (error) {
      busy = false; status.state = 'idle';
      stage('idle'); live.finishedAt = now(); live.outcome = 'Invalid microphone recording';
      return fail(error.status || 400, error.status === 413 ? 'Recording is too long.' : 'Expected a complete 16 kHz mono PCM16 WAV.');
    }
    if (url.searchParams.get('async') === '1') {
      // Polling avoids the ESP32 socket's 16-bit timeout overflow while the local models work.
      const current = job = { id: randomBytes(12).toString('hex'), created: now(), result: null };
      processRecording(recording, wake).then(result => { current.result = result; });
      res.writeHead(202, { 'Content-Type': 'text/plain', 'Content-Length': current.id.length });
      return res.end(current.id);
    }
    respond(res, await processRecording(recording, wake));
  });
  server.requestTimeout = 15000; server.headersTimeout = 10000;
  // Local dashboard reads in-process; transcripts never enter the LAN status endpoint.
  server.dashboardSnapshot = () => ({ ...status, busy, ...structuredClone(live) });
  const cleanup = setInterval(() => {
    if (!busy && now() - lastTurn > HISTORY_TTL) history.length = 0;
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
