import test from 'node:test';
import assert from 'node:assert/strict';
import { EventEmitter } from 'node:events';
import { PassThrough, Writable } from 'node:stream';
import { SpeechWorker } from '../local-speech-worker.mjs';

function fixture(timeout=1000) {
  const children=[];
  const worker=new SpeechWorker({timeout,spawnWorker:()=>{
    const child=new EventEmitter();child.requests=[];child.stdout=new PassThrough();child.stderr=new PassThrough();
    child.stdin=new Writable({write(chunk,_,done){child.requests.push(JSON.parse(chunk));done()}});
    child.kill=()=>{child.killed=true;child.emit('exit',0)};children.push(child);return child;
  }});
  return {worker,children};
}
test('speech engine reuses one process and pairs fragmented responses with requests', async t=>{
  const {worker,children}=fixture();t.after(()=>worker.close());
  const first=worker.request('warm'), second=worker.request('speak',{text:'Hello',output:'test.wav'});
  assert.equal(children.length,1);const child=children[0];assert.equal(child.requests.length,2);
  const line=JSON.stringify({id:child.requests[0].id,ok:true,result:{ready:true}})+'\n';
  child.stdout.write(line.slice(0,13));child.stdout.write(line.slice(13));await first;
  child.stdout.write(JSON.stringify({id:child.requests[1].id,ok:true,result:{audioSeconds:1}})+'\n');
  assert.equal((await second).result.audioSeconds,1);assert.equal(worker.state,'ready');assert.equal(worker.pending.size,0);
});
test('crash rejects pending work and the next request starts a clean engine', async t=>{
  const {worker,children}=fixture();t.after(()=>worker.close());
  const pending=worker.request('warm');const rejected=assert.rejects(pending,/stopped/);children[0].emit('exit',1);await rejected;
  const next=worker.request('warm');assert.equal(children.length,2);
  children[1].stdout.write(JSON.stringify({id:children[1].requests[0].id,ok:true,result:{ready:true}})+'\n');await next;
});
test('timed-out speech kills the worker and clears its queue', async()=>{
  const {worker,children}=fixture(20);await assert.rejects(worker.request('warm'),/closed|timed out/);
  assert.equal(children[0].killed,true);assert.equal(worker.pending.size,0);assert.equal(worker.child,null);
});
test('a model operation error is reported without echoing the spoken text',async t=>{
  const {worker,children}=fixture();t.after(()=>worker.close());
  const pending=worker.request('speak',{text:'private test phrase'});
  children[0].stdout.write(JSON.stringify({id:children[0].requests[0].id,ok:false,error:'Local speech operation failed: RuntimeError'})+'\n');
  await assert.rejects(pending,e=>/RuntimeError/.test(e.message)&&!e.message.includes('private test phrase'));
});
