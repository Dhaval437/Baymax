# Three-servo assembly test — 4 October 2026

Pins: head signal GPIO16, left arm GPIO17, right arm GPIO18. Signals start LOW. No movement on boot. Only one servo receives PWM at a time.

Serial commands at 115200 baud:
- H / L / R: first command centres selected motor at 1500 us; repeating the same command within five seconds starts a gradual 1600 -> 1400 -> 1500 us sweep.
- C: centre head only.
- X: disable all servo PWM.
- ?: report configuration and active PWM without moving anything.
- Five-second timeout disables PWM, but does not disconnect motor power.

Upload with external supply OFF and its positive wire removed from ESP32 5V. Laptop USB powers the ESP32.

For the later SERIAL motor bench test, keep the external positive wire disconnected from ESP32 5V. External regulated +5V supplies servo RED wires only; external negative joins servo BROWN wires and ESP32 GND. ESP32 stays USB powered. Do not connect external +5V to ESP32 5V while using this arrangement. Leave horns off and test one motor at a time. The user's supply is reported as 5V / 2A; full robot current capacity has not been validated.

The finished external-only wiring diagram is a different arrangement: laptop USB must be disconnected before restoring external power to ESP32 5V input.

This firmware update adds arm test commands only. Hands-free conversation still requires implementation. Audio hardware and physical servo movement remain unverified. Do not infer shaft movement from a serial completion message.

Upload verified on COM13 (4 October): flash hash verified; firmware reports Head=16 Left=17 Right=18, PWM active 0 0 0. Only X and ? were sent, no movement command. Wi-Fi reported unavailable; serial servo tests do not require Wi-Fi. Compile: 955182 bytes flash, 55068 bytes static RAM.

With user-confirmed external servo power on: sent H to centre head, H for small sweep, then X?. Serial confirmed head centre, sweep complete, PWM active 0 0 0 afterward. No reset/disconnection observed during test. Physical shaft movement awaits user confirmation; arm tests not yet run.

After user confirmed split power and shared ground, ran one sequential H/H, L/L, R/R test with X? after each and two-second pauses. All three centre/sweep completion messages received; all three stop checks reported PWM active 0 0 0. No reset or serial disconnection observed. Physical movement of each motor still awaits user confirmation.
