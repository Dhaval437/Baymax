# Baymax market list — 1 October 2026

Take the existing SG90 servo and one supplied horn to the shop. We need three positional servos total; buy two more, not three more.

## Buy now

| Item | Quantity | Specification and reason |
|---|---:|---|
| SG90 positional micro servo | 2 | Prefer matching TIANKONGRC SG90 9g, nominal 180-degree position control, 4.8–6 V. Match existing case and ears. Include horns and retaining screws. Do not buy continuous-rotation variants. |
| Enclosed regulated DC adapter | 1 | Output 5 V DC, 5 A continuous (25 W), reputable make, Indian mains plug, short-circuit/overload protection. External enclosed adapter, no exposed mains terminals. Prefer centre-positive 5.5 × 2.1 mm plug, with its cable rated for the output. 5 A is a design allowance, not measured robot consumption. |
| Matching DC input socket/pigtail | 1, only if not already owned | Match adapter plug and polarity; documented rating at least 5 A. Use an insulated pigtail inside the base; the printed entry is for the cable. Existing unidentified barrel lead can be reused only if compatible and adequately rated. |
| Small solderable perfboard | 1 | About 50 × 30 mm, cuttable. For a compact power distribution assembly. No new solderless breadboard or regulator module needed. Reinforce power paths with wire; do not carry motor current through thin signal tracks. |
| Electrolytic capacitor | 1 | 1000 µF, 10 V or 16 V, radial, preferably low ESR. For servo power rail transients. Polarity matters. Does not replace adequate supply capacity. |
| Insulated stranded power wire | Only if existing stock is just thin Dupont leads | About 1 m red and 1 m black, 20 AWG copper, for short 5 V distribution runs. Reuse existing jumper wires for signals. |
| Heat-shrink tubing | Small quantity, only if absent | Insulate solder joints; a few 2–6 mm diameters. |

## Assembly tools — user confirms none owned

- Basic digital multimeter with DC-voltage, resistance and continuity modes, and probes. Essential before applying power. We will use it only on the low-voltage side of the enclosed adapter.
- Borrow a temperature-controlled soldering iron and stand, solder and suitable electronics flux, or have a local technician solder the short harness. If buying tools, ask for a basic temperature-controlled electronics soldering kit, fine tip, stable stand, solder and rosin/no-clean flux. Do not use plumbing/acid flux.
- Borrow a small wire cutter/stripper and precision Phillips screwdriver if unavailable. Avoid buying a large tool kit solely for this build.

## Reuse / already ordered

ESP32-S3 N16R8, one SG90 and its horns, one of the existing speakers, USB-C data cable, signal jumpers, pin headers, existing talk button and switches where suitable. INMP441 and MAX98357A already ordered: do not duplicate them. Keep both breadboards for bench work. The 54 × 34 × 30 mm breadboard regulator module is not in the final power path.

## Mechanical assembly hardware — 180 mm model

- 3 × M3 × 20 mm and 1 × M3 × 16 mm pan/button-head screws for the torso.
- 4 × M2.5 × 20 mm for the arm covers.
- 6 × M2.5 × 10 mm for arm/head horn clamps.
- 2 × M3 × 8 mm for feet to base.
- 4 × M3 × 12 mm countersunk screws and 4 M3 nuts for the base cover.
- 2 × M2 × 5 mm countersunk screws and 2 M2 nuts for the button bracket.
- Reuse the three stock servo horn retaining screws.
- About 16 narrow 2.5 mm nylon cable ties, a small tube of PLA-compatible adhesive, and black paint/marker for the face if absent.
- Nominal 6 × 6 mm tactile pushbutton only if the existing one is unsuitable.

The base uses an 8 mm cable-entry insert with tie strain relief. Use a matching rated input pigtail; a panel socket is not required. No camera, battery, charger, PCA9685 servo driver, Raspberry Pi, replacement ESP32 or smaller speaker is required.

## Power architecture chosen for design

External regulated 5 V adapter → rated rear socket → compact wired distribution, with separate branches to servos, amplifier and ESP32 power input. All low-voltage grounds join. Microphone receives 3.3 V from the ESP32. The servos do not receive power through the ESP32 or breadboard regulator. The ESP32's exact external-power connection and USB isolation must be checked against the delivered board before wiring; never join laptop USB power and external 5 V blindly.

The laptop remains the voice/AI host over Wi-Fi for this version. No additional computer purchase is needed.

## Evidence and limits

- TIANKONGRC lists SG90 at 4.8–6 V and offers both positional and continuous variants: https://www.tiankongrc.com/sale-51874362-tiankongrc-sg90-9g-micro-servo-motor-miuzei-mini-servos-motor-kit-metal-gear-servo-for-arduino-proje.html
- Adafruit's MAX98357 guide recommends allowing at least 800 mA for its amplifier at 5 V: https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/pinouts
- Supply sizing reserves approximately 1 A per microservo, 0.8 A for audio and 0.7 A for controller/transients; these are planning allowances, not measured current or a promise for every SG90 clone. Test actual hardware at low load before simultaneous movement. No full robot print release is implied by this shopping list.
