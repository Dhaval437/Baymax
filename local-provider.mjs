import { mkdtemp, writeFile, readFile, rm } from 'node:fs/promises';
import { tmpdir } from 'node:os';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import { AppError } from './provider.mjs';
import { SMOOTH_VOICE_FILTER } from './voice-processing.mjs';
import { localSpeechWorker } from './local-speech-worker.mjs';

const run = promisify(execFile);
const root = dirname(fileURLToPath(import.meta.url));
export const LOCAL_VOICES = ['Baymax voice experiment'];

export function createLocalProvider(env = process.env, fetcher = fetch, runner = run) {
  const resident = runner === run && env.BAYMAX_LEGACY_SPEECH !== '1';
  return {
    async reply(text, history) {
      let response;
      try {
        response = await fetcher('http://127.0.0.1:11434/api/chat', {
          method:'POST',headers:{'Content-Type':'application/json'},signal:AbortSignal.timeout(90000),
          body:JSON.stringify({model:env.LOCAL_MODEL || 'qwen3:1.7b',stream:false,think:false,
            options:{num_ctx:2048,num_predict:160,temperature:0.5},
            messages:[{role:'system',content:'You are a small, gentle desk-companion prototype. Answer in one or two short, plain English sentences. Speak calmly without exclamations or dramatic wording. You have no medical sensors and cannot diagnose. You are not the official Baymax character and do not have its original movie voice.'},...history,{role:'user',content:text}]})
        });
      } catch { throw new AppError('Cannot reach the local Ollama model. Check that Ollama is running and the model has finished downloading.',503); }
      if (!response.ok) throw new AppError('Ollama could not generate a reply. Confirm the local model has finished downloading.',503);
      const data=await response.json();
      const answer=data.message?.content?.trim();
      if (!answer) throw new AppError('The local model returned no reply.',502);
      return answer.slice(0,2000);
    },
    async transcribe(bytes, mime) {
      const base=mime.split(';')[0];
      const ext={'audio/webm':'webm','audio/mp4':'mp4','audio/ogg':'ogg','audio/wav':'wav'}[base];
      if (!ext) throw new AppError('Unsupported recording format. Try Chrome or Edge.');
      const folder=await mkdtemp(join(tmpdir(),'baymax-audio-'));
      try {
        const input=join(folder,`input.${ext}`),wav=join(folder,'converted.wav');
        await writeFile(input,bytes);
        try { await runner(env.FFMPEG_PATH || 'ffmpeg',['-hide_banner','-loglevel','error','-y','-i',input,'-ar','16000','-ac','1','-c:a','pcm_s16le',wav],{timeout:30000,windowsHide:true,maxBuffer:1024*1024}); }
        catch (e) { console.error('FFmpeg conversion failed:', e.message); throw new AppError('Could not convert the recording. Check FFmpeg or try a shorter clip.',502); }
        try {
          const python=join(root,'.venv','Scripts','python.exe');
          const stdout = resident ? (await localSpeechWorker.request('transcribe',{input:wav})).result.text :
            (await runner(python,[join(root,'local-transcribe.py'),wav],{timeout:90000,windowsHide:true,maxBuffer:1024*1024,encoding:'utf8'})).stdout;
          if (!stdout.trim()) {
            const error = new AppError('No speech was recognized. Try clearer audio.', 422);
            error.code = 'NO_SPEECH';
            throw error;
          }
          return stdout.trim();
        } catch(e) { if (e instanceof AppError) throw e; throw new AppError('Local speech recognition failed. Type a message or check the local model setup.',502); }
      } finally { await rm(folder,{recursive:true,force:true}); }
    },
    async speak(text) {
      const reference=join(root,'.reference','baymax-reference-advice.wav');
      const folder=await mkdtemp(join(tmpdir(),'baymax-voice-'));
      const output=join(folder,'reply.wav');
      const softened=join(folder,'reply-soft.wav');
      try {
        const pythonEnv={...process.env,HF_HOME:join(root,'.models','hf')};
        const plainText=text.replace(/[!?]+/g,'.').replace(/\.{2,}/g,'.');
        if (resident) await localSpeechWorker.request('speak',{text:plainText,output});
        else await runner(join(root,'.venv','Scripts','soprotts.exe'),[plainText,'--ref',reference,'--out',output],
          {timeout:120000,windowsHide:true,maxBuffer:1024*1024,env:pythonEnv});
        await runner(env.FFMPEG_PATH || 'ffmpeg',[
          '-hide_banner','-loglevel','error','-y','-i',output,
          '-af',SMOOTH_VOICE_FILTER,'-ar','24000','-ac','1','-c:a','pcm_s16le',softened
        ],{timeout:30000,windowsHide:true,maxBuffer:1024*1024});
        const audio=await readFile(softened);
        if (audio.subarray(0,4).toString() !== 'RIFF') throw new Error('Invalid WAV');
        return audio;
      } catch(e) {
        console.error('Local voice generation failed:',e.message);
        throw new AppError('The Baymax voice experiment could not produce audio. The reply text is shown above.',502);
      } finally { await rm(folder,{recursive:true,force:true}); }
    }
  };
}
