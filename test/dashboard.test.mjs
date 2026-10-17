import test from 'node:test';
import assert from 'node:assert/strict';
import http from 'node:http';
import { createTelemetry, createRobotDashboard } from '../robot-dashboard.mjs';
import { createDeviceServer } from '../device-server.mjs';

test('serial telemetry requires integrated identity, preserves real gaps and expires', () => {
  let now=10000; const t=createTelemetry(()=>now);
  t.accept({connected:true,port:'COM14'});
  t.accept({line:'LEVEL rms=9 trigger=450 mode=wake'});
  assert.equal(t.snapshot().samples.length,0);
  t.accept({line:'BAYMAX v2 state=listening listening=1 conversation=0 wifi=1 pca=1 motion_enabled=0 moving=0'});
  t.accept({line:'LEVEL rms=900 trigger=450 mode=wake'});
  assert.equal(t.snapshot().samples[0].rms,900);assert.equal(t.snapshot().fresh,true);
  now+=8000;assert.equal(t.snapshot().fresh,false);assert.equal(t.snapshot().samples.length,1);
  t.accept({line:'Reply played. Speak your answer after a short pause.'});
  assert.equal(t.snapshot().playbackFinishedAt,now);
  t.accept({connected:false,port:'COM14'});assert.equal(t.snapshot().verified,false);
});
test('dashboard is read-only, rejects foreign origins/hosts, renders no credentials', async t => {
  const server=createRobotDashboard({dashboardSnapshot:()=>({heard:'hello',answer:'Hi'})},{startSerial:false});
  await new Promise(r=>server.listen(0,'127.0.0.1',r));t.after(()=>new Promise(r=>server.close(r)));
  const base=`http://127.0.0.1:${server.address().port}`;
  const result=await fetch(base+'/state');assert.equal(result.status,200);assert.equal((await result.json()).speech.answer,'Hi');
  assert.equal((await fetch(base+'/state',{headers:{Origin:'https://elsewhere.example'}})).status,403);
  const foreignHostStatus = await new Promise((resolve,reject)=>{ const req=http.get(base+'/state',{headers:{Host:'elsewhere.example'}},res=>{res.resume();resolve(res.statusCode)});req.on('error',reject); });
  assert.equal(foreignHostStatus,403);
  assert.equal((await fetch(base+'/state',{method:'POST'})).status,405);
  const page=await (await fetch(base)).text();assert.ok(page.includes('Microphone signal'));assert.ok(!page.includes('DEVICE_TOKEN'));
});
test('live transcript and timings stay local while authenticated LAN status remains redacted', async t => {
  let tick=1000, release;const token='dashboard-test-token'.repeat(3);
  const wav=Buffer.alloc(48);wav.write('RIFF');wav.writeUInt32LE(40,4);wav.write('WAVEfmt ',8);wav.writeUInt32LE(16,16);wav.writeUInt16LE(1,20);wav.writeUInt16LE(1,22);wav.writeUInt32LE(16000,24);wav.writeUInt32LE(32000,28);wav.writeUInt16LE(2,32);wav.writeUInt16LE(16,34);wav.write('data',36);wav.writeUInt32LE(4,40);
  const audio=Buffer.from(wav);audio.writeUInt32LE(24000,24);audio.writeUInt32LE(48000,28);
  const server=createDeviceServer({env:{BAYMAX_DEVICE_TOKEN:token},now:()=>tick,provider:{transcribe:async()=>{tick+=100;return 'What can you do?';},reply:()=>new Promise(r=>{release=r}),speak:async()=>{tick+=300;return audio}}});
  await new Promise(r=>server.listen(0,'127.0.0.1',r));t.after(()=>new Promise(r=>server.close(r)));
  const base=`http://127.0.0.1:${server.address().port}/device`,headers={Authorization:`Bearer ${token}`,'Content-Type':'audio/wav'};
  const response=await fetch(base+'/turn?async=1',{method:'POST',headers,body:wav});assert.equal(response.status,202);
  assert.equal(server.dashboardSnapshot().heard,'What can you do?');assert.equal(server.dashboardSnapshot().stage,'thinking');
  const status=await(await fetch(base+'/status',{headers})).json();assert.equal(status.heard,undefined);assert.equal(status.answer,undefined);
  tick+=200;release('I can talk with you.');await new Promise(r=>setImmediate(r));
  const live=server.dashboardSnapshot();assert.equal(live.answer,'I can talk with you.');assert.equal(live.timings.transcribing,100);assert.equal(live.timings.thinking,200);assert.equal(live.timings.synthesizing,300);assert.equal(live.finishedAt-live.startedAt,600);
});
