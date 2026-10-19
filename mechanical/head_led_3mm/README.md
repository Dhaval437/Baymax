# Baymax head with two 3 mm blue LED eyes

18 October 2026. Replacement head prototype for the existing 180 mm Baymax.

## Files and printed parts

Open `Baymax_LED_head_3mm_ONE_PLATE.3mf` as a project in Bambu Studio. It contains all seven parts at 100% scale in millimetres. Individual meshes are in `STL/`; `Baymax_LED_head_3mm.blend` and `build.py` are editable sources. `head_led_assembly.png` is rendered from these meshes, not an AI concept image.

| Part | Quantity | Purpose |
|---|---:|---|
| 01_LED_head_front | 1 | Smooth replacement face, 3.3 mm LED bores, flange seats, retaining tracks and original carrier screw locations |
| 02_LED_head_rear | 1 | Removable cover, two M2 clearance holes, cable exit and wire tie anchor |
| 03_Right_LED_retainer | 1 | Side-entry C-shaped keeper for robot's right eye |
| 03_Left_LED_retainer | 1 | Mirrored keeper for robot's left eye |
| 05_Original_head_carrier | 1 | Unchanged existing motor carrier; reuse your original if serviceable |
| 06_Original_horn_clamp | 1 | Unchanged stock-horn clamp; reuse your original |
| 07_Original_roof_plug | 1 | Unchanged removable access plug; reuse your original |

The exterior is a new smooth oval, approximately 27.8 × 27.6 × 18.5 mm. It removes the old solid eye relief. The original motor carrier, clamp, mounting screw axes and roof service access are retained. The lower opening clears the clamp during insertion. The replacement rear fits the replacement front; do not mix the old and new head shells.

## Extra hardware

- Two ordinary two-lead 3 mm blue LEDs; diffused/high-efficiency types are preferable for small eyes.
- Two **220 ohm** resistors, one per LED (1/8 W or 1/4 W).
- Two **M2 × 8 mm** pan-head machine screws with heads no larger than 3.8 mm diameter. These thread gently into printed 1.6 mm pilots; no nuts are used here. Do not substitute longer screws.
- Thin flexible insulated wire, heat-shrink, and a small removable three-wire connector if available.
- A narrow tie fitting the 3 × 1 mm cable-anchor slot, or thread, for strain relief.
- Reuse the existing stock servo horn, its own central retaining screw and two M2.5 × 10 mm carrier/clamp fixing screws.

## Assembly

1. Unplug USB and external power. Remove supports carefully, especially from LED bores, keeper tracks and screw holes. Do not enlarge the pilots until their actual fit is checked.
2. With the rear cover removed, insert each LED from inside, lens toward the front. The larger flange rests in its recess. The model assumes a 3.0 mm body, flange up to 3.8 mm, 0.7 mm flange thickness and approximately 5.2 mm tip-to-flange length. These dimensions vary by supplier; only the nominal 3 mm size was supplied by the user.
3. The C-shaped keepers slide **sideways from the centre of the face toward each eye**, in the tracks immediately behind the LED flanges. The open side faces the LED during insertion, letting its two leads enter the opening. They do not insert from above the roof. Install before bending/soldering the leads. If needed, use a tiny removable tape strip over the keeper's trailing edge to prevent sideways migration; never force a tight keeper.
4. Identify anode/cathode before trimming leads. Solder flexible leads and insulate each joint separately. Keep the LED legs apart. Place the two resistors in the base to save head space. The two cathode wires may join to a shared ground, giving three wires to the head.
5. Route the wires to the rear-bottom exit and secure their jacket to the anchor. Leave a small flexible loop at the neck. Feed toward the torso alongside, not through, the rotating shaft. Check actual neck clearance and that no wire can be pinched by the moving head or the rear cover.
6. Assemble the unchanged carrier, original servo horn and clamp using the existing two M2.5 fixing screws. Reuse the established centred servo position; no motor-centering command was sent for this design. Preserve access to the stock horn's central retaining screw through the roof plug.
7. Align the rear cover on the locating features. Close with two M2 × 8 mm screws, by hand, only until seated. **Do not glue the rear cover.** Nominal pilot engagement is about 2.6–2.8 mm before the shallow head recess; actual screw heads and printed fit must be checked.
8. Paint a thin black line between the LED openings if you want the classic connected-eye look. Keep paint off the lenses and mounting tracks. Test the lights and a small head movement before final enclosure assembly.

## LED wiring — independent left/right control

| ESP32-S3 | Connection |
|---|---|
| GPIO10 (pin marked 10) | 220 ohm resistor → robot's LEFT LED anode (+, normally longer leg) |
| GPIO11 (pin marked 11) | Separate 220 ohm resistor → robot's RIGHT LED anode (+) |
| GND | Both LED cathodes (−, normally shorter leg / flat rim side) |

These pins are unused by the current audio GPIO4–7 and PCA9685 GPIO8–9 configuration. The pins operate at 3.3 V logic. Never connect these LEDs directly to 5 V or bypass their resistors. Blue LED brightness at 3.3 V depends on the particular LED's forward voltage; it is not guaranteed by nominal diameter. Use the LED supplier's polarity marking/datasheet if the leads have already been cut.

GPIO10 and GPIO11 are documented GPIO header signals for ESP32-S3: [Espressif's board guide](https://documentation.espressif.com/esp-dev-kits/en/latest/esp32s3/esp32-s3-devkitc-1/user_guide_v1.1.html). Follow the printed labels on the user's clone, not the physical position on another board's drawing.

`BlueEyesDemo/BlueEyesDemo.ino` is an optional standalone electrical check: both eyes on, blink together, left wink, right wink. It compiled successfully for ESP32-S3 N16R8 with Arduino ESP32 core 3.3.12 (302,264 bytes flash, 22,816 bytes globals). It has **not been uploaded**. Uploading that standalone sketch replaces the conversation firmware; it is supplied as a reference/test, not as the final integrated Baymax firmware. The current robot firmware was not changed by this head redesign. Integration with wake/speaking states can follow installation. A wink is one LED turning off briefly; no physical eyelids are included.

## Print and verification

The successfully exported sliced project is `sliced/Baymax_LED_head_3mm_SLICED.3mf`. Bambu Studio reported success, seven objects, no slicing warning, approximately 42 minutes and 6.3 g PLA including supports/brims. Its archive integrity and embedded plate G-code were checked. Open it in Bambu Studio and review Preview before printing. The unsliced `ONE_PLATE.3mf` remains available for editing or changing filament settings.

Prepared for P1S, 0.4 mm nozzle, PLA, textured PEI, 0.12 mm layers, three walls. Shells are oriented with their seam faces on the bed and eye exterior upward; small keepers lie flat. Supports are enabled for shell details. Inspect supports and the tiny keeper tracks in the slicer; avoid welding support into these tracks. Remove support before checking the fit. The source project is a geometry/configuration 3MF, not a print command.

`checks.json` records closed manifold meshes with positive volume, one connected solid per part, static LED/keeper clearances, sampled keeper-insertion clearances, shell closure and carrier/clamp clearance. These checks use nominal LED envelopes and do not prove real LED fit, wire clearance during rotation, pilot strength or printed tolerances. No actual LEDs or printed parts have been physically tested. No print was started and no robot firmware was uploaded for this redesign.
