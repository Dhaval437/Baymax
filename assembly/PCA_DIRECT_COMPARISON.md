# Direct head signal comparison

The calibrated channel3 output measured about50.07Hz with a1501.7us high pulse, but the user reported the subsequent head servo movement test stayed silent. Timing calibration did not establish or resolve the no-motion cause.

Firmware command D uses ESP32Servo on GPIO16 at50Hz for15seconds, with the same1300–1700us sweep. PCA outputs stay full-off. Boot stays idle; X detaches GPIO16 and drives it LOW as well as stopping PCA outputs. Both USB interfaces accept commands. Do not send D before the user confirms this wiring:

1. External5V off and USB unplugged.
2. Remove head servo plug from channel3. Use three male-to-female jumper wires to connect the servo plug individually (identify the servo's original wire colors, not the extension colors):
   - Servo orange/yellow signal -> ESP32 GPIO16.
   - Servo red -> channel3 middle red V+ pin.
   - Servo brown -> channel3 black GND pin.
3. Leave channel3 yellow PWM pin empty. Never connect PCA PWM and GPIO16 together. Remove any GPIO10 measurement jumper.
4. Keep existing PCA logic/I2C/common-ground wiring. Reconnect laptop USB and external5V motor supply.

Only the head is tested. The other servos can stay plugged in with outputs disabled. User observes movement; serial acknowledgement is not physical confirmation. If direct test succeeds, investigate PCA signal path/connector/output behavior. If it also fails, investigate servo/cable/power/common-ground path; neither outcome alone proves a single failed component.
