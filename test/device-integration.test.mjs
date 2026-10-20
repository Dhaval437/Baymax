import test from 'node:test';
import assert from 'node:assert/strict';
import { createDeviceServer, wavToPcm } from '../device-server.mjs';
import { isWakePhrase, isGoodbye } from '../wake-response.mjs';
import { deflateSync } from 'node:zlib';

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
    send: (path = '/turn', body = wav(), headers = {}) => fetch(base + path, { method: 'POST',
      headers: { Authorization: `Bearer ${token}`, 'Content-Type': 'audio/wav', ...headers }, body }),
    get: (path, authorized = true) => fetch(base + path, { headers: authorized ? { Authorization: `Bearer ${token}` } : {} })
  };
}
test('lossless compressed recordings preserve samples and reject corrupt or oversized streams', async t => {
  const recording = wav(); let calls = 0;
  const f = await fixture(t, { transcribe: async bytes => {
    calls++; assert.deepEqual(bytes, recording); return 'ouch';
  }});
  assert.equal((await f.send('/wake', deflateSync(recording), {'Content-Encoding':'deflate'})).status, 200);
  assert.equal(calls, 1);
  assert.equal((await f.send('/wake', Buffer.from('invalid'), {'Content-Encoding':'deflate'})).status, 400);
  assert.equal((await f.send('/wake', deflateSync(Buffer.alloc(2000000)), {'Content-Encoding':'deflate'})).status, 400);
  assert.equal(calls, 1);
  assert.equal((await f.send('/wake', recording)).status, 200);
});
test('spoken corrections require a separate save and do not replace unrelated transcripts', async t => {
  let text = 'My heart is beating fast.', saved = [], answer = '';
  const learning = { load:async()=>({voice:'character',corrections:saved}),
    remember:async phrase=>saved.push(phrase), forget:async()=>{saved=[];} };
  const f = await fixture(t, {transcribe:async()=>text,
    reply:async()=> 'Could you tell me more?', speak:async value=>{answer=value;return wav(24000);}},
    {learning});
  assert.equal((await f.send()).status,200);
  text='What did you hear?'; await f.send();
  assert.match(answer,/My heart is beating fast/);
  text='No, I said my arm is paining, not painting.'; await f.send();
  assert.deepEqual(saved,[]);
  text='Remember this correction'; await f.send();
  assert.deepEqual(saved,['my arm is paining']);
  text='Forget my corrections'; await f.send();
  assert.deepEqual(saved,[]);
});
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
test('first sentence can play while the next is generating; parts are retryable', async t => {
  let release;
  const f = await fixture(t, {
    transcribe: async () => 'Explain something.',
    reply: async () => 'First sentence. Second sentence.',
    speak: async text => {
      if (text === 'Second sentence.') await new Promise(resolve => { release = resolve; });
      return wav(24000);
    }
  });
  const accepted = await f.send('/turn?async=1&segments=1');
  const id = await accepted.text();
  for (let n = 0; n < 20 && !release; n++) await new Promise(r => setTimeout(r, 5));
  assert.ok(release);
  const first = await f.get(`/result/${id}?part=0`);
  assert.equal(first.status, 200); assert.equal(first.headers.get('x-reply-more'), '1');
  assert.equal((await f.get(`/result/${id}?part=1`)).status, 202);
  assert.equal((await f.get(`/result/${id}?part=0`)).status, 200);
  assert.equal((await f.send()).status, 409);
  release();
  await new Promise(r => setImmediate(r));
  const last = await f.get(`/result/${id}?part=1`);
  assert.equal(last.status, 200); assert.equal(last.headers.get('x-reply-more'), '0');
  assert.equal((await f.get(`/result/${id}?part=2`)).status, 404);
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
test('ouch uses cached wake response even during conversation and repeated wake requests', async t => {
  const f = await fixture(t, {
    transcribe: async () => 'ouch',
    reply: async () => { throw new Error('Short ouch must not wait for the language model'); },
    speak: async () => { throw new Error('Cached greeting must not be synthesized'); }
  });
  assert.equal((await f.send('/turn')).status, 200);
  assert.equal((await f.send('/wake')).status, 200);
  assert.equal((await f.send('/wake')).status, 200);
});
test('check status works without a wake word and never asks the language model', async t => {
  let spoken;
  const f = await fixture(t, {
    transcribe: async () => 'check status',
    reply: async () => { throw new Error('Status must be factual'); },
    speak: async text => { spoken = text; return wav(24000); }
  });
  const result = await f.send('/wake');
  assert.equal(result.status, 200);
  assert.equal(result.headers.get('x-conversation'), 'end');
  assert.match(spoken, /request reached the server/);
  assert.match(spoken, /Motor status is unavailable/);
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
  assert.deepEqual(seen, [0, 2, 4, 6, 8, 10, 12]);
  transcript = 'goodbye';
  const bye = await f.send(); assert.equal(bye.headers.get('x-conversation'), 'end');
  transcript = 'hello'; assert.equal((await f.send()).status, 204);
  transcript = 'Baymax'; await f.send('/wake');
  transcript = 'hello'; await f.send(); assert.equal(seen.at(-1), 0);
  time += 361000; await f.send(); assert.equal(seen.at(-1), 0);
});

test('care completion says farewell, clears memory and ignores speech until wake even on the turn route', async t => {
  let transcript = 'Please remember my robot is blue.', replies = 0, said = [], histories = [];
  const f = await fixture(t, {
    transcribe: async () => transcript,
    reply: async (_, history) => { replies++; histories.push(history); return 'I understand.'; },
    speak: async text => { said.push(text); return wav(24000); }
  });
  await f.send();
  transcript = 'I am satisfied with my care.';
  const end = await f.send();
  assert.equal(end.headers.get('x-conversation'), 'end');
  assert.match(said.at(-1), /Say Baymax to wake me again/);
  assert.equal((await (await f.get('/status')).json()).awaitingWake, true);
  transcript = 'Tell me a joke';
  assert.equal((await f.send()).status, 204);
  assert.equal((await f.send('/wake')).status, 204);
  assert.equal(replies, 1);
  transcript = 'ouch';
  assert.equal((await f.send('/wake')).status, 200);
  assert.equal((await (await f.get('/status')).json()).awaitingWake, false);
  transcript = 'Hello again'; await f.send();
  assert.equal(histories.at(-1).length, 0);
});

test('care completion still silences ordinary replies if farewell audio fails', async t => {
  let transcript = 'I am satisfied with my care', broken = true;
  const f = await fixture(t, {
    transcribe: async () => transcript,
    reply: () => assert.fail('No chat while awaiting wake'),
    speak: async () => { if (broken) throw Error('TTS unavailable'); return wav(24000); }
  });
  assert.equal((await f.send()).status, 502);
  transcript = 'Are you there?'; assert.equal((await f.send()).status, 204);
  broken = false; transcript = 'Baymax';
  assert.equal((await f.send('/wake')).status, 200);
});
test('failed or overlong speech releases lock without retaining a failed turn', async t => {
  let fail = true, histories = [];
  const f = await fixture(t, {
    transcribe: async () => 'Tell me about robots.',
    reply: async (_, history) => { histories.push(history.length); return 'Hello'; },
    speak: async () => fail ? wav(24000, 1440001) : wav(24000)
  });
  assert.equal((await f.send()).status, 502);
  fail = false; assert.equal((await f.send()).status, 200);
  assert.deepEqual(histories, [0, 0]);
});

test('wake resumes memory and extended utterances and complete replies survive', async t => {
  let transcript = 'My project is a blue robot.', histories = [], answers = [];
  const answer = 'This is a complete sentence about the blue robot and its carefully assembled mechanical parts. '.repeat(5).trim();
  const f = await fixture(t, {
    transcribe: async () => transcript,
    reply: async (_, history) => { histories.push(history); return answer; },
    speak: async text => { answers.push(text); return wav(24000); }
  });
  assert.equal((await f.send('/turn', wav(16000, 16000 * 20))).status, 200);
  assert.equal(answers[0], answer); assert.ok(answers[0].length > 300);
  transcript = 'Baymax'; assert.equal((await f.send('/wake')).status, 200);
  transcript = 'What color was my project?';
  const result = await f.send();
  assert.equal(result.status, 200);
  assert.match(histories.at(-1)[0].content, /blue robot/);
  assert.ok(Number(result.headers.get('x-conversation-window-ms')) >= 30000);
});

test('a question spoken with the wake name is answered rather than discarded', async t => {
  let seen;
  const f = await fixture(t, {
    transcribe: async () => 'Baymax what is that?',
    reply: async text => { seen = text; return 'Your controller coordinates the motors and audio.'; }
  });
  assert.equal((await f.send('/wake')).status, 200);
  assert.match(seen, /what is that/);
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
