# Baymax — black base box and permanent wiring

Prepared 17 October 2026. This guide replaces the breadboard junctions and temporary direct-servo wiring described in the earlier bench notes. It preserves the current firmware pin assignments. No physical button is needed.

## What goes where

| Part | Position |
| --- | --- |
| ESP32-S3 | Inside base, with USB sockets accessible |
| PCA9685 servo driver | Inside base, with servo plugs and power terminal accessible |
| MAX98357A amplifier | Inside base, on insulated supports |
| Small solderable perfboard / power junction | Inside base; replaces breadboard connections |
| Low-voltage power entry and strain relief | Base wall |
| Optional 1000 µF capacitor, rated at least 10 V | Across 5 V and GND near servo power entry; striped negative lead to GND |
| Head servo | Neck |
| Left and right servos | Shoulders |
| Microphone | Behind front body sound opening; do not cover microphone port |
| Speaker | Behind rear body grille |
| Regulated 5 V adapter | Outside robot; only low-voltage DC enters base |

No solderless breadboard or MB102 regulator board is required with the regulated 5 V supply.

The illustration is a suggested arrangement, not a measured mounting drawing. The original base is approximately 100 × 85 mm outside, 94 × 79 mm inside, with about 30 mm internal height. Its old layout did not include the subsequently added PCA9685. Put the actual boards, connectors and wires inside and check lid clearance before drilling, fixing boards or cutting wires. Do not force a board into the old rails. Keep foot fasteners and cable passages clear.

## 1. Prepare without power

1. Unplug laptop USB and the external supply.
2. Photograph the working wiring and label each servo plug HEAD, LEFT and RIGHT.
3. Place the boards on insulated supports. Do not allow exposed solder joints to touch another board, a screw or loose metal.
4. Route the body cables through the leg passages before fitting bulky connectors. Leave enough slack for servicing and joint movement, but no loops near moving gears.
5. Keep the existing servo plugs removable. Solder the fixed wiring and junctions; do not solder the servos permanently into the robot.

## 2. Make the power junction

Use separate, labelled +5 V and GND junctions. Run separate power branches to the PCA9685 and amplifier; avoid passing motor current through the ESP32 or thin signal jumpers. Use suitable stranded power wire, for example 20–22 AWG for short power branches, and connectors rated for the supply current.

| Supply / junction | Destination |
| --- | --- |
| Regulated +5 V | PCA9685 green screw terminal marked V+ / + |
| Regulated +5 V | Amplifier VIN |
| Supply negative / GND | PCA9685 green terminal marked GND / − |
| Common GND | ESP32 GND, amplifier GND, microphone GND, PCA9685 logic GND |
| ESP32 3V3 | PCA9685 VCC, microphone VDD, amplifier SD |

Keep the 3V3 junction separate from the +5 V junction. **Never feed 5 V into microphone VDD or ESP32 3V3.** PCA9685 VCC is logic power; V+ is motor power. See [driver pinout reference](https://learn.adafruit.com/16-channel-pwm-servo-driver/pinouts).

### Two power arrangements

**While using laptop USB:** USB powers the ESP32. External 5 V powers the servos and amplifier. Grounds remain connected. Leave the external +5 V-to-ESP32-5V wire disconnected and insulated.

**Normal use with USB unplugged:** Feed the ESP32 pin labelled 5V from the regulated +5 V junction through a removable service connector; keep its ground connected. This lets plugging in the external adapter turn on the robot without a button. Before reconnecting laptop USB, disconnect that external positive feed to the ESP32. Do not assume this board isolates two simultaneous power sources.

This changes power wiring only. The current voice software still needs the laptop service running over Wi-Fi; removing the USB cable does not make speech processing independent of the laptop.

## 3. Servo driver signals and plugs

| ESP32 | PCA9685 |
| --- | --- |
| GPIO8 | SDA |
| GPIO9 | SCL |
| 3V3 | VCC |
| GND | GND |

Leave OE unconnected on the existing board with its pull-down. Leave address pads unchanged (0x40) and the logic-header V+ pin unused. No direct servo signal wires go to GPIO16, 17 or 18 in this arrangement.

| Motor | PCA9685 channel |
| --- | --- |
| Head | 0 |
| Robot's left arm | 1 |
| Robot's right arm | 2 |

On the pictured HW-170 board, channel 0 is at the capacitor end. Each servo connector spans all three rows: orange/yellow servo wire → PWM/yellow header, red → V+/middle red header, brown → GND/black header. Follow printed signal labels rather than relying on image orientation.

## 4. Microphone and amplifier signals

| ESP32 / junction | Microphone | Amplifier |
| --- | --- | --- |
| GPIO4 | SCK | BCLK |
| GPIO5 | WS | LRC |
| GPIO6 | SD | — |
| GPIO7 | — | DIN |
| 3V3 | VDD | SD |
| Common GND | GND and L/R | GND |
| External +5 V | — | VIN |

Make two insulated soldered branch junctions for GPIO4 and GPIO5: each goes to both audio boards. Microphone SD and amplifier SD are different functions and must not be joined. Leave amplifier GAIN unconnected.

Speaker wires go only to amplifier SPK+ and SPK−. **Neither speaker wire goes to GND.** These are bridge outputs. See [amplifier pinout reference](https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/pinouts).

Keep audio signal wires short, use a twisted pair for the speaker wires, and route microphone wiring away from motor power wiring where practical. Leave the ESP32 antenna clear of metal and tightly packed wiring.

## 5. Solder, check, then close

1. Transfer one labelled connection at a time from the breadboard to the soldered harness. Do not remove everything first and try to remember it.
2. Use heat-shrink over each exposed splice. On perfboard, check whether pads are isolated or connected before making junctions. Inspect for solder bridges and gently tug-test each joint.
3. With all power disconnected, check intended connections with the multimeter and check for a sustained short between +5 V and GND, or 3V3 and GND. A capacitor can cause a brief charging indication.
4. Confirm supply polarity at the connector before connecting electronics. Use the USB-testing arrangement for initial checks; leave motors unplugged first.
5. Verify the controller and audio, then connect and test one motor at a time. Keep hands and loose wires clear of horns. Stop a test if a joint binds.
6. Secure cables with strain relief. Check that the lid closes without pressing on headers, trapping wires or blocking USB access. Close it only after all checks pass.

Current integrated firmware defaults to motion disabled during assembly. Physical wiring alone does not enable joint movement; the assembled joints need centering and travel checks before enabling it.

## Illustration

`base_box_soldered_layout.png` was created with the built-in image generator. Its generated board details and robot shape are illustrative; use the tables above for wiring. The full generation prompt is in `base_box_image_prompt.txt`.
