> Updated 16 October 2026: see [SOFTWARE_READY.md](SOFTWARE_READY.md) for the integrated, button-free PCA9685 firmware and current startup instructions. The older notes below describe earlier bench stages.

# Head servo bench test

## Status — 3 October 2026

Photo check: servo brown -> dark jumper -> GND; servo orange -> red jumper -> GPIO16; servo middle red -> purple jumper -> board pin labelled 5V. This is a temporary attempt using laptop USB for one unloaded SG90, not a verified power arrangement for the assembled robot.

The USB cable shown has a visibly damaged covering at its connector. User confirmed replacement with another cable before this test. Keep the horn and printed head off. Disconnect USB before touching wiring. Leave microphone, amplifier and other motors disconnected.

Source now enables the head test with ENABLE_SERVO=1. Corrected the LEDC timer resolution from 16 to 14 bits to match the ESP32-S3 SDK limit. Compilation passed: 954758 bytes program storage, 55036 bytes static RAM. Uploaded on COM13 with flash hashes verified. Serial confirmed centre at 1500 us, sweep completed and returned to centre, then PWM disabled by X. No reset appeared during the command sequence. Physical movement awaits user observation; serial completion alone does not prove shaft movement.

## Test behavior

GPIO16 starts LOW, with no automatic motor command at boot. GPIO17/18 remain unused.

- C: centre at 1500 microseconds.
- H: centre if not yet attached; otherwise sweep slowly through 1600, 1400 and 1500 microseconds. These are pulse widths, not calibrated angles.
- X: disable PWM immediately when the serial command is processed.
- After five seconds without a new movement command, PWM automatically detaches. This does not disconnect the servo's power.

A small sweep takes approximately two seconds. Test once, observe motion, then stop. If the board resets, the motor repeatedly buzzes without moving, or anything gets hot, unplug USB. Do not hold the shaft or run against a mechanical stop.

The automatic timeout is processed by the firmware loop; avoid the talk button and network/audio operations during bench testing. Head commands disable wake listening. The laptop voice server is not required for this serial test.

## Later assembly and power

Use a suitable regulated external 5V supply for the assembled system. With ESP32 on laptop USB, external positive goes only to servo red; external negative joins servo brown and ESP32 GND. Do not join external positive to the USB-powered board's 5V pin in that arrangement.

Centre electrically, unplug power, then fit the stock horn with the head facing forward. Calibrate the final travel on the assembled mechanism.



User observation after the first 14-bit PWM test: no motor movement. Treat the motor test as FAILED despite serial sweep completion. PWM was disabled with X. Next diagnosis: verify power at the servo, connector contact and board-specific USB-to-5V routing before further motion tests. Do not infer motor failure or adequate power from serial status.

UNO isolation test, 3 October: official Arduino AVR core 1.8.8 installed. Uno identified on COM11. UnoServoCheck compiled (2160 bytes flash, 188 bytes RAM) and uploaded successfully. Serial ready message received (partly duplicated); T command sent once. Four seconds later ReadExisting failed because serial port had closed. Completion and physical motion NOT confirmed. User instructed to unplug; do not automatically retry. Cause undetermined: possible USB contact/power issue. ESP32 was disconnected for this test.

User explicitly requested one retry. COM11 ready confirmed; one T command sent. Serial reported 'Servo test starting.' then 'Test ended; pulses off.' No disconnection observed on this retry. Physical movement awaits user confirmation.
