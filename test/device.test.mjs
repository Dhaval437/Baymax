import test from 'node:test';
import assert from 'node:assert/strict';
import { createDeviceServer, wavToPcm } from '../device-server.mjs';

const token = '0123456789abcdef0123456789abcdef';
function wav(payload = Buffer.from([0, 0, 1, 0]), rate = 24000) {
  const out = Buffer.alloc(44 + payload.length);
  out.write('RIFF'); out.writeUInt32LE(out.length - 8, 4); out.write('WAVE', 8);
  out.write('fmt ', 12); out.writeUInt32LE(16, 16); out.writeUInt16LE(1, 20);
  out.writeUInt16LE(1, 22); out.writeUInt32LE(rate, 24);
  out.writeUInt32LE(rate * 2, 28); out.writeUInt16LE(2, 32); out.writeUInt16LE(16, 34);
  out.write('data', 36); out.writeUInt32LE(payload.length, 40); payload.copy(out, 44);
  return out;
}

test('device server requires its separate bearer token and returns raw speech samples', async t => {
  const calls = [];
  const server = createDeviceServer({ env: { BAYMAX_DEVICE_TOKEN: token }, provider: {
    transcribe: async (audio, mime) => { calls.push(['transcribe', audio.length, mime]); return 'Hello'; },
    reply: async (text, history) => { calls.push(['reply', text, history.length]); return 'Hello. I am here.'; },
    speak: async text => { calls.push(['speak', text]); return wav(); }
  }});
  await new Promise(done => server.listen(0, '127.0.0.1', done));
  t.after(() => new Promise(done => server.close(done)));
  const url = `http://127.0.0.1:${server.address().port}/device/turn`;
  const body = wav(Buffer.alloc(100), 16000);
  const pingUrl = url.replace('/turn', '/ping');
  assert.equal((await fetch(pingUrl)).status, 401);
  assert.equal((await fetch(pingUrl, { headers: { Authorization: `Bearer ${token}` } })).status, 204);
  const send = authorization => fetch(url, { method: 'POST', headers: {
    'Content-Type': 'audio/wav', ...(authorization ? { Authorization: authorization } : {})
  }, body });
  assert.equal((await send()).status, 401);
  assert.equal((await send('Bearer wrong')).status, 401);
  assert.equal(calls.length, 0);
  const response = await send(`Bearer ${token}`);
  assert.equal(response.status, 200);
  assert.equal(response.headers.get('x-audio-format'), 's16le; rate=24000; channels=1');
  assert.deepEqual(Buffer.from(await response.arrayBuffer()), Buffer.from([0, 0, 1, 0]));
  assert.deepEqual(calls, [['transcribe', 144, 'audio/wav'], ['reply', 'Hello', 0], ['speak', 'Hello. I am here.']]);
  await send(`Bearer ${token}`);
  assert.equal(calls.filter(c => c[0] === 'reply').at(-1)[2], 2);
  assert.equal(calls.filter(c => c[0] === 'speak').length, 1); // same answer reuses audio, not conversation context
});

test('device server rejects oversized recordings before inference', async t => {
  const server = createDeviceServer({ env: { BAYMAX_DEVICE_TOKEN: token }, provider: {
    transcribe() { throw Error('must not infer'); }
  }});
  await new Promise(done => server.listen(0, '127.0.0.1', done));
  t.after(() => new Promise(done => server.close(done)));
  const response = await fetch(`http://127.0.0.1:${server.address().port}/device/turn`, {
    method: 'POST', headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'audio/wav' },
    body: Buffer.alloc(60 * 16000 * 2 + 45)
  });
  assert.equal(response.status, 413);
});

test('WAV parser accepts PCM and rejects mismatched audio', () => {
  assert.equal(wavToPcm(wav()).length, 4);
  assert.throws(() => wavToPcm(wav(Buffer.from([0, 0]), 16000)), /24 kHz/);
});
