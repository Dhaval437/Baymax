# Baymax installed firmware — 19 October 2026

The complete integrated firmware was uploaded to the ESP32-S3 N16R8 on COM14 and its flash hash verified. It includes microphone capture, wake/conversation audio, PCA9685 motor gestures, phone Wi-Fi setup and wireless application updates. The build record is `verification/integrated-build.json`.

## Everyday use

1. Keep the laptop awake on the same Wi-Fi with the Baymax server running. Start it with `Start-Baymax.cmd` if it is not running already.
2. Power Baymax from its correctly wired external supply. No USB data cable is required for normal operation. Do not connect external +5 V to the ESP32 while it is also powered by laptop USB.
3. The ESP32 boots without waiting for USB, connects to its saved Wi-Fi and starts listening automatically. Say **Baymax** or **ouch**, wait for the greeting to finish, then ask your question. Replies open a 30?90 second follow-up window adapted to the current question and discussion. Saying **goodbye** returns it to wake listening.
4. If Wi-Fi drops, the firmware retries automatically. If the server is unavailable, it reports a failed request and resumes listening; restart the server and speak again.

The laptop supplies speech recognition, answer generation and voice synthesis. Disconnecting USB does not make this a standalone cloud device. The laptop server is currently `http://192.168.31.126:8788`; if its address changes, update the address through the phone setup page. The localhost dashboard is `http://127.0.0.1:8793/`. Its microphone graph and hardware status depend on USB serial and will become unavailable after unplugging; Wi-Fi conversation does not depend on the graph.

## Included motor settings

PCA9685 address 0x40, SDA GPIO8, SCL GPIO9. Head = channel 0, left arm = 1, right arm = 2. Motion is enabled in the installed private configuration. Greetings gesture with the head; subsequent replies alternate the arms. The 19 October smooth-motion update uses the full configured 1300–1700 microsecond range, a 1500 microsecond centre, and quintic easing at starts, reversals and stops. A gesture takes about six seconds under normal loop timing, returns to centre, then disables PWM. Delayed foreground processing advances only one animation frame, preventing catch-up jumps; a 12-second watchdog disables output if processing stalls excessively. This is 2.5 times the previous commanded excursion of 1420–1580 microseconds. It is not a measured 180-degree range. Mechanical fit and loaded travel still need physical observation. Continuous holding torque is not enabled.

The subsequent `2026-10-19-volume-v2` build raises the voice peak from 16000 to 20000 and quiet-sample amplification from 4x to 5x: another 25% digital amplitude (about 1.94 dB). Existing fades and digital headroom remain. Actual perceived loudness and amplifier distortion require listening on the robot. The running image and settings are verified in `verification/smooth-motion-release.json` after wireless installation succeeds.

## Conversation diagnosis — 19 October

The user's incomplete-context complaint has several concrete contributing limits in the current source: firmware captures at most 8 seconds, ends after 0.7 seconds below its speech threshold, and goes back to wake listening after 30 seconds without another turn. The server retains four exchanges, expires them after five minutes, clears them for a new wake, and slices generated replies at 300 characters. The recognizer is `tiny.en` with English explicitly selected; the local reply prompt also requests English. These are source findings, not proof that any one caused a particular misheard utterance.

Recommended next work (not implemented in this release): longer conversation capture with a more generous end-of-speech pause; multilingual recognition tested on the user's Marathi, English and mixed speech; a Marathi-capable TTS voice; language-matched replies; bounded conversation memory plus a concise problem summary; complete-sentence responses instead of raw character truncation. Preserve the speaker playback-duration and memory limits when increasing reply length. Evaluate the recognised transcript first, then answer quality, before choosing a larger reply model or cloud service. Marathi and mixed-language accuracy and latency need real sample recordings. The present Sopro voice is not a verified Marathi voice.

## Phone setup and later updates

See `PHONE_SETUP.md`. The initial USB installation is now complete. The setup network is available for three minutes after boot and reopens when Wi-Fi is unavailable. The private setup card is `assembly/private/BAYMAX_SETUP_CARD.txt`; do not share it. Wi-Fi passwords and the server address can be changed from your phone.

The matching wireless-update application is `output/phone-setup/Baymax-ESP32S3-application.bin`. It contains private configuration, so keep it private. Use the phone updater for compatible application updates. USB may still be needed for recovery if a future firmware cannot boot.

## Verification

33 Node tests passed, along with the native servo-controller tests and Wi-Fi/OTA input-policy tests. Compilation and USB upload passed. Fresh telemetry confirmed automatic listening, Wi-Fi connection, PCA9685 health and motor enablement. These checks do not prove physical motor travel, perceived audio quality or an external-power-only cold start. See `verification/final-release.json` for the recorded checks.

For the smooth-motion revision, the native tests additionally verify both travel endpoints on every channel, slow reversals, bounded PWM steps after a foreground stall, return to centre, the watchdog and I2C failure handling. Wireless installation evidence is in `verification/smooth-motion-release.json` when installation succeeds. The reusable local helper `node assembly/install-wireless.mjs ROBOT_PRIVATE_IP` pauses, updates and checks the reboot using the private setup key without printing it.

## Adaptive conversation update ? 19 October 2026

Revision `2026-10-19-adaptive-v1` replaces fixed four-exchange memory with a bounded context budget. Short exchanges remain verbatim; when the budget is tight, the local model summarizes older dialogue, retaining recent messages exactly. The prompt prioritizes newer corrections, open questions and relevant facts. A failed summarization keeps the stored history and uses a bounded recent subset for that reply; the dashboard marks reduced context. Repeated failures eventually discard the oldest raw exchanges to bound RAM. Model summaries are lossy and can make mistakes; they do not guarantee perfect recall.

The memory budget is 2600 estimated tokens including the latest input, using UTF-8 bytes / 3 plus message overhead for the current English pipeline. Ollama gets a 2048 or 4096 context and a 100, 200 or 360 generation-token allowance according to input size and answer detail. Estimates are not tokenizer counts. Older notes are passed as conversation data, not privileged instructions. Summary batches are bounded to avoid overflowing the model after repeated failed attempts. Summaries are generated only when needed, which can add latency on long discussions. See the synthetic real-model result in `verification/adaptive-model-test.json`.

Replies adapt to brief confirmations, ordinary questions and detailed explanations. The model is asked to finish sentences; the speech formatter retains complete sentences instead of slicing at 300 characters. Spoken output remains bounded to 110 words / 1600 characters and 60 seconds of PCM. Very long answers must be continued across turns. The answer model remains qwen3:1.7b; better context management does not eliminate model reasoning or recognition errors.

The microphone now ends a turn after approximately 0.85?2 seconds of quiet, increasing the allowance with voiced duration and observed within-turn pauses. This is acoustic pause detection, not semantic understanding of whether a person has finished. Capture and playback each have a 60-second ceiling. PSRAM buffers total about 4.8 MB. The robot still pauses capture during inference, speech and movement. Follow-up listening varies from 30 to 90 seconds. Say Baymax again to resume a still-retained session; a question in the wake utterance is answered instead of discarded. A bare wake phrase uses the cached greeting.

Conversation memory expires after 5?30 minutes of inactivity depending on the number of successful exchanges, or immediately on goodbye. It is RAM-only and clears when the server restarts. Dashboard transcripts clear after five minutes. The dashboard displays retained exchanges, whether earlier details are summarized, reduced-context warnings and the follow-up window. English speech recognition and the existing voice remain in place; Marathi is not enabled by this update. Volume stays at the previously installed 20000 peak with 5x maximum amplification, and the six-second motor gestures remain unchanged.

Validation: Node regression tests cover memory budgets, corrections, failed summaries, successful-turn-only commit, wake resumption, questions in wake utterances, longer audio and complete sentences. Native C++ tests cover adaptive silence timing, reset and the upper bound alongside the existing motor tests. The real local-model test recalls an early robot name/color and a corrected budget, then gives a brief acknowledgement. Firmware compilation and installed-image verification are recorded separately; no automated test proves microphone accuracy or perceived audio quality in the assembled robot.

## Friendly care, humor and quiet mode ? 19 October 2026

The server now recognizes ?I am satisfied with my care?, contractions, and simple Baymax/thank-you variants as explicit conversation endings. Negated, quoted, hypothetical and continued-question forms are not end commands. It speaks: ?I am glad I could help. I will be here when you need me. Say Baymax to wake me again.? The existing ESP32 `X-Conversation: end` handling returns to passive wake capture without powering down. The server also latches an awaiting-wake state, rejecting ordinary transcribed speech even if a stale client continues using the turn route. A recognized wake cue resumes replies and starts with cleared conversation memory. The latch works even if final speech synthesis fails. Wake capture still uses audio transcription; it is not a comprehensive distress detector.

The first synthetic test of unrestricted health prompting produced an unsafe invented remedy. That version was not deployed. Common-care responses now bypass the small generative model and use bounded, source-backed text for small skin cuts, minor heat burns, common colds, mild headaches and hydration. Recognized emergency phrases override joke requests. Medication selection/dosing and more complex recognized health concerns are referred to a clinician or pharmacist. Rules and prompts are incomplete and not clinical validation; unrecognized wording and transcription errors remain possible. This remains a toy with general educational guidance, not diagnosis, monitoring or a medical device.

Guide sources checked 19 October 2026:
- https://www.nhs.uk/conditions/cuts-and-grazes/
- https://www.nhs.uk/conditions/burns-and-scalds/
- https://www.nhs.uk/conditions/common-cold/
- https://www.nhs.uk/symptoms/headaches/
- https://www.nhs.uk/conditions/dehydration/
- https://www.nhs.uk/symptoms/chest-pain/

Explicit joke requests select a short family-friendly robot joke. Laughter requests produce spoken ?Ha ha? with a playful line; this is speech synthesis, not a recorded or generated natural laugh. Ordinary conversation still uses the adaptive local model and its warmer personality guidance.

Validation: 47 Node tests pass. Six synthetic response checks cover general first aid, jokes, spoken laughter, urgent-symptom priority, medication boundaries and an actual local-model encouragement reply. See `verification/companion-model-test.json`; these checks do not establish clinical safety or physical audio quality. No ESP32 rebuild is needed; the deployed firmware remains `2026-10-19-adaptive-v1`. The laptop service must be restarted to load this server update.
