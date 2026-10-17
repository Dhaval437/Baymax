const $ = id => document.getElementById(id);
let config, busy = false, recorder, stream, timer, recording, recordingUrl, history = [];
const greeting = 'Hello. I am Baymax, your personal healthcare companion.';
function status(text, title = 'Ready when you are.') { $('status').textContent = text; $('state').textContent = title; }
function controls() {
  const active = recorder?.state === 'recording';
  $('record').disabled = busy;
  $('record').textContent = active ? 'Stop recording' : 'Start recording';
  for (const id of ['send', 'audition']) $(id).disabled = busy || active || !config?.configured;
  $('transcribe').disabled = busy || active || !recording || !config?.configured;
  $('clear').disabled = busy || active;
  $('voice').disabled = busy || active;
}
async function api(path, body, type = 'application/json') {
  const response = await fetch(path, { method: 'POST', headers: { 'Content-Type': type, 'X-Session-Token': config.token }, body: type === 'application/json' ? JSON.stringify(body) : body });
  const result = await response.json();
  if (!response.ok) throw new Error(result.error || 'Request failed.');
  return result;
}
async function task(label, run) {
  if (busy) return;
  $('replyAudio').pause(); window.speechSynthesis?.cancel(); busy = true; controls(); status(label, 'One moment…');
  try { await run(); } catch(e) { status(e.message, 'Let’s check that.'); }
  finally { busy = false; controls(); }
}
async function play(result) {
  if (result.warning) { status(`Reply received, but voice playback could not be generated: ${result.warning}`); return; }
  if (result.speechMode === 'browser') {
    if (!window.speechSynthesis) { status('This browser cannot speak the reply. You can read it above.'); return; }
    const utterance = new SpeechSynthesisUtterance(result.text);
    utterance.lang = 'en-US'; utterance.rate = 0.88; utterance.pitch = 0.85;
    const voices = window.speechSynthesis.getVoices();
    utterance.voice = voices.find(v => v.lang.startsWith('en') && /male|george|david|guy/i.test(v.name)) || voices.find(v => v.lang.startsWith('en')) || null;
    window.speechSynthesis.speak(utterance);
    status('Speaking with a temporary computer voice. This is not Baymax’s movie voice.');
    return;
  }
  const audio = $('replyAudio'); audio.src = `data:audio/wav;base64,${result.audio}`; audio.hidden = false;
  status('AI-generated speech is ready. You can replay it below the voice selector.');
  try { await audio.play(); } catch { status('Press Play on the audio player to hear the generated voice.'); }
}
function add(role, text) {
  $('empty')?.remove();
  const bubble = document.createElement('div'); bubble.className = `message ${role}`;
  const label = document.createElement('small'); label.textContent = role === 'user' ? 'YOU' : 'COMPANION';
  bubble.append(label, document.createTextNode(text)); $('messages').append(bubble); $('messages').scrollTop = $('messages').scrollHeight;
}
function stopRecording() { if(recorder?.state === 'recording') recorder.stop(); }
$('record').onclick = async () => {
  if(recorder?.state === 'recording') { stopRecording(); return; }
  $('replyAudio').pause(); $('recording').pause(); busy = true; controls();
  try {
    if (!navigator.mediaDevices?.getUserMedia || !window.MediaRecorder) throw new Error('Open this app in Chrome or Edge to use the microphone.');
    stream = await navigator.mediaDevices.getUserMedia({audio:{echoCancellation:true,noiseSuppression:true}});
    const mimeType = ['audio/webm;codecs=opus','audio/mp4','audio/ogg;codecs=opus'].find(t=>MediaRecorder.isTypeSupported(t));
    if (!mimeType) throw new Error('This browser has no supported recording format. Try Chrome or Edge.');
    const chunks = [];
    recorder = new MediaRecorder(stream,{mimeType});
    recorder.ondataavailable = e => { if(e.data.size) chunks.push(e.data); };
    recorder.onstop = () => {
      clearTimeout(timer); stream?.getTracks().forEach(t=>t.stop());
      recording = new Blob(chunks,{type:mimeType});
      if(recordingUrl) URL.revokeObjectURL(recordingUrl);
      recordingUrl = URL.createObjectURL(recording); $('recording').src = recordingUrl; $('recording').hidden = false;
      status(config.configured ? 'Replay your recording, then choose Transcribe. Review the text before sending.' : 'Recording ready. Press Play to check your microphone. Nothing has been uploaded.'); controls();
    };
    recorder.onerror = () => { stopRecording(); status('Recording failed. Check your microphone and try again.'); };
    recorder.start(); timer = setTimeout(stopRecording,20000); status('Speak now. Click Stop recording when finished.','Listening…');
  } catch(e) {
    stream?.getTracks().forEach(t=>t.stop());
    status(e.name === 'NotAllowedError' ? 'Microphone access was not allowed. Enable it in your browser, or type a message.' : e.message, 'Microphone unavailable');
  } finally { busy = false; controls(); }
};
$('transcribe').onclick = () => task('Turning your recording into text…',async()=>{
  const result = await api('/api/transcribe',recording,recording.type);
  $('message').value = result.text; $('message').focus(); status('Check the transcript below, then press Send message.');
});
$('chat').onsubmit = e => {
  e.preventDefault(); const text = $('message').value.trim();
  if(!text || !config?.configured) return;
  task('Thinking, then generating speech…', async()=>{
    const result = await api('/api/chat',{text,history,voice:$('voice').value});
    add('user',text); add('assistant',result.text); history = [...history,{role:'user',content:text},{role:'assistant',content:result.text}].slice(-8);
    $('message').value = ''; await play(result);
  });
};
$('audition').onclick = () => task('Generating a short synthetic voice sample…',async()=>{
  await play(await api('/api/audition',{text:greeting,voice:$('voice').value}));
});
$('clear').onclick = () => {
  window.speechSynthesis?.cancel();
  history = []; $('messages').replaceChildren(); $('message').value = '';
  for(const id of ['recording','replyAudio']) { $(id).pause(); $(id).removeAttribute('src'); $(id).hidden = true; }
  if(recordingUrl) URL.revokeObjectURL(recordingUrl); recording = null;
  status('Conversation and recordings cleared from this tab.'); controls();
};
window.addEventListener('pagehide',()=>{clearTimeout(timer);stream?.getTracks().forEach(t=>t.stop());window.speechSynthesis?.cancel();});
try {
  config = await (await fetch('/api/config')).json();
  const providerName = config.provider === 'local' ? 'This laptop' : config.provider === 'groq' ? 'Groq' : 'Google Gemini';
  $('providerName').textContent = providerName;
  if (config.provider === 'local') $('privacy').textContent = 'Recordings stay in this tab until you choose Transcribe. Transcription, replies, and voice generation run on this laptop. The short voice reference stays in the project folder. Chat and microphone recordings are not saved by the app.';
  $('voice').replaceChildren(...config.voices.map(voice => { const option = document.createElement('option'); option.value = voice; option.textContent = voice; return option; }));
  $('connection').textContent = config.configured ? `${providerName} selected` : 'Local microphone test';
  $('setup').hidden = config.configured;
  status(config.configured ? (config.provider === 'local' ? 'Type a message or record. Replies and the experimental Baymax-inspired voice run on this laptop.' : 'Record your voice or type a message. Online actions use your API account.') : 'You can record and replay now. Add an API key later for conversation.'); controls();
} catch { status('Cannot reach the local server. Restart it and reload this page.','Connection needed'); }
