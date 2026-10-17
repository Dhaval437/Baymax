> Updated 16 October 2026: see [SOFTWARE_READY.md](SOFTWARE_READY.md) for the integrated, button-free PCA9685 firmware and current startup instructions. The older notes below describe earlier bench stages.

# Assembly and hurt-sound wake-up — 3 October 2026

The new firmware has an optional microphone-monitoring mode. Serial W turns it on/off. It starts OFF because the microphone and amplifier have not yet been confirmed delivered and wired. This is awake/idle listening, not low-power deep sleep.

It captures a short sound with 250 ms of preceding audio, sends it over the private Wi-Fi to the laptop, and checks the local transcript for ouch, ow/owww, ah/aaah or aaa/aaaa. Ah/ow/aaa only match short utterances. On a match it plays the cached smooth greeting: “Hello. I am Baymax, your personal healthcare companion. I heard you. Are you okay?” This is a character greeting in a hobby prototype, not a claim of medical capability. No LLM call is needed for that greeting. Ordinary speech is discarded without adding it to chat history. Audio is temporarily processed locally and not kept as recordings.

Speech recognition may miss a nonverbal cry or misrecognize television speech. This is a companion reaction, not an injury detector or emergency alarm. It cannot reliably identify every scream, groan or hurt sound. Listening pauses while sending/transcribing/playing audio, with a 20-second cooldown after a reaction to avoid repeats. Use the talk button to answer. The energy threshold is provisional until tested on the actual microphone. Timing and detection accuracy are not measured yet.

## What to assemble first

1. Dry-fit the printed base, ESP32 and covers. Leave the service covers removable. Do not glue moving joints or install servo horns before centering.
2. On delivery, identify the INMP441 and MAX98357A pin labels and check the speaker's rear impedance/wattage label. Keep everything unpowered while wiring.
3. Microphone: VDD to ESP32 3V3, GND and L/R to GND, SCK to GPIO4, WS to GPIO5, SD to GPIO6. Confirm these are GPIO numbers, not header positions.
4. Amplifier signals: BCLK to GPIO4, LRC to GPIO5, DIN to GPIO7, GND common. One speaker across SPK+ and SPK− only; neither speaker terminal goes to GND. Verify the delivered module's supply range and power adapter before connecting amplifier VIN. Keep servos disconnected for the first audio test.
5. Talk button between GPIO15 and GND. Test button recording and playback first, then enable wake listening using W in Serial Monitor. Test ordinary conversation as well as trigger words.

## Movement plan

Use the existing SG90 for the head first: centre it without a horn, disconnect power, then fit the head facing straight. Plan a slow, small left/right head turn. Final travel must be calibrated with the printed head fitted; the CAD limit is not proof of the electrical servo angle. Leave firmware ENABLE_SERVO at 0 until power and clearance checks pass. The existing optional GPIO16 motion is a bench sweep, not calibrated final head animation.

Reserve GPIO16 for head yaw, GPIO17 for left arm, GPIO18 for right arm. GPIO17/18 are a planned allocation; three-servo control is not implemented in this update. Fit the other two SG90s when delivered. Both arms start down. Test each independently, then use a small slow arm lift after a wake-up, not a sudden pop or full-travel sweep. Mirrored arms need separately calibrated direction and endpoints.

Servos need a verified external regulated 5V supply, common ground and suitable power wiring. Never power them from GPIO or 3V3. Do not route their supply through the MB102 board. Keep external servo +5V separate from the ESP32 USB supply during bench tests; join grounds only. Confirm the final board power input arrangement before powering the ESP32 externally alongside USB.

## Prepared versus tested

Code and software checks can be completed now. Physical audio quality, wake sensitivity, servo direction, motor travel, supply capacity and printed fit require the delivered parts. No new firmware should be treated as hardware-tested just because it compiles.
