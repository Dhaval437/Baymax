import { warmLocalSpeech, closeLocalSpeech } from '../local-speech-worker.mjs';
import { createLocalProvider } from '../local-provider.mjs';
import { replySegments } from '../reply-audio.mjs';
import { writeFile } from 'node:fs/promises';
const text = 'Hello. I am here to help you. Tell me what happened, and we can work through it together.';
try {
  await warmLocalSpeech();
  const provider = createLocalProvider();
  let start = performance.now();
  await provider.speak(text);
  const wholeReplyReadyMs = Math.round(performance.now() - start);
  start = performance.now();
  let firstSentenceReadyMs = 0;
  const parts = replySegments(text);
  for (let i = 0; i < parts.length; i++) {
    await provider.speak(parts[i]);
    if (!i) firstSentenceReadyMs = Math.round(performance.now() - start);
  }
  const result = { text, wholeReplyReadyMs, firstSentenceReadyMs,
    allSentencesReadyMs: Math.round(performance.now() - start),
    note: 'Real local synthesis, no microphone, model-answer or network time included.' };
  await writeFile(new URL('./verification/sentence-delivery-benchmark.json', import.meta.url), JSON.stringify(result, null, 2));
  console.log(JSON.stringify(result));
} finally { closeLocalSpeech(); }
