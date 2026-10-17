# Baymax parts inventory from photographs

## Update — 1 October 2026

- User plans three matching TIANKONGRC SG90 motors total; only one has been confirmed physically present. Use the supplied horns, with replaceable adjustable mounts. The new ruler photo is reference evidence, not a precise shaft-offset measurement.
- Fit samples have been printed in Fulton and await delivery; CAD work continues while they travel.
- Breadboard power module photographed again: user-measured overall envelope **54 × 34 × 30 mm**, including components and bottom pins. Connector/wire clearance is extra. MB102-style appearance; regulator markings, circuit variant and current capability have not been verified. Do not count this as a confirmed supply for three servos.
- Current base has approximately 30.27 mm clear floor-to-roof height away from obstructions. The 30 mm module cannot be given a practical upright mount there without changing the layout. Do not enlarge the robot solely for this optional module before deciding whether it is electrically useful.

Reviewed: 28 September 2026. Based on the six supplied photographs, not physical inspection or electrical tests. Several photographs repeat the same parts; quantities below are not added across photos. Model names marked likely need readable markings before wiring.

## Reuse first

| Part seen | Identification and quantity | Planned use |
|---|---|---|
| Arduino Uno and blue USB cable | One board, Uno R3 confirmed by user; USB-A to USB-B cable visible | Bench experiments with button and arm movement; not required inside final S3 robot |
| Blue micro servo with three-wire lead | One clearly visible; SG90-style, exact model/travel unverified; white horn appears present | First waving arm after checking power, centering and travel; check retaining screw |
| Solderless breadboards | Two visible, one long and one smaller | Prototype signal wiring |
| Jumper wires and male pin headers | Multiple bundles and strips; exact quantities uncounted | Prototype connections; secure final power wiring separately |
| Resistors and LEDs | Assorted bags; resistor values not readable | Status indicators and basic circuits after identifying values |
| Small-component box | At least one tactile-switch-shaped component is visible; full contents obscured | Likely source of a prototype talk button; identify out of the box |

Do not buy duplicate breadboards, jumper-wire packs, LED/resistor assortments or the first servo before testing these.

## Other visible modules

| Part seen | Confidence / likely identity | Relevance |
|---|---|---|
| Five-wire geared motor and matching driver | Stepper motor and driver clearly visible; likely 28BYJ-48 plus ULN2003; voltage unverified | Useful separate motor experiment; keep servo for first shoulder |
| Bag labelled Wi-Fi module ESP8266 ESP-01 | Label readable; PCB markings partly obscured | Useful Wi-Fi experiment; retain S3 purchase for the planned integrated audio design |
| Red sound-detection board with microphone capsule and adjustment pot | Sound detector clearly visible; likely KY-038/LM393 style, exact model unconfirmed | Optional sound-threshold/clap experiments; not a confirmed speech-quality microphone substitute |
| White dome sensor | PIR motion sensor, likely HC-SR501 style | Optional later motion-triggered greeting; does not identify people |
| Blue board with two round transducers | Ultrasonic distance sensor, likely HC-SR04 style | Optional later distance experiments; not medical sensing |
| Green character LCD | Likely 16x2 character display; exact model/interface board unknown | Bench display if desired; unnecessary in first body |
| LED dot-matrix module | 8x8 display visible; MAX7219-type driver likely | Optional display experiment |
| Board with two blue relay blocks | Two-channel relay module | Unnecessary for this robot |
| RFID-labelled bag with tag/card | RFID module/tag kit; RC522 likely but markings obscured | Unnecessary for first build |
| Green board with coin-cell holder | Real-time-clock module, likely DS1302 style; chip unverified | Unnecessary for first version |
| Red board marked Water Sensor | Water-detection module | Unnecessary for this robot |
| IR remote | Clearly visible; matching receiver not positively identified | Optional later control |
| Bag labelled Breadboard Power Supply | MB102-style regulator module likely | For suitable small bench loads only after identifying input/output ratings; not qualified as robot power supply |
| Black wall adapter partly visible | Label unreadable | Potentially reusable; need OUTPUT voltage, DC/AC indication, current rating, polarity and connector size |

## What still needs sourcing or confirmation

- ESP32-S3 development board with verified 8 MB PSRAM, such as N16R8.
- Digital I2S microphone, proposed INMP441 module.
- I2S speaker amplifier, proposed MAX98357A module.
- Suitable small speaker, proposed 4-ohm 3 W unit around 40 mm diameter. No suitable separate loudspeaker or amplifier is positively visible in the photos. A kit buzzer, if present, would not replace a speech speaker.
- Suitable regulated supply: verify the existing adapter before proposing any purchase. Conditional replacement candidate INR 479; excluded from the essential basket.
- User confirms cables, switches, connectors and mounting parts are already owned. Reuse them; no new generic supplies budget. Check the existing USB-C data cable for S3 programming; the blue Uno USB-B cable itself does not fit.
- White filament and basic tools remain unconfirmed.
- Second positional servo only if adding a second arm after the first works.

## Two easy-to-confuse parts

The ESP-01 really is a Wi-Fi module. The reason to select the S3 is the required combination of audio input, audio output, buffering, secure network requests and control pins. The ESP8266 chip itself has audio interfaces, but its much smaller working memory does not fit our proposed long recording buffer; using it would require a different design. This is a design-fit decision, not a claim that all ESP8266 audio is impossible. [Espressif pin assignments](https://documentation.espressif.com/0a-esp8266ex_datasheet_en.html)

KY-038-type boards provide a digital sound-threshold output and an analog output. The digital threshold signal does not encode speech audio. The analog output could be investigated with additional sampling/interface work, but its recording quality is untested and it does not directly fit the planned I2S microphone firmware. Keep a proper digital speech microphone in the budget. The reference identifies a common module family, not the exact photographed board. [Joy-IT KY-038 documentation](https://sensorkit.joy-it.net/en/sensors/ky-038)

## Updated planning allowance

**Purchase status: hold.** The user accepted the laptop voice, but its standalone hosted version has not been proved or costed. These are candidate parts, not an instruction to order today.

The [main build plan](C:/Users/dhruv/OneDrive/Desktop/Baymax/BAYMAX_BUILD_PLAN.md) now lists only INR 1,707.06 of essential purchases: S3 board, microphone/amplifier combo and speaker pack, using previously checked Amazon prices. No new wiring, switch, connector, mounting, printing or contingency charges are included. See [Amazon links and purchase conditions](C:/Users/dhruv/OneDrive/Desktop/Baymax/AMAZON_PURCHASE_PLAN.md).

The adapter remains conditional: add INR 479 only if the existing one is unsuitable, for INR 2,186.06 total. Delivery and running costs are separate. Only one speaker is required; the selected listing is a two-pack. Measure the delivered speaker before CAD.

## Next physical checks

1. Read or photograph the wall adapter's OUTPUT line and polarity symbol. Do not infer the rating from its plug fitting the Uno.
2. Read or photograph the servo label and confirm the horn and small retaining screw are present. Check that it is a positional servo before using an angle-based motion program.
3. Identify the tactile button(s) in the small-component box and confirm available filament/tools.
4. After selecting a suitable servo supply, test the Uno and one slow servo movement with no printed arm attached. Grounds must be common; external servo positive stays separate from the USB-powered Uno's supply. [Arduino servo guidance](https://support.arduino.cc/hc/en-us/articles/360017053760-Troubleshoot-servo-motors)

## Photo references

- [Photo 1: breadboards, LCD and water sensor](<C:/Users/dhruv/Downloads/WhatsApp Image 2026-09-28 at 6.27.34 PM.jpeg>)
- [Photo 2: stepper, driver and small-parts box](<C:/Users/dhruv/Downloads/WhatsApp Image 2026-09-28 at 6.27.33 PM (3).jpeg>)
- [Photo 3: Uno, relay and stepper](<C:/Users/dhruv/Downloads/WhatsApp Image 2026-09-28 at 6.27.33 PM (2).jpeg>)
- [Photo 4: servo, PIR, wiring and RFID kit](<C:/Users/dhruv/Downloads/WhatsApp Image 2026-09-28 at 6.27.33 PM (1).jpeg>)
- [Photo 5: servo, sound sensor and clock module](<C:/Users/dhruv/Downloads/WhatsApp Image 2026-09-28 at 6.27.33 PM.jpeg>)
- [Photo 6: ESP-01 label, power module and sound sensor](<C:/Users/dhruv/Downloads/WhatsApp Image 2026-09-28 at 6.27.32 PM.jpeg>)

