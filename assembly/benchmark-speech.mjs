import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import { fileURLToPath } from 'node:url';
import { writeFile, mkdir } from 'node:fs/promises';
import { localSpeechWorker, closeLocalSpeech } from '../local-speech-worker.mjs';
const root=fileURLToPath(new URL('../',import.meta.url)), run=promisify(execFile);
const text='I am here to help. What would you like to talk about?';
const folder=new URL('./verification/speech-benchmark/',import.meta.url);await mkdir(folder,{recursive:true});
const report={text,seed:7,date:new Date().toISOString(),sameModelAndSettings:true};
try{
  let started=performance.now();console.log('Measuring previous per-reply voice process...');
  await run(root+'.venv/Scripts/soprotts.exe',[text,'--ref',root+'.reference/baymax-reference-advice.wav','--out',fileURLToPath(new URL('previous.wav',folder)),'--seed','7'],{windowsHide:true,timeout:150000,maxBuffer:1024*1024,env:{...process.env,HF_HOME:root+'.models/hf',HF_HUB_OFFLINE:'1'}});
  report.previousMs=Math.round(performance.now()-started);console.log('Previous voice process: '+report.previousMs+' ms');
  const warm=await localSpeechWorker.request('warm');report.warmUpMs=warm.elapsedMs;console.log('One-time model preparation: '+warm.elapsedMs+' ms');
  report.residentMs=[];
  for(let n=0;n<2;n++){started=performance.now();const reply=await localSpeechWorker.request('speak',{text,seed:7,output:fileURLToPath(new URL('resident-'+n+'.wav',folder))});report.residentMs.push(Math.round(performance.now()-started));report.audioSeconds=reply.result.audioSeconds;console.log('Resident voice '+(n+1)+': '+report.residentMs.at(-1)+' ms')}
  report.savedPercent=Math.round(100*(1-report.residentMs.at(-1)/report.previousMs));
  await writeFile(new URL('../speech-latency.json',folder),JSON.stringify(report,null,2));console.log(JSON.stringify(report));
}finally{closeLocalSpeech()}
