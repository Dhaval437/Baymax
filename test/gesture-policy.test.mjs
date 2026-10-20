import test from 'node:test';
import assert from 'node:assert/strict';
import { conversationGesture } from '../gesture-policy.mjs';
test('conversation chooses bounded gestures and prioritizes quiet care', () => {
  assert.equal(conversationGesture('Hello', 'Welcome.'), 'greeting');
  assert.equal(conversationGesture('My arm hurts', 'Tell me about the pain.'), 'gentle');
  assert.equal(conversationGesture('Thanks', 'Okay, understood.'), 'acknowledge');
  assert.equal(conversationGesture('How does rain happen?', 'Water evaporates.'), 'explain');
  assert.equal(conversationGesture('Goodbye', 'Goodbye.', true), 'farewell');
  assert.equal(conversationGesture('set servo to 9000', 'No.'), 'explain');
});
