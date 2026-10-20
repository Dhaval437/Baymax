import test from 'node:test';
import assert from 'node:assert/strict';
import { ConversationMemory, messagesCost, tokenCost, replyProfile, spokenReply, followupWindow } from '../conversation-policy.mjs';
import { createLocalProvider } from '../local-provider.mjs';

async function add(memory, user, answer = 'Understood.', summarize) {
  const prepared = await memory.prepare(user, summarize);
  memory.commit(prepared, user, answer);
  return prepared;
}
test('many short turns stay verbatim without unnecessary summary work', async () => {
  const m = new ConversationMemory();
  for (let i = 0; i < 15; i++) await add(m, 'Item ' + i, 'Noted.', () => assert.fail('no compaction needed'));
  const p = await m.prepare('What was item zero?');
  assert.equal(p.messages.length, 30);
  assert.equal(p.messages[0].content, 'Item 0');
  assert.equal(m.compactions, 0);
});
test('long discussion compacts by size, retaining early facts and latest corrections', async () => {
  const m = new ConversationMemory(); let calls = 0;
  const summarize = async (previous, messages) => {
    calls++;
    assert.ok(messages.some(x => x.content.includes('blue robot')) || previous.includes('blue robot'));
    return 'User is building a blue robot. Original budget was 2000. Follow latest messages for corrected budget.';
  };
  await add(m, 'I am building a blue robot with budget 2000.');
  for (let i = 0; i < 24; i++) await add(m, 'Assembly detail ' + i + ': ' + 'The arm needs room to turn without hitting the body. '.repeat(8), 'Noted.', summarize);
  await add(m, 'Correction: the budget is now 3000, not 2000.', 'I understand the correction.', summarize);
  const p = await m.prepare('What is the current budget?', summarize);
  assert.ok(calls > 0);
  assert.match(p.messages[0].content, /blue robot/);
  assert.ok(p.messages.some(x => x.content.includes('now 3000')));
  assert.ok(messagesCost(p.messages) + tokenCost('What is the current budget?') <= 2600);
  assert.ok(p.messages.length < 50);
});
test('failed summary preserves stored history and a failed reply does not commit compaction', async () => {
  const m = new ConversationMemory();
  for (let i = 0; i < 7; i++) await add(m, 'Details ' + i + ': ' + 'long discussion '.repeat(65));
  const before = JSON.stringify(m);
  const p = await m.prepare('Tell me more', async () => { throw Error('offline'); });
  assert.ok(p.partial); assert.ok(p.messages.length < m.recent.length);
  assert.equal(JSON.stringify(m), before);
  const candidate = await m.prepare('Tell me more', async () => 'Important earlier details.');
  assert.ok(candidate.compacted);
  assert.equal(JSON.stringify(m), before); // TTS failure leaves this untouched.
});
test('brief followups stay brief; detailed questions have room and complete sentences', () => {
  assert.ok(replyProfile('Thanks').tokens < replyProfile('Explain how it works').tokens);
  assert.equal(replyProfile('Please explain briefly').style, 'brief');
  assert.equal(replyProfile('Yes please', [{role:'assistant',content:'Would you like me to explain the steps?'}]).style, 'detailed');
  assert.equal(replyProfile('Yes', [{role:'assistant',content:'Is it working?'}]).style, 'brief');
  assert.equal(spokenReply('Here is a complete answer. And this is an unfinished'), 'Here is a complete answer.');
  assert.equal(spokenReply(''), '');
  assert.ok(spokenReply('A sentence that fits perfectly. '.repeat(100)).split(/\s+/).length <= 110);
  assert.ok(followupWindow('Details '.repeat(80), 'What happened next?', 8) > followupWindow('Hi', 'Hello.', 1));
  assert.ok(followupWindow('Details '.repeat(200), 'Next?', 100) <= 90000);
});
test('local provider uses adaptive answer budgets and summarizes as data', async () => {
  const requests = [];
  const p = createLocalProvider({}, async (_, options) => {
    requests.push(JSON.parse(options.body));
    return Response.json({ message: { content: 'A complete response.' } });
  });
  await p.reply('Thanks', []);
  await p.reply('Please explain all the steps', [{role:'user',content:'Earlier details. '.repeat(300)}]);
  assert.ok(requests[0].options.num_predict < requests[1].options.num_predict);
  assert.ok(requests[0].options.num_ctx < requests[1].options.num_ctx);
  await p.summarize('My robot is blue.', [{role:'user',content:'Change it to green.'}]);
  assert.match(requests[2].messages[0].content, /corrections replace/);
  assert.equal(JSON.parse(requests[2].messages[1].content).transcript[0].content, 'Change it to green.');
});
