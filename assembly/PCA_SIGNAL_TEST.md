# Physical PWM test — 14 October 2026

The firmware now supports `M`, an explicit five-second measurement. It never starts on boot. Do not send M until the feedback connection below is made.

1. Unplug ESP32 USB and switch off the external 5V motor supply.
2. Unplug the head servo from PCA9685 channel 3 (the fourth servo socket from the capacitor end).
3. Connect ONE female-to-female jumper from that socket's YELLOW PWM pin to the ESP32 pin printed **10**. Do not connect the middle red V+ pin to GPIO10.
4. Leave PCA VCC connected to ESP32 3V3, GND to GND, SDA to GPIO8 and SCL to GPIO9. Keep external motor power off. Reconnect ESP32 USB only.

The assistant can then send `M` over the detected ESP32 serial port at 115200 baud (both USB sockets are supported). The program commands channel3 at nominal 1500us / 50Hz, reads actual high and low pulse durations on GPIO10, and switches all channels off afterward. X cancels. Measurements are approximate software timing, not calibrated oscilloscope results.

Expected: high about 1500us, low about 18500us, frequency about 50Hz. Missing pulses do not alone prove a faulty PCA9685: the feedback connection, output enable and input path also matter. Register readback alone never proves a physical waveform.

After measurement: disconnect USB before removing the feedback jumper and reconnecting the servo. Do not leave the GPIO10 feedback attached for normal servo operation.

References:
- https://github.com/adafruit/Adafruit-PWM-Servo-Driver-Library/blob/master/examples/oscillator/oscillator.ino
- https://www.nxp.com/docs/en/data-sheet/PCA9685.pdf

