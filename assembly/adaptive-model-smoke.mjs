// Synthetic conversation only: no microphone, speaker or motors are activated.
import assert from 'node:assert/strict';
import { writeFile } from 'node:fs/promises';
import { createLocalProvider } from '../local-provider.mjs';
import { ConversationMemory, spokenReply } from '../conversation-policy.mjs';
const provider = createLocalProvider();
const memory = new ConversationMemory();
const append = (user, answer) => {
  memory.recent.push({role:'user',content:user},{role:'assistant',content:answer}); memory.turns++;
};
append('I am designing a robot named Moti. Its case is blue. My budget is 2000 rupees.', 'I understand your project.');
for (let i=0;i<16;i++) append('Assembly discussion '+i+': '+
  'The arm needs clearance from the body. Wires should be routed away from the joints. The base holds the electronics. '.repeat(3), 'Keep the joints clear and secure the wiring.');
append('Correction: my budget is now 3000 rupees, not 2000. The name and color are unchanged.', 'Your revised budget is 3000 rupees.');
const question = 'What is my robot name, case color, and current budget?';
const started = Date.now();
const p = await memory.prepare(question, provider.summarize.bind(provider));
assert.ok(p.compacted, 'Must exercise real model compaction');
const answer = spokenReply(await provider.reply(question, p.messages));
assert.match(answer, /Moti/i); assert.match(answer, /blue/i); assert.match(answer, /3[,.]?000/);
assert.doesNotMatch(answer, /2[,.]?000/);
memory.commit(p, question, answer);
const short = spokenReply(await provider.reply('Thanks', (await memory.prepare('Thanks',provider.summarize.bind(provider))).messages));
assert.ok(short.split(/\s+/).length <= 35, 'A short acknowledgement should stay short after a long discussion');
const report={checkedAt:new Date().toISOString(),synthetic:true,realLocalModel:true,summaryCreated:p.compacted,
  correctedFactsRetained:true,answer,shortReply:short,memory:memory.snapshot(),elapsedMs:Date.now()-started,
  physicalAudioTested:false,marathiEnabled:false};
await writeFile(new URL('verification/adaptive-model-test.json',import.meta.url),JSON.stringify(report,null,2)+'\n');
console.log(JSON.stringify(report,null,2));
