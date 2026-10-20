// Synthetic regression fixtures; physical microphone testing is still needed.
import { createLocalProvider } from '../local-provider.mjs';
import { closeLocalSpeech } from '../local-speech-worker.mjs';
import { mkdir, writeFile } from 'node:fs/promises';
const folder = new URL('./verification/speech-fixtures/', import.meta.url);
await mkdir(folder, { recursive: true });
const phrases = ["It's paining.", "My hand is hurting.", "My heart is beating fast.",
  "Baymax, check status.", "Ouch, my arm hurts."];
try {
  const provider = createLocalProvider();
  for (let i = 0; i < phrases.length; i++) {
    await writeFile(new URL(`${i}.wav`, folder), await provider.speak(phrases[i]));
  }
  await writeFile(new URL('phrases.json', folder), JSON.stringify(phrases));
} finally { closeLocalSpeech(); }
