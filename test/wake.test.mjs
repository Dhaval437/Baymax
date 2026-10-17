import test from 'node:test';
import assert from 'node:assert/strict';
import { isWakePhrase } from '../wake-response.mjs';
import { createDeviceServer } from '../device-server.mjs';

test('wake words include extended cries without matching ordinary words', () => {
  for (const text of ['Ouch!', 'Ouch, my foot.', 'aaa', 'AAAA!', 'aaah', 'ah', 'ow', 'owww', 'oh ow'])
    assert.equal(isWakePhrase(text), true, text);
  for (const text of ['', 'a', 'couch', 'about', 'How are you?', 'Ah that is an interesting idea'])
    assert.equal(isWakePhrase(text), false, text);
});

test('passive wake requests are authenticated, skip ordinary speech and rate-limit reactions', async t => {
  const token = 'a'.repeat(32);
  let transcript = 'Hello there', transcriptions = 0, replies = 0;
  const wav = Buffer.alloc(48);
  wav.write('RIFF'); wav.writeUInt32LE(40,4); wav.write('WAVEfmt ',8);
  wav.writeUInt32LE(16,16); wav.writeUInt16LE(1,20); wav.writeUInt16LE(1,22);
  wav.writeUInt32LE(24000,24); wav.writeUInt32LE(48000,28);
  wav.writeUInt16LE(2,32); wav.writeUInt16LE(16,34); wav.write('data',36); wav.writeUInt32LE(4,40);
  const server = createDeviceServer({env:{BAYMAX_DEVICE_TOKEN:token}, provider:{
    transcribe:async()=>{transcriptions++;return transcript;},
    reply:async()=>{replies++;return 'Must not be called';}, speak:async()=>wav
  }});
  await new Promise(resolve=>server.listen(0,'127.0.0.1',resolve));
  t.after(()=>new Promise(resolve=>server.close(resolve)));
  const recording = Buffer.from(wav);
  recording.writeUInt32LE(16000,24); recording.writeUInt32LE(32000,28);
  const send = (auth=true)=>fetch(`http://127.0.0.1:${server.address().port}/device/wake`,{
    method:'POST',headers:{'Content-Type':'audio/wav',...(auth?{Authorization:`Bearer ${token}`}:{})},body:recording
  });
  assert.equal((await send(false)).status,401);
  assert.equal(transcriptions,0);
  assert.equal((await send()).status,204);
  transcript='aaaa';
  const response=await send();
  assert.equal(response.status,200);
  assert.ok((await response.arrayBuffer()).byteLength>0);
  assert.equal((await send()).status,204);
  assert.equal(transcriptions,2);
  assert.equal(replies,0);
});
