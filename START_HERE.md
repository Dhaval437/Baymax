> Updated 16 October 2026: see [SOFTWARE_READY.md](SOFTWARE_READY.md) for the integrated, button-free PCA9685 firmware and current startup instructions. The older notes below describe earlier bench stages.

# Baymax laptop prototype — start here

**Current build status (29 September 2026):** the accepted smooth local voice, local conversation, and a token-protected ESP32 audio endpoint work on the laptop. The ESP32 sketch has compiled, uploaded, reported 16 MB flash and 8 MB PSRAM, joined home Wi-Fi, and reached the laptop server with an authenticated request. The two speakers have arrived; the microphone and amplifier combo has not. No physical audio or arm movement test has passed yet. The pin-by-pin steps are in [HARDWARE_SETUP.md](HARDWARE_SETUP.md). Use that guide for the new build; the older sections below describe earlier browser and API experiments.

No Arduino, ESP32 or purchases are needed for this laptop development stage. Node.js 22.9 or newer is required; your computer has Node 22.19. Local mode additionally uses Ollama with `qwen3:1.7b`, FFmpeg, and Python `faster-whisper` for transcription.

The current `.env` selects `AI_PROVIDER=local`. The text model has been downloaded and a live text reply worked. Groq's saved key was rejected by Groq, and Gemini text requests returned overload errors, so local mode is the working path. Do not share `.env`.

## 1. Start locally

Open a terminal in `C:\Users\dhruv\OneDrive\Desktop\Baymax` and run:

```powershell
npm start
```

Open http://127.0.0.1:8787 in Chrome or Edge. Keep the terminal open; Ctrl+C stops the server. If the address is already running, use that page instead of starting a second copy.

## 2. Try the independent laptop prototype without an API key

Type a message and press **Send message**. Ollama generates the reply on this laptop; Sopro generates a voice using a short Baymax reference clipped from [Disney+’s official Life Advice From Baymax video](https://www.youtube.com/watch?v=ntUiFnKQ6Qw). Click **Hear a sample greeting** for a voice-only check. This is an experimental clone, not a verified copy of the original performance. The newer reference has less constant background sound than the earlier trailer clip, but exact similarity has not been established. For the microphone, click **Start recording**, allow access, say a short sentence, and click **Stop recording**. Press Play to check it, then **Transcribe recording** and review the text before sending. Recording stops after 20 seconds. If the embedded browser cannot access a microphone, open the local address in Chrome or Edge.

The laptop currently has Ollama `qwen3:1.7b`, Python `faster-whisper`, Sopro, and their local models installed. The extracted voice reference is in `.reference`, which is excluded from Git. The app's local model, transcription, and voice generation need this laptop running. The finished stand-alone robot will use different onboard hardware and software; this laptop prototype does not make the Uno R3 into a stand-alone AI device.

I tested a local text reply, transcription of the extracted reference, voice generation, and the local app's speech API. All 11 automated tests pass. The WAV generator reproduced the test sentence intelligibly according to local transcription. Following feedback that the output sounded rough, I switched to a cleaner reference and removed the heavy compression and low-temperature synthesis settings. The final sound still needs your listening judgment; no claim of an exact voice is made. Private comparison samples are in `.reference`.

## 3. Configure Gemini locally

Use your own [Google AI Studio API key](https://aistudio.google.com/apikey). Do not paste it into Codex chat or the conversation box. Check the project's quota and billing before making online calls; no free-tier availability is promised.

Copy `.env.example` to `.env` in this folder, then edit `.env` locally:

```text
GEMINI_API_KEY=your_key_here
CHAT_MODEL=gemini-3.5-flash-lite
TRANSCRIPTION_MODEL=gemini-3.5-flash-lite
SPEECH_MODEL=gemini-3.8-flash-tts
PORT=8787
```

Restart the server and refresh the page. The key stays on the local server and is not sent to the browser. `.env` is excluded from Git, but this folder is inside OneDrive: your usual OneDrive settings may sync it. If you do not want a key file here, set `GEMINI_API_KEY` in the server process environment instead. Never share the `.env` file.

### Alternative: Groq free plan

The prototype also supports Groq for text replies, Whisper transcription and English speech. Create your own key in the [Groq console](https://console.groq.com/keys), then edit `.env` locally:

```text
AI_PROVIDER=groq
GROQ_API_KEY=your_key_here
```

Restart the server and refresh. The page should say **Groq configured** and offer Troy, Austin and Hannah voices. The existing Gemini key can remain in `.env` but is unused when Groq is selected. Groq's free plan has account-specific limits and may change. Its current text-to-speech model is English only; the conversation may answer in English. If you need Hindi speech, switch back to Gemini. Do not add billing just to run this prototype.

The defaults follow Google's documentation checked on 28 September 2026. Access must still be verified with your project. A missing-model or permission error requires checking available models; do not keep retrying or enable billing automatically. Changing the speech model to an older PCM model also needs code changes; the current adapter expects WAV output from the documented 3.8 TTS Interactions API. A live test confirmed the Gemini key and speech model worked. Both tested text models returned HTTP 503 (temporary high demand), so the full conversation has not yet succeeded live.

## 4. Test the actual conversation

1. Select a voice and click **Hear a sample greeting**. This makes one Gemini speech request.
2. Type a short message and click **Send message**. This makes a text-generation request and a speech request.
3. Record speech, click **Transcribe recording**, inspect/edit the transcript, then click **Send message**.
4. Try a follow-up question. The latest four exchanges are kept in this tab and included in subsequent replies.
5. Try Charon, Schedar and Achernar with the same greeting. These are synthetic candidates, not the original Baymax voice. Do not mark the voice requirement complete unless you actually accept the result.

Audio uploads and conversation requests go to Google Gemini. No application chat/audio files are written to disk. Clear removes this tab's retained conversation and players; refreshing resets the conversation. Google's own service policies still apply. The local app binds only to your computer; do not expose it publicly.

## What has and has not been verified

Automated tests use mocked provider responses; they do not make paid calls. They exercise key gating, request protection, input validation, provider formatting, audio parsing and partial failure. Real microphone capture, Gemini account access, voice quality, latency and a full spoken exchange need your device/account test. No exact Baymax voice or hardware behavior has been demonstrated.

## Files and future ESP32 work

- `public/`: browser controls, recording, transcript editing and audio players.
- `server.mjs`: local HTTP gateway and request validation.
- `provider.mjs`: Gemini transcription, conversation and speech adapter.
- `test/`: run with `npm test`.

Browser recording → local gateway → Gemini transcript → reviewed text → Gemini reply → Gemini WAV speech → browser playback. A future ESP32 client will replace the browser's audio hardware. Deploying an authenticated online gateway and adapting its audio transport are separate later work; this local server alone is not the finished independent robot.

References: [Gemini audio input](https://ai.google.dev/gemini-api/docs/generate-content/audio), [speech generation](https://ai.google.dev/gemini-api/docs/speech-generation), [Flash-Lite model](https://ai.google.dev/gemini-api/docs/models/gemini-3.5-flash-lite).
