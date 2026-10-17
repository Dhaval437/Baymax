// Actual local STT -> chat -> TTS via async device API. No serial or physical outputs.
import { readFile, writeFile, mkdir } from 'node:fs/promises';
import { createDeviceServer, wavToPcm } from '../device-server.mjs';
import { warmLocalSpeech, closeLocalSpeech } from '../local-speech-worker.mjs';
const root = new URL('../', import.meta.url);
const source = wavToPcm(await readFile(new URL('voice-sample-smooth-v2.wav', root)));
const count = Math.floor(source.length / 2 * 16000 / 24000), wav = Buffer.alloc(44 + count * 2);
wav.write('RIFF'); wav.writeUInt32LE(wav.length - 8, 4); wav.write('WAVEfmt ', 8);
wav.writeUInt32LE(16, 16); wav.writeUInt16LE(1, 20); wav.writeUInt16LE(1, 22);
wav.writeUInt32LE(16000, 24); wav.writeUInt32LE(32000, 28); wav.writeUInt16LE(2, 32); wav.writeUInt16LE(16, 34);
wav.write('data', 36); wav.writeUInt32LE(count * 2, 40);
for (let n = 0; n < count; n++) {
  const at = n * 1.5, lo = Math.floor(at), hi = Math.min(lo + 1, source.length / 2 - 1);
  wav.writeInt16LE(Math.round(source.readInt16LE(lo * 2) * (1 - (at - lo)) + source.readInt16LE(hi * 2) * (at - lo)), 44 + n * 2);
}
const server = createDeviceServer();
await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
let passed = false;
try {
  await warmLocalSpeech();
  const base = `http://127.0.0.1:${server.address().port}/device`;
  const headers = { Authorization: `Bearer ${process.env.BAYMAX_DEVICE_TOKEN}` };
  const response = await fetch(base + '/turn?async=1', { method: 'POST', headers: { ...headers, 'Content-Type': 'audio/wav' }, body: wav });
  if (response.status !== 202) throw new Error('Job not accepted');
  const id = await response.text(), started = Date.now();
  let previous = '';
  while (Date.now() - started < 420000) {
    const status = await (await fetch(base + '/status', { headers })).json();
    if (status.state !== previous) { console.log('Live smoke test: ' + status.state); previous = status.state; }
    const result = await fetch(base + '/result/' + id, { headers });
    if (result.status === 202) { await new Promise(resolve => setTimeout(resolve, 1500)); continue; }
    if (result.status !== 200) throw new Error('Speech pipeline returned HTTP ' + result.status);
    const pcm = Buffer.from(await result.arrayBuffer());
    if (!pcm.length || pcm.length % 2) throw new Error('Invalid returned PCM');
    await mkdir(new URL('assembly/verification/', root), { recursive: true });
    const report = { date: new Date().toISOString(), passed: true,
      stages: ['WAV upload', 'local transcription', 'local chat', 'local speech synthesis', 'async PCM download'],
      pcmBytes: pcm.length, seconds: pcm.length / 48000, elapsedSeconds: (Date.now() - started) / 1000,
      physicalPlaybackTested: false, motorsMoved: false };
    await writeFile(new URL('assembly/verification/integrated-smoke.json', root), JSON.stringify(report, null, 2));
    console.log(`PASS: speech pipeline returned ${report.seconds.toFixed(2)} seconds of PCM. No hardware activated.`);
    passed = true; break;
  }
  if (!passed) throw new Error('Smoke test timed out');
} catch (error) { console.error(error.message); process.exitCode = 1; }
finally { closeLocalSpeech(); await new Promise(resolve => server.close(resolve)); }
