import test from 'node:test';
import assert from 'node:assert/strict';
import { mkdtemp, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { LearningStore, learningCommand } from '../learning-store.mjs';
import { ResponseMetrics } from '../response-metrics.mjs';
test('corrections survive restart, deduplicate, and can be deleted without losing voice preference', async t => {
  const dir = await mkdtemp(join(tmpdir(), 'baymax-learning-'));
  t.after(() => rm(dir, {recursive:true,force:true}));
  const file = join(dir,'learning.json'), store = new LearningStore(file);
  await store.remember("it's paining"); await store.remember("it's paining");
  await store.voice('fast');
  const restarted = new LearningStore(file);
  assert.deepEqual(await restarted.load(), {corrections:["it's paining"],voice:'fast'});
  await restarted.forget();
  assert.deepEqual(await new LearningStore(file).load(), {corrections:[],voice:'fast'});
});
test('learning commands require explicit requests, not casual mentions', () => {
  assert.deepEqual(learningCommand('Baymax, no, I said paining, not painting.'),{kind:'correct',phrase:'paining'});
  assert.deepEqual(learningCommand('Remember this correction'),{kind:'save'});
  assert.deepEqual(learningCommand('Use fast voice'),{kind:'voice',mode:'fast'});
  for (const text of ['Do not remember this correction','Can you explain fast voice?', 'My arm is paining'])
    assert.equal(learningCommand(text),null);
});
test('timing recommendations use completed preparation stages and remain bounded', () => {
  const m=new ResponseMetrics();
  m.record({synthesizing:4000,receiving:100});
  assert.match(m.snapshot().recommendation,/three/);
  for(let i=0;i<25;i++) m.record({synthesizing:4000,receiving:100});
  assert.equal(m.snapshot().samples,20);
  assert.match(m.snapshot().recommendation,/fast voice/);
  assert.equal(m.snapshot().averages.synthesizing,4000);
});
