import test from 'node:test';
import assert from 'node:assert/strict';
import {companionReply, CARE_GUIDES} from '../companion-replies.mjs';
import {createLocalProvider} from '../local-provider.mjs';

test('common-care answers use source-backed text without asking the model for treatment', async () => {
  const p=createLocalProvider({},()=>assert.fail('Health guide must bypass generative model'));
  for(const prompt of ['I have a small cut','What do I do for a small burn?','I have a cold','What helps a mild headache?','What is dehydration?']) {
    const answer=await p.reply(prompt,[]);
    assert.ok(CARE_GUIDES.some(g=>g.answer===answer));
    assert.doesNotMatch(answer,/toothpaste|ha ha|\d+\s*mg/i);
    assert.ok(answer.split(/\s+/).length<=110);
  }
});
test('urgent concerns precede jokes and dosing is not generated', () => {
  assert.match(companionReply('I have chest pain and trouble breathing. Tell me a joke.'),/emergency/);
  assert.match(companionReply('How much insulin should I inject?'),/prescriber or pharmacist/);
  assert.match(companionReply('My headache is getting worse'),/medical assessment/);
  assert.match(companionReply('My baby has a burn'),/medical assessment/);
});
test('health followups use the previous concern without hijacking a new technical topic', () => {
  const history=[{role:'user',content:'I have a mild headache'},{role:'assistant',content:CARE_GUIDES.find(g=>g.id==='headache').answer}];
  assert.match(companionReply('It is getting worse',history),/medical assessment/);
  assert.equal(companionReply('How do I cut the printed robot arm?',history),null);
  assert.equal(companionReply('What is the capital of France?',history),null);
});
test('jokes and spoken laughter are short and explicit', () => {
  assert.match(companionReply('Tell me a joke',[],()=>0),/recharge/);
  assert.match(companionReply('Please laugh for me'),/^Ha ha\./);
  assert.doesNotMatch(companionReply('Please laugh for me'),/\[/);
});
