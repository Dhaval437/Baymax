# New walking robot — agreed brief

Updated: 26 October 2026, Asia/Calcutta. This is a separate build, not a conversion of the existing Baymax.

## Confirmed user requirements

- Preserve the existing Baymax intact. Do not remove its ESP32, motors, microphone, speaker or printed parts for this build.
- New robot must walk on legs, see using a camera and explore. Wheels are not an acceptable substitute. Exact leg arrangement and gait await the reference video.
- Maximum new-build budget: INR 30,000. Plan for purchased components, battery system, wiring, fasteners, printing material, delivery and contingency. No complete bill of materials has yet been costed or approved; affordability of all desired walking capabilities is not established.
- User has spare SG90 servos available. Quantity and condition unknown. Reuse where mechanically suitable; do not assume they can carry the walking joints before mass/torque calculations.
- Buy a separate controller, microphone, speaker/amplifier and other electronics as needed. No new board model has been selected.
- User will print the new body and assembly parts. Printer dimensions/material and target robot size are not yet known.
- Use the existing laptop for voice processing initially, communicating wirelessly with the robot. It must stay running and reachable. Laptop-free processing is a later upgrade, not a requirement for the first build.
- Battery-powered operation, not a continuous wall-power cable. Include a protected battery, matched charger, regulation, switch/fuse, low-battery handling and accessible battery mounting in the power design. Pack chemistry/voltage/capacity remain unselected pending motor loads and runtime.
- Keep an upgrade path for onboard processing; do not promise compatibility with an unspecified future computer or silently include its cost in the current budget.

## Existing assets and lessons

- Current Baymax project contains ESP32-S3/PCA9685 motor control, local laptop speech recognition/answer generation/voice synthesis, Wi-Fi setup and a dashboard.
- Software can inform the new build, but the present three-joint gesture controller is NOT a walking gait/balance controller.
- Existing voice pipeline has unresolved physical recognition/reliability problems, including missing words, noise triggers and hallucinated repeated words. Latest recorded firmware is noise-v16 from20October; this is historical evidence, not confirmation of today's connected device state. Do not describe the existing system as flawless or treat unit tests as proof of physical speech accuracy.
- Prior motor failures included an internally broken supply wire. New power distribution must be sized and tested under load.
- No reference video or walking-specific design was found in this workspace during the26October review. The user refers to an earlier video; request its link or attachment instead of claiming to remember its mechanism.

## Information still needed

1. Reference video/link, ideally showing the legs, feet and walking motion. This establishes the intended form and gait without asking whether the user wants wheels again.
2. Target standing height, or permission to choose a compact size for the budget; any required payload.
3. First operating environment: flat indoor floor, carpet, or uneven/outdoor ground; whether stairs are required. Do not infer all-terrain capability from 'explore'.
4. Desired battery runtime between charges, e.g.30minutes or1hour (a target, not a promised runtime).
5. Available spare SG90 count and other genuinely spare parts; printer model or printable build volume and material. A photo/list is enough.
6. Meaning of initial exploration: supervised walking with obstacle avoidance/person tracking, or autonomous room mapping/navigation. Confirm feature priority if costs force tradeoffs.

## Next work after clarification

1. Inspect reference, establish size/leg arrangement and measurable first-version requirements.
2. Estimate printed mass, joint count, lever lengths and required motor torque; choose leg actuators before detailed body CAD.
3. Produce an India-priced bill of materials with dated sources, shipping/printing assumptions, battery/charger and contingency. Show feasibility gaps or tradeoffs explicitly before purchasing.
4. Design power distribution and a first supported leg test rig; verify motor current, torque and repeatability before printing an entire body.
5. Build/test standing and walking, then integrate camera/obstacle sensing and voice. Keep the existing Baymax untouched throughout.
6. Document pin assignments, wiring, CAD, firmware and battery/runtime test results for the actual selected parts.

No purchases, new hardware substitutions, gait promises or changes to the existing robot are authorized by this planning note alone beyond the user's stated project scope.
