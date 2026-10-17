import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';

export class SpeechWorker {
  constructor({ spawnWorker = spawn, timeout = 180000 } = {}) { this.spawnWorker=spawnWorker; this.timeout=timeout; this.child=null; this.pending=new Map(); this.nextId=0; this.state='cold'; }
  start() {
    if(this.child)return;
    const child=this.spawnWorker(fileURLToPath(new URL('./.venv/Scripts/python.exe',import.meta.url)),['-u',fileURLToPath(new URL('./local-speech-worker.py',import.meta.url))],{windowsHide:true,stdio:['pipe','pipe','pipe']});
    this.child=child;this.state='loading';let buffer='';
    const fail=()=>{ if(this.child!==child)return; this.child=null;this.state='unavailable';for(const p of this.pending.values()){clearTimeout(p.timer);p.reject(new Error('Local speech worker stopped. Retry the request.'))}this.pending.clear(); };
    child.on('error',fail);child.on('exit',fail);child.stdin.on('error',fail);
    child.stderr.on('data',()=>{}); // stdout is the structured protocol; no transcript logging.
    child.stdout.on('data',chunk=>{
      buffer+=chunk.toString();let at;
      while((at=buffer.indexOf('\n'))>=0){const line=buffer.slice(0,at);buffer=buffer.slice(at+1);let message;try{message=JSON.parse(line)}catch{continue}
        const p=this.pending.get(message.id);if(!p)continue;this.pending.delete(message.id);clearTimeout(p.timer);
        if(message.ok){this.state='ready';p.resolve(message)}else p.reject(new Error(message.error||'Local speech failed'));
      }
      if(buffer.length>1000000){child.kill();fail()}
    });
  }
  request(op, args={}) {
    if(this.pending.size>=8)return Promise.reject(new Error('Local speech queue is full.'));
    this.start();const id=++this.nextId;
    return new Promise((resolve,reject)=>{
      const timer=setTimeout(()=>{this.close();reject(new Error('Local speech timed out. Retry to restart the engine.'))},this.timeout);
      this.pending.set(id,{resolve,reject,timer});
      this.child.stdin.write(JSON.stringify({id,op,...args})+'\n');
    });
  }
  close() { const child=this.child;this.child=null;this.state='cold';for(const p of this.pending.values()){clearTimeout(p.timer);p.reject(new Error('Local speech worker closed.'))}this.pending.clear();child?.kill(); }
}
export const localSpeechWorker = new SpeechWorker();
export const warmLocalSpeech = () => localSpeechWorker.request('warm');
export const closeLocalSpeech = () => localSpeechWorker.close();
