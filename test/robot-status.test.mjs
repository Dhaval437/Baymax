import test from 'node:test';
import assert from 'node:assert/strict';
import { normalizeRobotTranscript, isWakePhrase, isDistressCue, isStatusRequest } from '../wake-response.mjs';
import { requestRobotState, spokenRobotStatus } from '../robot-status.mjs';
test('robot name variants normalize without rewriting ordinary Max references', () => {
  for (const name of ['Bay Max', 'Be Max', 'B-E M-A-X', 'B A Y M A X', 'Max', 'Hey Max'])
    assert.equal(isWakePhrase(normalizeRobotTranscript(name)), true, name);
  assert.equal(normalizeRobotTranscript('My friend Max likes robots.'), 'My friend Max likes robots.');
  assert.equal(isWakePhrase(normalizeRobotTranscript('Set the max volume.')), false);
  assert.equal(isDistressCue('Ow!'), true);
  assert.equal(isDistressCue('ouch'), true);
  assert.equal(isStatusRequest(normalizeRobotTranscript('Bay Max, check status')), true);
  assert.equal(isStatusRequest('please check your status'), true);
  assert.equal(isStatusRequest('checks status'), true);
  assert.equal(isStatusRequest('Do not check status'), false);
});
test('status distinguishes disabled, unavailable and unreported motor state', () => {
  const state = requestRobotState({'x-baymax-motion':'1','x-baymax-pca':'1','x-baymax-conversation':'0'});
  const text = spokenRobotStatus(state);
  assert.match(text, /Motor control is enabled/);
  assert.match(text, /waiting for a wake word/);
  assert.match(spokenRobotStatus(requestRobotState({})), /Motor status is unavailable/);
  assert.match(spokenRobotStatus({controllerAvailable:false}), /not responding/);
});
