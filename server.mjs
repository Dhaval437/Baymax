import http from 'node:http';
import { readFile } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';
import { randomBytes } from 'node:crypto';
import { AppError, createProvider, validateInput, VOICES } from './provider.mjs';
import { createGroqProvider, GROQ_VOICES } from './groq-provider.mjs';
import { createLocalProvider, LOCAL_VOICES } from './local-provider.mjs';

const files = { '/': ['index.html', 'text/html'], '/app.js': ['app.js', 'text/javascript'], '/style.css': ['style.css', 'text/css'] };
async function readBody(req, max) {
  const chunks = []; let length = 0;
  for await (const chunk of req) {
    length += chunk.length;
    if (length > max) throw new AppError('Recording or message is too large.', 413);
    chunks.push(chunk);
  }
  return Buffer.concat(chunks);
}
export function createServer({ env = process.env, provider } = {}) {
  const selected = env.AI_PROVIDER === 'local' ? 'local' : env.AI_PROVIDER === 'groq' ? 'groq' : 'gemini';
  const voices = selected === 'local' ? LOCAL_VOICES : selected === 'groq' ? GROQ_VOICES : VOICES;
  const configured = selected === 'local' || (selected === 'groq' ? !!env.GROQ_API_KEY?.trim() : !!env.GEMINI_API_KEY?.trim());
  provider ??= selected === 'local' ? createLocalProvider(env) : selected === 'groq' ? createGroqProvider(env) : createProvider(env);
  const token = randomBytes(24).toString('hex');
  let busy = false;
  const server = http.createServer(async (req, res) => {
    res.setHeader('Cache-Control', 'no-store');
    res.setHeader('X-Content-Type-Options', 'nosniff');
    res.setHeader('Referrer-Policy', 'no-referrer');
    res.setHeader('Content-Security-Policy', "default-src 'self'; script-src 'self'; style-src 'self'; media-src 'self' blob: data:; connect-src 'self'; img-src 'self' data:; frame-ancestors 'none'; base-uri 'none'");
    const json = (status, data) => { res.writeHead(status, { 'Content-Type': 'application/json' }); res.end(JSON.stringify(data)); };
    const host = `127.0.0.1:${server.address().port}`;
    if (![host, `localhost:${server.address().port}`].includes(req.headers.host)) return json(403, { error: 'Use the local app address.' });
    if (req.headers.origin && ![`http://${host}`, `http://localhost:${server.address().port}`].includes(req.headers.origin))
      return json(403, { error: 'Cross-origin requests are disabled.' });
    let ownsLock = false;
    try {
      if (req.method === 'GET' && files[req.url]) {
        const [name, type] = files[req.url];
        const data = await readFile(new URL(`./public/${name}`, import.meta.url));
        res.writeHead(200, { 'Content-Type': `${type}; charset=utf-8` }); return res.end(data);
      }
      if (req.method === 'GET' && req.url === '/api/config') return json(200, { configured, provider:selected, token, voices });
      if (req.method !== 'POST' || !['/api/transcribe', '/api/chat', '/api/audition'].includes(req.url)) return json(404, { error: 'Not found.' });
      if (req.headers['x-session-token'] !== token) return json(403, { error: 'Reload the app before sending a request.' });
      if (!configured) throw new AppError(`${selected === 'groq' ? 'Groq' : 'Gemini'} API setup is needed. You can still record and replay your microphone locally.`, 503);
      if (busy) throw new AppError('Another request is still running. Wait for it to finish.', 409);
      busy = ownsLock = true;
      if (req.url === '/api/transcribe') {
        const bytes = await readBody(req, 3 * 1024 * 1024);
        if (bytes.length < 100) throw new AppError('The recording is empty or too short.');
        return json(200, { text: await provider.transcribe(bytes, req.headers['content-type'] || '') });
      }
      if (!req.headers['content-type']?.startsWith('application/json')) throw new AppError('Expected JSON.');
      let raw;
      try { raw = JSON.parse((await readBody(req, 24000)).toString()); }
      catch (e) { if (e instanceof AppError) throw e; throw new AppError('Invalid JSON.'); }
      const { text, voice, history } = validateInput(raw, voices);
      const answer = req.url === '/api/chat' ? await provider.reply(text, history) : text;
      try {
        const audio = await provider.speak(answer, voice);
        return json(200, { text: answer, audio: audio.toString('base64') });
      } catch (e) {
        // Preserve the reply if speech generation fails; don't repeat a paid LLM call.
        if (req.url === '/api/chat') return json(200, { text: answer, warning: e.message });
        throw e;
      }
    } catch (e) { return json(e instanceof AppError ? e.status : 500, { error: e instanceof AppError ? e.message : 'Unexpected local error. Restart the app and try again.' }); }
    finally { if (ownsLock) busy = false; }
  });
  server.requestTimeout = selected === 'local' ? 180000 : 90000;
  return server;
}
if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  const port = Number(process.env.PORT || 8787);
  createServer().listen(port, '127.0.0.1', () => console.log(`Baymax prototype: http://127.0.0.1:${port}\nKeep this terminal open. Ctrl+C stops it. No hardware is required.`));
}
