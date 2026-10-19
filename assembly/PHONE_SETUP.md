# Baymax phone setup

Built 18 October 2026. This is a mobile browser interface hosted by the ESP32 itself. It works without an app-store install. The initial firmware installation needs USB once; Wi-Fi changes and later compatible application updates use this page. The new firmware is **not installed or physically tested yet**.

Validation completed: final integrated firmware compiled for ESP32-S3 N16R8 (1,111,731 bytes reported code, 59,892 bytes globals); exported application image is 1,111,872 bytes and fits the 3 MiB OTA slot. ESP32-S3 header and phone-setup marker verified. Five network/dashboard tests, native C++ input/image-policy checks, and the mocked phone browser flows passed. The laptop launcher's check-only run passed without starting Baymax. No USB ESP32 was detected at completion, so no firmware was uploaded. The old conversation test remains stopped; only the disabled localhost design preview is running at http://127.0.0.1:8794/?preview=1.

## The first installation

1. Keep the robot clear of obstructions; the integrated firmware retains its existing automatic-listening and calibrated motor settings after boot. Connect the ESP32's usual data USB port to the laptop. Do not wire two positive power sources into the ESP32.
2. Install the integrated build with `assembly/Build-Baymax.ps1 -Upload -Port COM14` (use the actual USB port if it changed). This compiles and uploads the complete Baymax firmware, including phone setup. A standalone LED demo is not used.
3. Keep `assembly/private/BAYMAX_SETUP_CARD.txt` private. It contains the setup network password and the page unlock key. No home Wi-Fi password or conversation token is displayed by the phone page.

## Connect Baymax to a new Wi-Fi — from your phone

1. Power Baymax on. On your phone, open **Settings → Wi-Fi** and join **Baymax-Setup-xxxxxx**, using the password from the setup card. The last six characters identify this ESP32.
2. If your phone says **No internet**, choose to stay connected. Open Safari/Chrome and enter **http://192.168.4.1** explicitly. A captive-browser popup is optional; the manual address is the reliable route.
3. Enter the same setup key to unlock the page. Under **Choose Baymax's Wi-Fi**, enter the network's exact name and password, then **Connect & save**. Only ordinary 2.4 GHz open/WPA-personal networks supported by the ESP32 are targeted; 5 GHz-only, enterprise login and hotel sign-in pages are unsupported.
4. Baymax tries the network before saving. The phone may briefly disconnect when the ESP32's radio switches channel; rejoin Baymax-Setup and reopen the page if needed. A bad password or unavailable network retains the old saved settings. Allow around 25 seconds for a failed attempt.
5. Put the laptop on the same network and run **Start-Baymax.cmd**. Copy the printed **Phone setup server address** (for example `http://192.168.1.20:8788`) into the phone page and tap **Save laptop address**. Use the laptop's private IPv4 address with port; do not append `/device/turn`.
6. Tap **Resume Baymax**, then say **Baymax** or **ouch**. Wi-Fi status confirms a Wi-Fi connection, not successful AI/audio playback; verify a spoken reply. After setup you may return the phone to your normal Wi-Fi.

The setup network opens for three minutes after power-on, remains while a phone is connected or setup has paused Baymax, and reopens after around 20 seconds without Wi-Fi. When on the same network, try `http://baymax.local` or the robot IP displayed in the page. mDNS availability varies by phone/router; power-cycling and using the setup network is the fallback. No new physical button is required.

If a phone is itself providing the hotspot, its ability to join a separate setup network at the same time varies. Use another phone/tablet for setup if necessary. Guest networks/client isolation and Windows firewall rules can prevent Baymax from reaching the laptop even after Wi-Fi connects. Use your own trusted LAN; do not expose port 80 or 8788 to the internet.

## What still needs the laptop

Microphone audio processing, answer generation and voice synthesis still run on the laptop. Changing Wi-Fi does not make Baymax an independent cloud robot. Start-Baymax now selects a current private Wi-Fi address instead of refusing to start when the old compiled address changes. With multiple ambiguous adapters, set `BAYMAX_BIND_ADDRESS` to the laptop's Wi-Fi IPv4. Existing private device-token matching is retained.

The old microphone graph at port 8793 still uses the USB serial monitor. Conversation can work over Wi-Fi without that graph; this setup page shows wireless connection/listening status, not a wireless microphone waveform. Moving the live graph to wireless is not part of this change.

## Wireless updates after the first USB installation

1. Build the integrated firmware using `assembly/Build-Baymax.ps1`. The output **output/phone-setup/Baymax-ESP32S3-application.bin** is the application image for wireless updating. Keep it private: firmware embeds device configuration. Do not use `.merged.bin`, `.bootloader.bin`, a partition binary or the 3 mm LED demo.
2. Copy that application file to your phone, open Baymax's setup page, unlock it, and expand **Wireless firmware update**.
3. Select the file, tick the power reminder, and tap **Install update**. Keep stable power throughout upload and restart. The robot pauses microphone and motor output while updating; a completed update reboots into normal automatic behavior.
4. The updater checks authentication, a per-boot request token, image size, ESP32-S3 image header and the Baymax setup marker before committing the inactive application slot. These checks prevent common wrong-file mistakes; they are **not cryptographic firmware signing**. Only install your trusted builds.
5. Interrupted/invalid uploads do not select the new boot partition. Resume the previous firmware or retry after reconnecting. This project does not promise automatic rollback of a successfully installed but buggy application; USB remains the recovery method if an update cannot boot. Do not remove phone-setup support or change partition layout in a wireless update.

The phone key is held only in page memory. Locking/reloading clears it. Wi-Fi credentials are stored in the ESP32's ordinary NVS (not encrypted flash), only after a successful connection. Settings/API responses never return saved passwords. The UI is local HTTP on a password-protected setup network or trusted LAN, not HTTPS; use the setup hotspot when entering credentials on an unfamiliar network.

## Design and validation files

- `public/phone-setup.html`: mobile page source; no remote fonts/scripts/assets.
- `firmware/MiniBaymax/PhoneSetup.h`: setup hotspot, protected HTTP API, saved network settings and OTA updater.
- `firmware/MiniBaymax/SetupPolicy.h`: host-tested credential, private-server-address and image-header validation.
- `assembly/prepare-phone-setup.mjs`: embeds the page and creates/preserves the private setup key/card. Never commits the key.
- `assembly/verification/phone-setup-mobile.png`: clearly labelled design preview.
- `assembly/verification/phone-setup-browser.json`: browser tests use a mock ESP32; they do not prove physical Wi-Fi provisioning or OTA behavior.
- `assembly/verification/integrated-build.json`: actual firmware build hash and upload status.

Built using Espressif's [Wi-Fi APIs](https://docs.espressif.com/projects/arduino-esp32/en/latest/api/wifi.html) and [web OTA approach](https://docs.espressif.com/projects/arduino-esp32/en/latest/ota_web_update.html). Hardware acceptance still requires: initial USB install, correct/incorrect-password provisioning, reboot persistence, physical reply test, then an actual OTA update and reconnect test.
