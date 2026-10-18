# Baymax integrated software — 16 October 2026

The integrated code is in `firmware/MiniBaymax`. It replaces the old button-operated/direct-servo application. On 17 October 2026 it was uploaded successfully to the ESP32 on COM14 for the requested voice-only conversation test. The diagnostic source remains available for rollback. Wi-Fi connection, microphone capture and a request reaching the laptop were verified; user confirmation of the live wake greeting and question/answer playback is still pending.

## What it does

1. On power-up, connects to the configured Wi-Fi and starts listening automatically. There is no talk button.
2. Captures speech after a sound rises above the microphone threshold, including the preceding quarter-second. Ends a recording after 0.7 seconds of quiet or eight seconds maximum.
3. While idle, reacts to recognized **Baymax**, **ouch**, **ow**, **ah**, or extended **aaa/aaah**. Ordinary speech is ignored in this mode. A noise alone does not establish that someone is hurt: recognition can miss cries or mishear sounds.
4. Plays the greeting, then listens for your answer for 30 seconds. Each successful response opens another 30-second answer window. Say **goodbye**, **go to sleep**, or **stop** to end the conversation; it then waits for its wake phrase again.
5. Pauses microphone recording during processing and playback, waits after playback, then resumes. The shared microphone/amplifier clocks are used sequentially.
6. Uses local Whisper, Ollama and the existing smooth voice generator on the laptop. Keep the laptop awake, connected to the same Wi-Fi, with `Start-Baymax.cmd` running. This version is not standalone without the laptop.

Local model generation can take several seconds or longer. The ESP32 polls for completion rather than holding one long HTTP request. It downloads the complete PCM before playback to avoid network-induced audio gaps. Audio uses the tested 24 kHz / 32-bit stereo I2S output, identical left/right samples, a peak ceiling of 12000, amplification capped at 3x, and short fades. Amplifier loudness/distortion still needs the later physical audio work you requested.

### Faster local speech — 17 October

The launcher now warms a persistent Python speech worker once. Sopro's voice model, its prepared reference voice, and Whisper stay in memory for subsequent requests, instead of starting a Python process and loading models for every turn. Voice model precision, generation settings and smoothing filters are unchanged. Cached models load offline. The worker uses private stdin/stdout pipes, a bounded queue, operation timeouts and restart-on-next-request after a crash. No new network service is exposed. Set `BAYMAX_LEGACY_SPEECH=1` for the previous per-request path when diagnosing a regression (restart required).

Measured with the same test sentence: previous voice process 18.225 s; resident requests 3.582 s and 3.234 s after an 8.555 s one-time preparation. This is a local synthesis benchmark, not a guarantee of robot end-to-end latency; generated speech length and laptop load vary. Full results: `assembly/verification/speech-latency.json`. Reply text still appears before synthesis completes; the dashboard explicitly labels that interval as audio creation.

## Start after assembly

1. Double-click **Start-Baymax.cmd** in the Baymax folder. Leave its window open. It checks the local tools and matching firmware settings before starting the robot server.
2. Upload the integrated firmware once, using the COM/USB-UART Type-C port and the board's detected COM port. The prepared command is:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\assembly\Build-Baymax.ps1 -Upload -Port COM14
   ```

   COM14 was the last tested port; use the current port if Windows changes it. Close any serial monitor or diagnostic test using that port first. Uploading restarts the board and begins listening.
3. Say **Baymax**. Wait for its greeting to finish, pause briefly, then speak your answer.

The saved laptop address was updated to **192.168.31.126**. A router DHCP reservation is useful. If that address changes, update only `DEVICE_URL` in private `config.h` and rebuild/upload. The launcher checks this mismatch instead of silently starting an unreachable service. Keep this LAN-only service off public port forwarding.

## Movement and assembly

Motor support is implemented for PCA9685 **head 0, left arm 1, right arm 2**, SDA **GPIO8**, SCL **GPIO9**, address **0x40**. It uses the measured oscillator **26,920,000 Hz**, prescale **130**, about **50.07 Hz**. All 16 channels are switched off at boot; there are no old direct GPIO16/17/18 servo commands.

**The current private device configuration enables movement for the requested combined voice/motor test (17 October).** `config.h` overrides `BAYMAX_MOTION_ENABLED` to `1`; the shared default in `RobotSettings.h` remains `0`. Head channel 0 gestures on greetings; reply gestures alternate arm channels 1 and 2. The initial 1400–1600 µs bounds are conservative commissioning values, not measured mechanical limits. Actual assembled movement still needs observation. To return to voice-only operation, set the private override to `0` and rebuild/upload.

When enabled, a greeting triggers a small head gesture; replies alternate small arm gestures. Only one joint moves at a time. Each movement ramps smoothly, returns to centre and turns its PWM off within 3.5 seconds. This does not provide continuous holding torque. I2C errors disable motion until restart. Actual loaded-joint travel and neutral positions still require assembly testing.

## Serial controls (115200, either ESP USB interface)

### Live conversation dashboard — added 17 October

Open **http://127.0.0.1:8793/** after starting `Start-Baymax.cmd`. The launcher now starts this dashboard automatically. It shows the real ESP32 microphone RMS graph and capture threshold, fresh USB/Wi-Fi/motor state, recognised transcript, reply text, elapsed recognition/thinking/voice-generation times, and the robot's playback-completion report. Response preparation time excludes playback; the completion report includes time from audio submission through playback when available. It is elapsed time, not a predicted completion time.

Keep the ESP32 connected to COM14 by USB for live telemetry (or set `BAYMAX_SERIAL_PORT`). Wi-Fi still carries the audio. The dashboard reader sends only `?` status requests and never moves motors or starts extra recordings. Close other serial monitors; the dashboard owns the port while the server runs. Stop the launcher before another upload or serial diagnostic. The older port-8792 graph is for diagnostic firmware and should not be started with integrated firmware.

Transcript/reply data is retained in process memory for five minutes and served only through the local dashboard, with no credentials exposed to the browser. The LAN `/device/status` response remains free of transcripts. No raw audio is retained for the dashboard. Browser tools do not request laptop microphone access. Stale/disconnected telemetry is labelled, and processing/playback gaps are not filled with invented microphone data.

Verification: 27 automated tests passed; a headless browser confirmed live ESP32 graph rendering, no page JavaScript errors, and no desktop/mobile horizontal overflow. During the live test the ESP32 reported playback completion and the server recorded two completed replies. This does not independently establish perceived sound quality.

| Command | Action |
|---|---|
| `?` | State, Wi-Fi, listening, PCA health and motion enable status |
| `X` | Stop listening/playback and switch motor PWM off |
| `W` | Resume listening when stopped; stop when listening |
| `H`, `L`, `R` | One bounded head/left/right gesture, only when motion is enabled and no speech request is active |

`LEVEL rms=… trigger=…` reports microphone level and its threshold once per second. Adjust `BAYMAX_MIC_THRESHOLD` only after inspecting the actual room's levels. A short network transaction may delay a serial stop by a few seconds; power removal is the immediate stop. The old port-8792 microphone graph remains a tool for the diagnostic firmware, not the integrated firmware.

## Checks and files

- `npm test`: device API, conversation, wake, errors and existing browser/provider tests.
- `assembly\test-firmware-host.cmd`: compiles the real servo-controller header against a simulated I2C bus; verifies disabled startup, channels, pulse bounds, return to centre, stop and failures.
- `npm run check:robot`: credentials-match check (no secrets printed), laptop address, speech tools and Ollama model.
- `npm run test:live`: real local transcription → chat → synthesis → asynchronous PCM download using the saved voice sample. Does not activate hardware.
- `assembly\Build-Baymax.ps1`: compile only by default. `-Upload` is the explicit upload option.
- `assembly/verification/`: build hash and real-pipeline test report. Build output is under `.tools/build/baymax-integrated/`.

The new firmware still needs an end-to-end test on the assembled robot. Compilation and simulated motor tests cannot prove wiring, sound quality, microphone sensitivity or mechanical travel. The existing working diagnostic code is preserved under `firmware/MicrophoneDiagnostic` and `firmware/PcaServoDiagnostic`.

Raw recordings are temporary local files deleted after recognition. Accepted conversation history is held in laptop RAM, limited to four exchanges and cleared after five minutes without a turn. Temporary audio results expire after eight minutes. `.env`, private `config.h`, and compiled firmware contain private configuration; do not share them. The example configuration now contains placeholders only.

