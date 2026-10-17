# Baymax: purchase decision and concealed enclosure

Checked 28 September 2026; arrival updated 29 September. The ESP32-S3 and two speakers arrived and are visible in the user's photo. The INMP441/MAX98357A combo has not arrived yet. The ESP32 board has passed flash, 8 MB PSRAM, Wi-Fi and laptop-server reachability tests. Prices were read from Amazon India product pages, displaying delivery to Pune 411002; this is not a confirmed user address. Taxes were included, delivery shown free, and coupons are excluded from totals. Seller, price, stock and terms can change.

## Decision before spending — updated 28 September 2026

**Staged development choice:** build the first hardware version against the existing laptop voice server, then move that server to a cloud host later. The ESP32-S3 can capture/play audio and move the arm; it cannot run the Sopro voice or Qwen conversation models itself. During the first stage, Baymax and the laptop must be on the same Wi-Fi, and the laptop must stay on. The finished laptop-off requirement remains unproven until cloud deployment and full-device tests pass. A 100% success or no-loss guarantee would be false.

For the laptop-first stage, the three essential hardware items below are ordered. A dedicated, authenticated device endpoint and ESP32 firmware have been written, but they have not yet been tested on the delivered board. The existing servo and power adapter still need checking. Buying the parts does not make the robot immediately functional. For the later laptop-off stage, prove a hosted reply using the same accepted voice, then test full-device communication and a bounded monthly cost. Free-tier availability is not guaranteed. [Oracle Always Free resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm), [Modal pricing](https://modal.com/pricing), [Modal budgets](https://modal.com/docs/guide/budgets).

## Essential Amazon candidates

Only the first three rows are the essential purchase basket. The adapter is conditional. These are previously observed prices, not a refreshed checkout quote.

| Item and direct listing | Displayed price | Selection and remaining checks |
|---|---:|---|
| [AYWHP ESP32-S3 WROOM-1-N16R8](https://www.amazon.in/dp/B0DG8L1YW9) | INR 999 | Seller BRAINLE; in stock; 10 days Returnable shown. Require N16R8, built-in PCB antenna and usable headers. Inspect received module and run a PSRAM test. Listing metadata contains generic inaccuracies; the listing alone cannot prove delivered hardware. |
| [OceanLabz MAX98357A + INMP441 combo](https://www.amazon.in/dp/B0GT4N822M) | INR 469.06 | Seller oceanlabz; in stock; 10 days Replacement. One amplifier and one microphone. Speaker purchased separately. |
| [Electronic Spices 2-inch 4-ohm 3 W speakers, pack of two](https://www.amazon.in/dp/B08VGR2WJH) | INR 239 | Seller Clicktech Retail Private Ltd; in stock; 10 days Replacement. Install ONE; second is spare. Bullet specifications describe passive DIY speakers; generic Bluetooth/stereo metadata is inconsistent. This is not a Bluetooth speaker purchase. Measure delivered size and verify label before mounting. |
| [Callsa 5 V 3 A adapter](https://www.amazon.in/dp/B0H2WKKW1H) | INR 479 | Seller Saanvi Electronics.; in stock; 10 days Replacement. HOLD: check existing adapter first. Select 5V 3A variant; listing says 2.5mm pin. Confirm full connector dimensions and polarity before choosing a matching inlet. Output quality/protection has not been independently tested. |

**Essential additional-parts total: INR 1,707.06** for the board, microphone/amplifier combo and speaker pack. Only one speaker is required; this listing bundles two. A compatible single speaker is sufficient if available for less.

The user confirms cables, switches, connectors and mounting parts are already available. Reuse these and the existing servo. Remove both the INR 250 assembly allowance and INR 250 contingency from the purchase list. Printing is excluded. No extra generic supplies should be ordered without an identified gap.

**Adapter: do not buy yet.** Verify the existing adapter's output and polarity first. If unsuitable, the INR 479 candidate raises the total to INR 2,186.06; confirm its connector and polarity before purchase. Delivery and recurring online services are separate. Existing tools may be used or borrowed. Use an existing USB-C data-capable cable to program the S3; the photographed USB-B Uno cable itself does not fit. This is a compatibility check, not a recommendation to buy another cable.

## Why change the controller?

The Uno R3 is useful for buttons, LEDs and servo movement. It has 2 KB SRAM and no onboard Wi-Fi; it cannot by itself handle the planned audio buffers and internet speech pipeline. The photographed ESP-01 adds Wi-Fi but does not make the Uno an equivalent audio controller. Combining the two would need a different, more constrained implementation. The ESP32-S3 N16R8 combines Wi-Fi, digital audio interfaces, sufficient buffering memory and servo control on one board. It replaces the Uno inside the finished robot; both boards are not required. The LLM still runs online, not inside the S3.

The red sound-detection module is not a drop-in I2S speech microphone. Its analog audio could be investigated, but recording quality and integration are unverified; the proposed INMP441 is selected for the planned speech path. The amplifier is needed to drive the passive speaker. No suitable amplifier or speech speaker was identified in the photos.

Replacement eligibility for defective products is not a refund guarantee if the project disappoints. Read the current item-specific terms before checkout. No seller quality guarantee is implied.

## How it operates

Hold the chest button, speak, then release. The INMP441 records through the ESP32-S3. In stage one, Wi-Fi sends the audio to the laptop on the same network for speech recognition, an LLM reply and speech synthesis. The ESP32 receives reply audio and plays it through MAX98357A and the speaker. It controls the existing servo using bounded, predefined gentle gestures. The microphone is inactive during playback for the first version. In stage two, the same device protocol points to a hosted service so the laptop can be off; internet and any hosted-service costs then apply.

## No exposed electronics

- All boards, servo wiring and connectors mount inside a hollow white body with a removable rear panel and internal tray. The head and arm shells conceal their mechanisms.
- Only a neat low-voltage power cable exits at the back. The mains adapter stays outside. Battery operation is a separate design and budget.
- Put a small talk button in the chest badge, power switch at the rear/underside, microphone opening behind a discreet chest aperture, and speaker grille underneath or behind the body. Acoustic openings cannot be sealed completely.
- Use secured internal wiring channels and strain relief. Keep wires away from moving shoulder joints and keep the microphone away from servo vibration and the speaker.
- Breadboards are for bench tests. The finished body uses compact, insulated, soldered connections or suitable locking connectors. Final dimensions depend on measured parts; approximately 17–20 cm tall is a design target, not a fit guarantee.
- Prove audio and motion on the bench, then print a shoulder/fit test before the complete shell. Printing has zero allocated cash cost at the user's request.

## Evidence needed to proceed confidently

1. Voice: user accepts actual audio of a greeting and an arbitrary new reply; establish usable service and ongoing cost.
2. Existing hardware: verify adapter OUTPUT voltage/current/polarity and test the positional servo and horn.
3. Received parts: verify board identity, 8 MB PSRAM, Wi-Fi, clear microphone capture and intelligible speaker playback before enclosure assembly.
4. Integration: complete ten consecutive conversations with the personal computer off, then repeat with gestures; no resets or severe audio interference. Verify reconnect behavior and off switch.
5. Mechanical: confirm arm clearance, stable stance, accessible service panel and fully concealed wiring before final assembly.

These tests reduce risk; they do not eliminate defective parts or development setbacks. None is claimed completed here.
