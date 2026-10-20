import test from 'node:test';
import assert from 'node:assert/strict';
import { cachedSpeech } from '../speech-cache.mjs';
test('audio is reused only for identical answers, with bounded eviction', async () => {
  let calls = 0;
  const speak = cachedSpeech(async text => { calls++; return Buffer.from(text); }, 8);
  await speak('yes'); await speak('yes');
  assert.equal(calls, 1);
  await speak('no');
  assert.equal(calls, 2);
  await speak('later'); // evicts yes
  await speak('yes');
  assert.equal(calls, 4);
});
test('failed synthesis is retryable and oversized audio is not retained', async () => {
  let calls = 0;
  const speak = cachedSpeech(async () => {
    if (++calls === 1) throw new Error('temporary');
    return Buffer.alloc(10);
  }, 4);
  await assert.rejects(speak('hello'));
  await speak('hello'); await speak('hello');
  assert.equal(calls, 3);
});
