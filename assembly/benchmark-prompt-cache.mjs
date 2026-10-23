import { createLocalProvider } from '../local-provider.mjs';
import { writeFile } from 'node:fs/promises';
let captured;
const provider=createLocalProvider({},async(_,options)=>{
  captured=JSON.parse(options.body);
  return Response.json({message:{content:'Complete reply.'}});
});
const rows=[];
for(const mode of ['previous','stable-prefix']){
  for(const [index,text] of ['Hello','How does a rainbow form?','Name a planet.'].entries()){
    await provider.reply(text,[]);
    const body=structuredClone(captured);
    if(mode==='stable-prefix'){
      const words=body.messages[0].content.match(/at most (\d+) words/)[1];
      body.messages[0].content=body.messages[0].content.replace(
        `Aim for at most ${words} words, finishing every sentence.`,
        'Keep replies concise and finish every sentence.');
      body.messages.splice(-1,0,{role:'system',content:`For this reply, aim for at most ${words} words. Finish every sentence.`});
    }
    body.options.seed=42;
    const start=performance.now();
    const response=await fetch('http://127.0.0.1:11434/api/chat',{
      method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(body),
      signal:AbortSignal.timeout(90000)});
    if(!response.ok)throw Error('Benchmark request failed');
    const data=await response.json();
    rows.push({mode,warmup:index===0,text,ms:Math.round(performance.now()-start),
      promptMs:Math.round(data.prompt_eval_duration/1e6),generationMs:Math.round(data.eval_duration/1e6),
      tokens:data.eval_count,answer:data.message.content});
  }
}
await writeFile(new URL('./verification/prompt-cache-benchmark.json',import.meta.url),JSON.stringify(rows,null,2));
console.log(JSON.stringify(rows,null,2));
