> Updated 16 October 2026: see [SOFTWARE_READY.md](SOFTWARE_READY.md) for the integrated, button-free PCA9685 firmware and current startup instructions. The older notes below describe earlier bench stages.

# Mini Baymax: first hardware assembly

**Arrival update, 29 September 2026:** the ESP32-S3 board and two speakers are visible in the delivery photo. The user confirms the INMP441/MAX98357A combo has **not** arrived yet and has a USB-C data cable. Therefore the next test is ESP32-only over USB; audio wiring waits for the combo. The module's N16R8 marking, soldered headers, and actual PSRAM have not yet been confirmed. Disk space has increased since the note below; the official Espressif board package is being installed for a compile check.
The user has since confirmed the module reads **N16R8** and its headers are soldered. With the board connected, Arduino CLI detected **COM12** as a USB serial device with Espressif vendor ID `0x303A`. The first upload on COM12 did not receive a bootloader response. Holding BOOT, tapping RESET and releasing BOOT made it reappear as **COM13**, and the firmware then uploaded successfully. A later firmware update uploaded automatically on COM13. If the port changes, re-detect it rather than assuming a fixed COM number.

The full sketch compiled with ESP32 core 3.3.12, 16 MB flash, OPI PSRAM and USB CDC on boot. The board-only test **passed**: upload hashes verified, esptool identified ESP32-S3 with 8 MB PSRAM, and the running sketch reported `Flash 16 MB, PSRAM 8 MB`. The audio boards have not arrived, and their wiring, microphone capture and speaker playback remain untested.

**Wi-Fi and laptop link also passed:** using private home Wi-Fi credentials stored only in the local configuration, the ESP32 made an authenticated `GET /device/ping` request to the laptop server. Serial reported `HTTP 204 (reachable)`. Device-specific network addresses and credentials are intentionally omitted from the repository. Recheck the current local addresses before a later test.

This is the laptop-connected build. The ESP32-S3 handles the button, microphone, speaker and later the arm. Your laptop does speech recognition, conversation and the accepted smooth voice. Both devices must share Wi-Fi and the laptop must stay on. Moving the server to a suitable cloud host is a later milestone; no free cloud service has yet been proven to run these local models.

## Before connecting anything

Check the delivered ESP32 label/specification says **S3 N16R8** (16 MB flash, 8 MB PSRAM). Inspect the antenna and USB connector. The sketch requires working PSRAM. Check the delivered module pin labels against the table below: GPIO numbers are not header positions. The two audio boards may print different abbreviations; do not guess a pin from its physical location. Photograph their labels if any differ.

Use an existing USB-C **data** cable for the ESP32. The Uno's USB-B plug will not fit. For the first audio test, power the ESP32 through USB-C, leave the servo disconnected, and use one supplied passive speaker. The firmware starts with low speaker volume to limit load on the board's 3V3 regulator; full volume needs a separately verified supply. Keep the parts on the breadboard only for testing. Power off USB before moving a wire. A speaker connects to the amplifier's **SPK+ and SPK-**, never to ground.

## Signal wiring for bench test

All GND connections below must join. Use the ESP32 **3V3** pin for the microphone. The MAX98357A module must have a compatible VIN range printed on the board or verified from its product documentation; many breakouts accept 3.3–5 V. Begin at **3V3** with one speaker and low playback level. Do not connect any ESP32 GPIO to 5 V.

| ESP32-S3 GPIO/pin | INMP441 microphone | MAX98357A amplifier | Other |
|---|---|---|---|
| 3V3 | VDD / VCC | VIN, if breakout confirms 3.3 V support | |
| GND | GND and L/R (left channel) | GND | One side of talk button |
| GPIO4 | SCK / BCLK | BCLK | Shared I2S clock |
| GPIO5 | WS / LRCL | LRC / WS | Shared I2S word select |
| GPIO6 | SD / DOUT | | Microphone data to ESP32 |
| GPIO7 | | DIN | ESP32 data to amplifier |
| GPIO15 | | | Other side of talk button; internal pull-up enabled |
| GPIO16 | | | Servo signal **later**, after power check |
| amplifier SPK+ and SPK- | | | Across one passive speaker's two terminals |

Leave amplifier `GAIN` and `SD/EN` at their board defaults unless the delivered module's documentation requires a connection. Do not attach an extra microphone or speaker to the Uno. The Uno is not used inside this version.

### Servo power is a separate check

The existing servo is suitable for a first arm test, but its model and stall current have not been verified. Do **not** power it from an ESP32 GPIO, the ESP32 3V3 pin, the Uno 5V pin, or an unverified barrel adapter. Before enabling it, read the existing adapter's **OUTPUT** label and polarity, confirm a regulated 5 V supply with enough current for the servo, and connect its ground to ESP32 GND. Supply 5 V only to the servo's red power lead; brown/black is GND; orange/yellow is signal to GPIO16. Keep `ENABLE_SERVO 0` until the power check and arm clearance test pass. If no suitable adapter exists, that is the one possible additional purchase, chosen after reading its specifications.

## Software already prepared

`firmware/MiniBaymax/MiniBaymax.ino` is the ESP32 sketch. `firmware/MiniBaymax/config.h` stores local Wi-Fi and device credentials and is excluded from source control. `device-server.mjs` is a separate, token-protected laptop endpoint for the robot; the browser prototype at port 8787 stays local to the laptop. The device endpoint is HTTP for **home-LAN testing only**. Never forward port 8788 through the router or use it over public Wi-Fi. The sketch has been checked against the official Arduino-ESP32 API definitions. A full compile and actual upload remain to be completed as the board is brought up.

When the board arrives:

1. Confirm the board model and PSRAM. Plug it into the laptop via USB-C with **no other wires**. Upload the sketch with board type ESP32S3 Dev Module, PSRAM **OPI PSRAM**, and 16 MB flash if the menus offer these choices. Set USB CDC on Boot to Enabled to see Serial messages. Do not configure `ENABLE_SERVO 1` yet.
2. In `firmware/MiniBaymax/config.h`, fill `WIFI_SSID`, `WIFI_PASSWORD`, and the laptop's Wi-Fi IPv4 address in `DEVICE_URL`. Do not share this file or its token. The laptop address should be on the same Wi-Fi as the ESP32. The URL must remain `http://<laptop-ip>:8788/device/turn` for stage one.
3. Set `BAYMAX_DEVICE_HOST` in your local `.env` to that same laptop IPv4 address and restart the device server with `npm run start:device`. A Windows firewall prompt may appear: permit only the **Private** home network. Do not permit Public networks. Keep the device-server terminal open.
4. Open Serial Monitor at 115200. Verify it prints an IP and “Hold the talk button...”, **without** a PSRAM error. This first flash is an electronics check, not a detour; it tells us whether the purchased board can hold the recording.
5. Disconnect USB. Wire the button, microphone, amplifier, and one speaker exactly as above. Reconnect USB. Hold the button, say a short sentence, and release. The serial output should say “Listening...”, then “Thinking and speaking...”, then “Ready.” Test three turns and note sound volume, latency and transcription accuracy.
6. After the correct 5 V servo supply is confirmed, attach only its signal and common ground, enable the servo in `config.h`, and test motion **without** the printed arm. Then fit the arm and reduce the angle range if it touches the body. Only after reliable bench tests do we close the wiring inside the printed body.

If your router isolates Wi-Fi devices or the Windows firewall blocks the private port, the board may join Wi-Fi but fail to reach the laptop. We will diagnose that from Serial output before changing code or buying parts.

## How it works

Hold button → ESP32 records up to 8 seconds of 16 kHz mono WAV into PSRAM → authenticated request over local Wi-Fi → laptop transcribes and generates a reply → laptop synthesizes the smooth 24 kHz voice → ESP32 plays it through the amplifier and speaker. The microphone is off while Baymax speaks to avoid feedback. A wave can be added after safe servo power is verified. The total latency depends on laptop model speed and Wi-Fi; it has not yet been measured on the hardware.

## What can and cannot be guaranteed today

The laptop audio pipeline has passed a real WAV-in/PCM-out conversation, and the device endpoint has automated tests. The actual ESP32, received audio modules, speaker, power adapter, and enclosure cannot be proven until delivery and bench tests. A purchase or software compile does not provide a 100% hardware guarantee. Save the packaging and test the parts within their stated return/replacement window.
