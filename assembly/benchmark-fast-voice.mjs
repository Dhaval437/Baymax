import { writeFile } from 'node:fs/promises';
import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import { fileURLToPath } from 'node:url';
import { localSpeechWorker, closeLocalSpeech } from '../local-speech-worker.mjs';
const run = promisify(execFile);
const folder = new URL('./verification/', import.meta.url);
const phrase = 'I heard you. Tell me what happened, and I will try to help.';
const report = {phrase, scope:'Local synthesis only; not total response latency',results:[]};
try {
  await localSpeechWorker.request('warm');
  for (let i=0;i<2;i++) {
    let start=performance.now();
    await localSpeechWorker.request('speak',{text:phrase,seed:42,output:fileURLToPath(new URL('benchmark-character.wav',folder))});
    report.results.push({mode:'character',ms:Math.round(performance.now()-start)});
    await writeFile(new URL('benchmark-text.txt',folder),phrase);
    start=performance.now();
    await run('powershell.exe',['-NoProfile','-ExecutionPolicy','Bypass','-File',
      fileURLToPath(new URL('./fast-voice.ps1',import.meta.url)),
      '-TextFile',fileURLToPath(new URL('benchmark-text.txt',folder)),
      '-OutputFile',fileURLToPath(new URL('benchmark-fast.wav',folder))],{windowsHide:true,timeout:30000});
    report.results.push({mode:'fast',ms:Math.round(performance.now()-start)});
  }
  await writeFile(new URL('fast-voice-benchmark.json',folder),JSON.stringify(report,null,2));
  console.log(JSON.stringify(report,null,2));
} finally { closeLocalSpeech(); }
