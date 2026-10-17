# Baymax servo wiring — current, 15 October 2026

This replaces the temporary GPIO16 direct-motor test and temporary head channel3 mapping. User confirmed all three motors work after finding an internally broken motor-power wire. Normal PCA9685 motor operation after that repair remains to be tested.

## Connect with both power sources off

Unplug laptop USB and switch off external5V. Keep microphone and amplifier disconnected for this stage. Remove the temporary servo-signal jumper to ESP32GPIO16 and the measurement jumper toGPIO10. Leave ESP32GPIO16/17/18 unused for normal PCA control.

| ESP32-S3 printed pin | PCA9685 logic-header label |
| --- | --- |
| 3V3 | VCC |
| GND | GND |
| 8 | SDA |
| 9 | SCL |

Leave OE unconnected (board has a pull-down); do not connect it to VCC. Leave the logic-header V+ pin unused. Leave address solder jumpers unchanged, address0x40.

Use the green screw terminal for motor power. Connect the repaired external regulated5V positive output to terminal V+ / +, and negative output to terminal GND / -. Follow printed terminal labels rather than left/right orientation. This ground is shared with ESP32 through the logic GND wire. Keep external +5V disconnected from ESP32's5V pin while laptopUSB powers ESP32. Motor power goes directly to the screw terminal, not through the breadboard.

## Three servos

| Function | PCA channel |
| --- | --- |
| Head | 0 |
| Left arm (Baymax's left) | 1 |
| Right arm (Baymax's right) | 2 |

On the photographed HW-170 board, channel0 is the three-pin servo socket nearest the large cylindrical capacitor. The next socket is1, then2; channel3 is the fourth socket. Each channel consists of one yellow PWM, one red V+, one black GND pin across the three colored rows.

Plug each servo's three-hole connector across the three colors: orange/yellow signal wire to yellowPWM, red wire to redV+, brown wire to blackGND. Leave channel3 empty for now. No servo signal wire connects directly to the ESP32 in this normal configuration.

## First test

Reconnect laptopUSB (either socket supported by current diagnostic) then turn on external5V. Keep servos free of the printed mechanism for initial testing. The firmware does not move motors on boot.

Assistant sends H for head0, L for left1, R for right2, one at a time. Each command runs a15-second1300–1700us sweep and stops. X cancels and switches all PCA outputs off. Timing uses a measured oscillator estimate26.92MHz and divider131, producing about50Hz.

Confirm each motor physically moves on its own channel before connecting microphone or speaker. Serial status alone is not physical confirmation. Centre and mount servos before determining safe assembled motion limits.

The diagnostic retains D/C for the old directGPIO16 setup and M for waveform feedback. Do not use these commands with normal wiring. Main Baymax voice/application firmware is separate and is not running on the board yet.
