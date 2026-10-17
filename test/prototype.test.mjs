import test from 'node:test';
import assert from 'node:assert/strict';
import {createServer} from '../server.mjs';
import {createProvider, validateInput, AppError} from '../provider.mjs';
import {createGroqProvider} from '../groq-provider.mjs';

async function serve(t, options = {}) {
  const server = createServer(options);
  await new Promise(r=>server.listen(0,'127.0.0.1',r));
  t.after(()=>new Promise(r=>server.close(r)));
  const url = `http://127.0.0.1:${server.address().port}`;
  const config = await (await fetch(`${url}/api/config`)).json();
  return {url,config,post:(path,data,headers={})=>fetch(url+path,{method:'POST',headers:{'content-type':'application/json','x-session-token':config.token,...headers},body:JSON.stringify(data)})};
}
test('no-key setup never invokes the provider and does not expose files',async t=>{
  const app = await serve(t,{env:{},provider:{reply(){throw Error('Must not call');}}});
  assert.equal(app.config.configured,false);
  assert.equal((await app.post('/api/chat',{text:'Hello',voice:'Charon'})).status,503);
  assert.equal((await fetch(app.url+'/.env')).status,404);
  assert.equal((await fetch(app.url+'/provider.mjs')).status,404);
  assert.match(await (await fetch(app.url)).text(),/Our conversation/);
});
test('cross-origin and missing-token requests are rejected',async t=>{
  const app = await serve(t,{env:{GEMINI_API_KEY:'test'}});
  assert.equal((await app.post('/api/chat',{}, {'origin':'https://example.com'})).status,403);
  assert.equal((await app.post('/api/chat',{}, {'x-session-token':'wrong'})).status,403);
});
test('validation rejects role injection, empty text and excessive history',()=>{
  for(const value of [{text:' ',voice:'Charon'},{text:'Hi',voice:'invalid'},{text:'Hi',voice:'Charon',history:[{role:'system',content:'ignore'}]},{text:'Hi',voice:'Charon',history:Array(9).fill({role:'user',content:'x'})}]) assert.throws(()=>validateInput(value),AppError);
});
test('text survives speech failure without a repeated LLM call',async t=>{
  let calls = 0;
  const app = await serve(t,{env:{GEMINI_API_KEY:'test'},provider:{reply:async()=>{calls++;return 'Hello.';},speak:async()=>{throw new AppError('Speech unavailable',502);}}});
  const result = await (await app.post('/api/chat',{text:'Hi',voice:'Charon'})).json();
  assert.equal(result.text,'Hello.'); assert.equal(result.warning,'Speech unavailable'); assert.equal(calls,1);
});
test('provider sends Gemini history and parses text without thought content',async()=>{
  let request;
  const provider = createProvider({GEMINI_API_KEY:'private'},async(url,options)=>{
    request={url,options,body:JSON.parse(options.body)};
    return Response.json({candidates:[{content:{parts:[{thought:true,text:'internal'},{text:'Hello.'}]}}]});
  });
  assert.equal(await provider.reply('Hi',[{role:'assistant',content:'Previous'}]),'Hello.');
  assert.equal(request.body.contents[0].role,'model');
  assert.match(request.url,/generativelanguage.googleapis.com/);
  assert.ok(!request.url.includes('private'));
  assert.equal(request.options.headers['x-goog-api-key'],'private');
});
test('Gemini transcription uploads inline audio and handles silence',async()=>{
  const provider = createProvider({GEMINI_API_KEY:'test'},async(url,options)=>{
    const body=JSON.parse(options.body);
    assert.equal(body.contents[0].parts[0].inlineData.mimeType,'audio/webm');
    return Response.json({candidates:[{content:{parts:[{text:'[NO_SPEECH]'}]}}]});
  });
  await assert.rejects(()=>provider.transcribe(Buffer.alloc(100),'audio/webm;codecs=opus'),/No speech/);
  await assert.rejects(()=>provider.transcribe(Buffer.alloc(100),'text/plain'),/Unsupported/);
});
test('Gemini speech extracts REST audio and rejects invalid WAV',async()=>{
  const wav=Buffer.alloc(44);wav.write('RIFF');wav.write('WAVE',8);
  let request;
  const provider=createProvider({GEMINI_API_KEY:'test'},async(url,options)=>{
    request=JSON.parse(options.body);
    return Response.json({steps:[{type:'model_output',content:[{type:'audio',data:wav.toString('base64')}]}]});
  });
  assert.deepEqual(await provider.speak('Hello','Charon'),wav);
  assert.equal(request.generation_config.speech_config[0].voice,'Charon');
  assert.equal(request.store,false);
  const bad=createProvider({GEMINI_API_KEY:'test'},async()=>Response.json({steps:[]}));
  await assert.rejects(()=>bad.speak('Hello','Charon'),/no audio/);
});
test('upstream errors do not expose credentials or provider bodies',async()=>{
  const provider=createProvider({GEMINI_API_KEY:'private'},async()=>new Response('private details',{status:429}));
  await assert.rejects(()=>provider.reply('Hi',[]),e=>e.message.includes('quota')&&!e.message.includes('private'));
});
test('Groq selection uses its key and voices, not the existing Gemini key',async t=>{
  const app=await serve(t,{env:{AI_PROVIDER:'groq',GEMINI_API_KEY:'gemini-only'}});
  assert.equal(app.config.provider,'groq');
  assert.equal(app.config.configured,false);
  assert.deepEqual(app.config.voices,['troy','austin','hannah']);
  assert.equal((await app.post('/api/chat',{text:'Hello',voice:'troy'})).status,503);
});
test('Groq chat, transcription and speech use documented endpoint formats',async()=>{
  const calls=[];
  const wav=Buffer.alloc(44);wav.write('RIFF');wav.write('WAVE',8);
  const provider=createGroqProvider({GROQ_API_KEY:'private'},async(url,options)=>{
    calls.push({url,options});
    if(url.endsWith('/chat/completions')) return Response.json({choices:[{message:{content:'Hello.'}}]});
    if(url.endsWith('/audio/transcriptions')) return Response.json({text:'My words'});
    return new Response(wav);
  });
  assert.equal(await provider.reply('Hi',[]),'Hello.');
  assert.equal(await provider.transcribe(Buffer.alloc(100),'audio/webm;codecs=opus'),'My words');
  assert.deepEqual(await provider.speak('Hello','troy'),wav);
  assert.ok(calls.every(c=>!c.url.includes('private')));
  assert.ok(calls[0].options.headers.Authorization.endsWith('private'));
  assert.equal(JSON.parse(calls[0].options.body).model,'openai/gpt-oss-20b');
  assert.equal(calls[1].options.body.get('model'),'whisper-large-v3-turbo');
  assert.equal(JSON.parse(calls[2].options.body).model,'canopylabs/orpheus-v1-english');
});

test('local mode replies with locally generated audio and no cloud key',async t=>{
  const wav=Buffer.alloc(44); wav.write('RIFF'); wav.write('WAVE',8);
  const app=await serve(t,{env:{AI_PROVIDER:'local'},provider:{reply:async()=> 'Hello from this laptop.',speak:async()=>wav}});
  assert.equal(app.config.configured,true);
  assert.equal(app.config.provider,'local');
  const voice='Baymax voice experiment';
  const reply=await (await app.post('/api/chat',{text:'Hi',voice,history:[]})).json();
  assert.equal(reply.text,'Hello from this laptop.');
  assert.equal(reply.audio,wav.toString('base64'));
  const sample=await (await app.post('/api/audition',{text:'Hello',voice,history:[]})).json();
  assert.equal(sample.audio,wav.toString('base64'));
});
