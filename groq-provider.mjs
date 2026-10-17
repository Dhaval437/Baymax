import { AppError } from './provider.mjs';

export const GROQ_VOICES = ['troy', 'austin', 'hannah'];
const BASE = 'https://api.groq.com/openai/v1/';
const INSTRUCTIONS = 'You are a small Baymax-inspired desk companion prototype. Be calm, kind, gently literal and concise. Reply in 1 to 3 short sentences. You can discuss general wellbeing but are not a clinician. Do not claim to have sensors, medical diagnostic abilities, the official film identity, or the original film voice.';

export function createGroqProvider(env = process.env, fetcher = fetch) {
  async function request(path, body, { multipart = false } = {}) {
    if (!env.GROQ_API_KEY?.trim()) throw new AppError('Add a Groq API key to .env and restart the app.', 503);
    let response;
    try {
      response = await fetcher(BASE + path, {
        method: 'POST', headers: { Authorization: `Bearer ${env.GROQ_API_KEY}`,
          ...(!multipart ? { 'Content-Type': 'application/json' } : {}) },
        body: multipart ? body : JSON.stringify(body), signal: AbortSignal.timeout(60000)
      });
    } catch { throw new AppError('Groq could not be reached or timed out. No automatic retry was made.', 502); }
    if (!response.ok) {
      const messages = {400:'Groq rejected the input or model configuration.',401:env.GROQ_API_KEY.startsWith('gsk_') ? 'Groq rejected this API key. Check that it is active in the Groq console.' : 'Groq rejected this value. It does not have the gsk_ format shown in Groq documentation; copy a Groq API key into .env.',403:'This Groq project does not have access to this model.',404:'The Groq model is unavailable to this project.',429:'Groq free-tier quota or rate limit reached. Wait for your limit to reset.',503:'Groq is temporarily unavailable. Try later.'};
      throw new AppError(messages[response.status] || 'Groq returned an error. Try later.', 502);
    }
    return response;
  }
  return {
    async transcribe(bytes, mime) {
      const base = mime.split(';')[0];
      const ext = { 'audio/webm':'webm', 'audio/mp4':'m4a', 'audio/ogg':'ogg', 'audio/wav':'wav' }[base];
      if (!ext) throw new AppError('Unsupported recording format. Try Chrome or Edge.');
      const form = new FormData();
      form.append('model', env.GROQ_TRANSCRIPTION_MODEL || 'whisper-large-v3-turbo');
      form.append('file', new Blob([bytes], { type: base }), `recording.${ext}`);
      const result = await (await request('audio/transcriptions', form, { multipart: true })).json();
      if (!result.text?.trim()) throw new AppError('No speech was recognized. Record again.');
      return result.text.trim();
    },
    async reply(text, history) {
      const result = await (await request('chat/completions', {
        model: env.GROQ_CHAT_MODEL || 'openai/gpt-oss-20b',
        messages: [{role:'system',content:INSTRUCTIONS},...history,{role:'user',content:text}],
        max_completion_tokens:350, stream:false
      })).json();
      const answer = result.choices?.[0]?.message?.content?.trim();
      if (!answer) throw new AppError('Groq returned no reply.',502);
      return answer.slice(0,2000);
    },
    async speak(text, voice) {
      if (!GROQ_VOICES.includes(voice)) throw new AppError('Choose a listed Groq voice.');
      const response = await request('audio/speech', {
        model:env.GROQ_SPEECH_MODEL || 'canopylabs/orpheus-v1-english',
        input:text,voice,response_format:'wav'
      });
      const wav = Buffer.from(await response.arrayBuffer());
      if (wav.toString('ascii',0,4) !== 'RIFF' || wav.toString('ascii',8,12) !== 'WAVE')
        throw new AppError('Groq returned an unexpected audio format.',502);
      return wav;
    }
  };
}
