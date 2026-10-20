import test from 'node:test';
import assert from 'node:assert/strict';
import { replySegments, trimAudioEdges } from '../reply-audio.mjs';
test('sentence chunks preserve complete answer text', () => {
  const text = 'Hello there. How are you? I am here to help.';
  assert.deepEqual(replySegments(text), ['Hello there.', 'How are you?', 'I am here to help.']);
});
test('quiet edges trimmed with padding; internal pauses retained', () => {
  const pcm = Buffer.alloc(24000 * 2 * 3);
  for (let n = 24000; n < 48000; n++) {
    if (n < 30000 || n > 40000) pcm.writeInt16LE(500, n * 2);
  }
  const trimmed = trimAudioEdges(pcm);
  assert.equal(trimmed.length, 24000 * 2 + 3840 * 2);
  assert.equal(trimmed.readInt16LE(1920 * 2), 500);
  assert.equal(trimAudioEdges(Buffer.alloc(100)).length, 100);
});
