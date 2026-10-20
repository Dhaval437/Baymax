import { createLocalProvider } from '../local-provider.mjs';
import { warmLocalSpeech, closeLocalSpeech } from '../local-speech-worker.mjs';
import { normalizeRobotTranscript, isWakePhrase, isStatusRequest } from '../wake-response.mjs';
import { writeFile } from 'node:fs/promises';
const results = [];
try {
  await warmLocalSpeech();
  const provider = createLocalProvider();
  for (const text of ['Baymax.', 'Ouch!', 'Check status.']) {
    const audio = await provider.speak(text);
    const heard = await provider.transcribe(audio, 'audio/wav');
    const normalized = normalizeRobotTranscript(heard);
    const recognized = text.startsWith('Check') ? isStatusRequest(normalized) : isWakePhrase(normalized);
    results.push({ text, heard, normalized, recognized });
  }
  console.log(JSON.stringify(results));
  await writeFile(new URL('./verification/voice-commands-v8.json', import.meta.url),
    JSON.stringify({ kind: 'synthetic voice loopback, not physical microphone validation', results }, null, 2));
  if (results.some(r => !r.recognized)) process.exitCode = 1;
} finally { closeLocalSpeech(); }
