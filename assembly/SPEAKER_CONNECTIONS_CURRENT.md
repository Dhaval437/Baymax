# MAX98357A speaker wiring

Proposed next wiring after the user confirmed the microphone response on 15 October 2026. Not yet confirmed physically connected or playback-tested.

Disconnect USB and external power while changing wires. Retain the microphone and PCA9685 wiring.

| Amplifier pin | Connect to |
| --- | --- |
| VIN | External regulated +5 V supply |
| GND | Common ground: external supply negative and ESP32 GND |
| BCLK | ESP32 GPIO4, shared with microphone SCK |
| LRC | ESP32 GPIO5, shared with microphone WS |
| DIN | ESP32 GPIO7 |
| SD | ESP32 3V3; enables amplifier and selects left audio channel |
| GAIN | Leave disconnected |

Use breadboard junctions to share GPIO4 and GPIO5 without disconnecting the microphone. Amplifier SD is an enable/channel-selection input; microphone SD is a different signal and stays on GPIO6.

Connect a 4-ohm or 8-ohm speaker across the amplifier's speaker + and - outputs. Neither speaker output connects to ground. The speaker impedance has not been verified from its label.

During computer testing, USB powers the ESP32. Do not connect external +5 V to the ESP32 5V pin simultaneously. Microphone VDD remains on 3V3. Existing microphone diagnostic firmware disables PCA9685 outputs; it does not play audio.

The planned test switches the ESP32 I2S peripheral from microphone input to speaker output; simultaneous recording and playback are not yet implemented. Start with a short, low-volume tone after physical wiring is confirmed.

Reference: https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/pinouts

15 October 2026: user confirmed speaker connected. MicrophoneDiagnostic extended with T: three faded 0.4-second notes (440/550/660 Hz), 0.4-second gaps, peak amplitude 1000/32768, 16 kHz 32-bit stereo identical channels, wall timeout 3 seconds, X cancellation. Compiled 370924 bytes flash / 24376 RAM and uploaded to COM14 with hash verification. One T run reported SPEAKER DONE and final motors_off=1, testing=0, speaker_active=0. Physical sound quality/audibility awaits user confirmation. Log: SPEAKER_TEST_2026-10-15.txt. Microphone M protocol is preserved.

User confirmed hearing the test but found it too quiet. Increased PCM peak from 1000 to 4000 (12.2% full scale, +12 dB digital amplitude). Compiled 370928 bytes, uploaded and hash verified on COM14. Three-note test completed; motors_off=1, testing=0, speaker_active=0 confirmed. Perceived volume and distortion at this setting await user feedback.

User requested a little more volume. PCM peak increased from 4000 to 5600 (17.1% full scale; approximately +2.9 dB). Compile and upload verified. Three-note test completed successfully on COM14; motors off and speaker inactive confirmed afterward. Audible quality awaits user feedback.

User requested another volume increase. PCM peak now 8000 (24.4% full scale; +3.1 dB from 5600). Compile and upload verified; three-note test completed, speaker inactive and all motor outputs off confirmed. This is test-tone amplitude, not a verified final voice volume.

User reported tearing/humming after the increase to peak 8000. Cause not established. Reduced peak to 4000 (-6 dB) and replaced 20 ms linear fades with 50 ms raised-cosine fades to reduce edge clicks. Compiled 371096 bytes and uploaded with hash verification; test completed successfully with speaker inactive and motors off. Await user report on breakup during notes versus hum after playback. Do not treat successful transmission as proof of clean acoustic output.

User requested Baymax voice playback. Embedded existing voice-sample-smooth-v2.wav (6.048 s, mono 24 kHz PCM16), scaled to peak 4000 with 30 ms raised-cosine edge fades using assembly/prepare-voice-sample.py; source WAV unchanged. Added V command with 8 s timeout, X cancellation, both stereo slots identical, motor-disable verification and 0.5 s trailing silence. Compiled 662232 bytes, uploaded/hash verified on COM14. run-speaker-test.ps1 -Voice completed VOICE DONE, then speaker_active=0 and motors_off=1. Audible clarity awaits user report. Log VOICE_TEST_2026-10-15.txt. M microphone graph and T tone commands remain supported.

User requested substantially louder voice. Source now multiplies embedded sample by 2 (peak 8000, +6 dB); compiled successfully at 662232 bytes. NOT uploaded: two attempts on COM14 failed with No serial data received, including retry at upload speed 115200. CH343 still enumerates COM14, but X? returned no firmware response. No voice test was run this turn. Last successfully installed firmware is the prior voice peak 4000 version. Next action: user puts ESP32 into download mode via BOOT held while pressing/releasing RST, then release BOOT; retry upload and bounded voice test.

After user reported ready following BOOT/RST: normal upload still failed No serial data received. Port inventory still only CH343 COM14 for the board. Direct esptool application-only attempt at 115200 with --before no-reset also failed before writing. Louder firmware remains compiled but NOT installed, and no playback occurred. Next physical recovery: turn off external supply, unplug USB, wait 5 seconds, reconnect USB to COM/USB-UART socket with external supply still off; check connection before restoring amplifier power.

Connection recovered on a later user-requested retry: CH343 remains COM14. Existing firmware answered status with motors_off=1, testing=0, speaker_active=0 and voice_test=V. Saved voice played once: VOICE DONE, final outputs idle. No new upload performed; the +6 dB version remains compiled but not confirmed installed. Actual cause of communication recovery unknown.

User confirmed hearing the previous voice and explicitly requested installation of the louder version. Successfully uploaded the compiled 662232-byte firmware on COM14; flash hash verified. Voice gain is now 2x embedded amplitude (peak 8000, +6 dB versus previous voice). One V playback completed VOICE DONE with final speaker_active=0, testing=0 and motors_off=1. The louder version IS NOW INSTALLED; acoustic clarity at this level awaits user report.
