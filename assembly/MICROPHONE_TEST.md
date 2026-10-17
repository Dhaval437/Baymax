# Microphone diagnostic — 15 October 2026

User confirmed microphone connected after instructions: round I2S board VDD->3V3, GND->GND, L/R->GND, SCK->GPIO4, WS->GPIO5, SD->GPIO6. Motor wiring remains PCA9685 SDA8/SCL9, head0/left1/right2. External motor supply stays off for this test. Microphone power must not use the5V motor rail. Amplifier/speaker not connected yet.

Firmware/MicrophoneDiagnostic is a separate sketch. It disables all16 PCA outputs with register readback at startup and before testing, holds old direct-servo pins16/17/18 low, and leaves amplifier data7 low. It receives commands through either native USB CDC or CH343 COM bridge. No automatic microphone acquisition on boot.

- M: bounded20-second measurement at16kHz,32-bit I2S left slot. Quiet first5seconds, speak next10seconds, quiet final5seconds.
- X: stop microphone acquisition.
- ?: software status.

Reports approximate AC RMS, mean, min/max, zero and clipping counts every second. I2S initialization and incoming samples alone do not establish that the microphone hears speech. Compare the quiet/voice/quiet levels. All-zero data, clipping, large DC or an unchanged level need investigation. This test does not perform speech recognition or assess intelligibility and stores no audio recording.

The servo diagnostic and main application remain separate source files. Once this sketch is uploaded, servo H/L/R commands are not available until the servo sketch or an integrated application is uploaded again.

First run: uploaded364640bytes/24376RAM on COM14, hashverified. M completed20seconds with about16k samples/sec, no read errors, no clipping, mostly nonzero data. First two seconds show large startup transient/DC; later RMS varied about104–962 (16-bit scale), with louder segments also in the instructed final quiet window. Real sample transport is established; speech correspondence and intelligibility are NOT established by this level-only test. Motors_off=1 and testing=0 confirmed afterward. Raw log: MIC_LEVEL_TEST_2026-10-15.txt.

User subsequently tested the live level graph at http://127.0.0.1:8792/ and explicitly confirmed that the microphone works properly. The latest graph run completed with 20 samples and no reported error. Microphone response is now user-confirmed; intelligibility and speech recognition have not yet been tested. The graph is served by assembly/microphone-monitor/server.py and records level statistics only.

Next step: connect the MAX98357A amplifier and speaker, then use a separate bounded, quiet playback test. No speaker test firmware has been uploaded yet. Main Baymax voice and automatic wake behavior are not yet verified.
