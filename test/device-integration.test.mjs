import test from 'node:test';
import assert from 'node:assert/strict';
import { createDeviceServer, wavToPcm } from '../device-server.mjs';
import { isWakePhrase, isGoodbye } from '../wake-response.mjs';

const token = 'test-token-'.repeat(5);
function wav(rate = 16000, samples = 1600) {
  const b = Buffer.alloc(44 + samples * 2);
  b.write('RIFF'); b.writeUInt32LE(b.length - 8, 4); b.write('WAVEfmt ', 8);
  b.writeUInt32LE(16, 16); b.writeUInt16LE(1, 20); b.writeUInt16LE(1, 22);
  b.writeUInt32LE(rate, 24); b.writeUInt32LE(rate * 2, 28);
  b.writeUInt16LE(2, 32); b.writeUInt16LE(16, 34);
  b.write('data', 36); b.writeUInt32LE(samples * 2, 40); return b;
}
async function fixture(t, overrides = {}, extra = {}) {
  const provider = { transcribe: async () => 'ouch', reply: async () => 'I am here.', speak: async () => wav(24000), ...overrides };
  const server = createDeviceServer({ env: { BAYMAX_DEVICE_TOKEN: token }, provider,
    loadWake: async () => wav(24000), ...extra });
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  t.after(() => new Promise(resolve => server.close(resolve)));
  const base = `http://127.0.0.1:${server.address().port}/device`;
  return {
    send: (path = '/turn', body = wav()) => fetch(base + path, { method: 'POST',
      headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'audio/wav' }, body }),
    get: (path, authorized = true) => fetch(base + path, { headers: authorized ? { Authorization: `Bearer ${token}` } : {} })
  };
}
test('asynchronous job stays responsive, excludes concurrent work, and returns retryable PCM', async t => {
  let release;
  const f = await fixture(t, { transcribe: () => new Promise(resolve => { release = resolve; }) });
  const accepted = await f.send('/wake?async=1');
  assert.equal(accepted.status, 202);
  const id = await accepted.text(); assert.match(id, /^[a-f0-9]{24}$/);
  assert.equal((await f.get('/result/' + id)).status, 202);
  assert.equal((await f.send()).status, 409);
  assert.equal((await f.get('/status', false)).status, 401);
  assert.equal((await f.get('/status')).status, 200);
  release('ouch');
  await new Promise(resolve => setImmediate(resolve));
  const result = await f.get('/result/' + id);
  assert.equal(result.status, 200); assert.equal(result.headers.get('x-conversation'), 'continue');
  assert.equal((await result.arrayBuffer()).byteLength, 3200);
  assert.equal((await f.get('/result/' + id)).status, 200);
  assert.equal((await f.get('/result/wrong')).status, 404);
});
test('malformed and wrong-rate input is rejected before transcription; lock recovers', async t => {
  let called = 0;
  const f = await fixture(t, { transcribe: async () => { called++; return 'hello'; } });
  assert.equal((await f.send('/turn', wav(24000))).status, 400);
  const truncated = wav().subarray(0, 60);
  assert.equal((await f.send('/turn', truncated)).status, 400);
  const badAlign = wav(); badAlign.writeUInt16LE(4, 32);
  assert.equal((await f.send('/turn', badAlign)).status, 400);
  assert.equal(called, 0);
  assert.equal((await f.send()).status, 200); assert.equal(called, 1);
});
test('recognized silence and irrelevant wake clips do not invoke chat or speech', async t => {
  let mode = 'silence';
  const f = await fixture(t, {
    transcribe: async () => {
      if (mode === 'silence') throw Object.assign(new Error('quiet'), { code: 'NO_SPEECH' });
      return 'a nice couch';
    }, reply: () => assert.fail('must not reply'), speak: () => assert.fail('must not speak')
  });
  assert.equal((await f.send('/wake')).status, 204);
  mode = 'ordinary'; assert.equal((await f.send('/wake')).status, 204);
});
test('goodbye ends conversation; history expires and stays bounded', async t => {
  let time = 1000000, transcript = 'hello', seen = [];
  const f = await fixture(t, {
    transcribe: async () => transcript,
    reply: async (_, history) => { seen.push(history.length); return 'Hello.'; }
  }, { now: () => time });
  for (let i = 0; i < 7; ++i) assert.equal((await f.send()).status, 200);
  assert.deepEqual(seen, [0, 2, 4, 6, 8, 8, 8]);
  transcript = 'goodbye';
  const bye = await f.send(); assert.equal(bye.headers.get('x-conversation'), 'end');
  transcript = 'hello'; await f.send(); assert.equal(seen.at(-1), 0);
  time += 301000; await f.send(); assert.equal(seen.at(-1), 0);
});
test('failed or overlong speech releases lock without retaining a failed turn', async t => {
  let fail = true, histories = [];
  const f = await fixture(t, {
    reply: async (_, history) => { histories.push(history.length); return 'Hello'; },
    speak: async () => fail ? wav(24000, 720001) : wav(24000)
  });
  assert.equal((await f.send()).status, 502);
  fail = false; assert.equal((await f.send()).status, 200);
  assert.deepEqual(histories, [0, 0]);
});
test('jobs expire and status never includes audio or transcripts', async t => {
  let time = 1000000;
  const f = await fixture(t, {}, { now: () => time });
  const accepted = await f.send('/wake?async=1'); const id = await accepted.text();
  await new Promise(resolve => setImmediate(resolve));
  const status = await (await f.get('/status')).json();
  assert.equal(status.protocol, 2); assert.equal(status.busy, false);
  assert.equal(JSON.stringify(status).includes('ouch'), false);
  time += 481000; assert.equal((await f.get('/result/' + id)).status, 404);
});
test('name wake, pain cries, false positives and explicit conversation endings', () => {
  for (const text of ['Baymax', 'Hey Baymax', 'ouch!', 'aaaa', 'ahhh', 'owww']) assert.ok(isWakePhrase(text), text);
  for (const text of ['couch', 'about', 'allow', 'Ah I saw that yesterday', 'how are you']) assert.equal(isWakePhrase(text), false, text);
  for (const text of ['goodbye', 'bye bye!', 'go to sleep', 'stop']) assert.ok(isGoodbye(text));
  assert.equal(isGoodbye('Do not stop talking'), false);
});
test('WAV parser rejects corrupt RIFF length and unsupported channel layouts', () => {
  const b = wav(24000); b.writeUInt32LE(1, 4); assert.throws(() => wavToPcm(b));
  const stereo = wav(24000); stereo.writeUInt16LE(2, 22); assert.throws(() => wavToPcm(stereo));
});
