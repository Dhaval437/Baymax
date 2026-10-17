# Current print package — 1 October 2026

The current delivery is `PRINT_PACKAGE_180MM/Baymax_180mm_P1S_PRINT.gcode.3mf`: one pre-sliced file containing two plates and all 27 printed pieces. An editable native Bambu project is alongside it as `Baymax_180mm_P1S_TWO_PLATES.3mf`.

Verified in Bambu Studio for P1S, 0.4 mm nozzle, PLA and textured PEI. Plate 1 estimates 3 h 18 min / 104 g; plate 2 estimates 7 h 12 min / 149.08 g. Both sliced successfully with all objects included, no out-of-bed objects, and verified G-code checksums. The final model has 27 closed, single-island meshes and no reported static, nominal component or sampled movement interference (2-degree increments).

This is a prototype print release, not evidence of a completed physical assembly. Actual servo/horn variations, cable routing, electrical commissioning and structural strength still need the first build. Supports and seams require normal cleanup. See the assembly guide in the print-package folder.

Everything below is historical and superseded by the package above.

---

# Print status — 180 mm Baymax

## Latest mechanical pass — 1 October 2026

`panel_fasteners_v2/Baymax_180_SERVICE_PANELS_V2.blend` is the latest service-panel geometry. It preserves the approved exterior, adds ten rear-access screw positions, and adds short locating collars to the torso/arm screw posts. Head posts are above the eye openings. Lower torso posts were moved to X = centre ±27 mm, Z = 78 mm to clear the speaker. Added material is clipped to the original sculpt before being joined, preventing visible external bumps.

All twelve exported development meshes pass closed-edge and positive-volume checks. Mesh cleanup merges vertices within 0.001 mm; only very small boundary defects are eligible for bounded repair. The final file was rendered and inspected from the front and with rear panels separated. These checks establish geometric progress, not final manufacture or strength.

`internal_layout_with_fasteners.json` checks three rigid servo CASE envelopes and the measured 52 × 26 mm speaker envelope against the actual torso plus screw posts and against each other: all fourteen reported intersections are zero within the 0.01 mm³ threshold. The editable candidate is `Baymax_180_INTERNAL_LAYOUT_WITH_FASTENERS.blend`.

The case layout is exploratory: arm motor centres are at X = centre ±13 mm, Y = -1 mm, Z = 128 mm; the neck motor centre is (3, 0, 146.5) mm. A collision-free rectangular case layout is not a completed shoulder mechanism. Horns, tabs, frame thickness, cables, bearings, arm pivot choice, motion and assembly access remain unverified. Do not treat the case blocks as printable brackets or commit arm cuts solely from these positions.

Remaining before full printing: complete servo supports and horn interfaces; neck bearing/drive; arm motion checks; minimum-wall verification; speaker retainer, button/microphone mounts; final base wiring and power socket; final fastener selection and Bambu slicing. **No full-body print release yet.** Historical notes below refer to earlier versions.

## Current update — 1 October 2026

Fit samples are now printed remotely and awaiting delivery. Their absence locally does not block CAD. The user plans three matching SG90 motors. The newly measured breadboard power module is 54 × 34 × 30 mm; its electrical suitability is unverified and its upright envelope does not leave mounting clearance in the current base. See `power_module_dimensions.json`.

Windows Computer Use initialized successfully today, and Blender was launched through it. The historical tool failure below no longer describes current access. Final Bambu slicing remains unverified. A new service-panel fastener script is being tested separately; it has not yet passed validation or replaced the development assembly.

## Updated direction: no mandatory test print

The user has explicitly chosen to proceed using published servo dimensions, without printing the gauges first. The fit-test plate is now **optional**, and lack of a gauge result is no longer a condition for continuing CAD work. The original fit-test instructions below are retained only for optional use. The full robot still needs its unfinished joints, attachments and slicing checks completed.

The matching [TIANKONGRC manufacturer page](https://www.tiankongrc.com/sale-51874362-tiankongrc-sg90-9g-micro-servo-motor-miuzei-mini-servos-motor-kit-metal-gear-servo-for-arduino-proje.html) lists 22.4 × 12.5 × 22.8 mm. Use these as the case reference, with a proposed 23.4 × 13.5 mm aperture (0.5 mm clearance per side), replaceable brackets, slotted mounting points and optional shims. Retain the user's approximately 32 mm tab span / 30 mm height as overall-envelope evidence. The supplier page does not define every mounting dimension, so do not label hole centres or horn geometry as manufacturer-verified. See `servo_design_basis.json`.

A standalone three-piece tab-clamping bracket has been generated in `servo_bracket_development/`. It uses an open case aperture and two removable clamp bars pressing on the mounting tabs, avoiding reliance on an exact servo mounting-hole pattern. The bars have adjustment slots. These three closed meshes pass manifold and positive-volume checks. The bracket still needs integration into the shoulder/neck supports and clearance checks; it is not a completed robot joint. Its four M3 fasteners per bracket are a proposed hardware requirement, not confirmed existing hardware.

**Full robot: HOLD. Do not print the development body plates yet.**

The exterior has been converted into a 180 mm assembly with a base, hollowed development shells and separate pieces. This is not yet a functioning, assembly-ready robot. The user confirmed that no servo fit gauges have been printed. M3 screw/nut availability is still unconfirmed (the reply to that question was also “not printed”).

## The first small plate

`01_FIT_TESTS_P1S.3mf` contains nine pre-positioned test objects. It is a 3MF project prepared for Bambu Studio, not printer G-code and not a verified slice. The archive/XML structure and object bounds were checked programmatically; the layout was also rendered from its actual mesh geometry.

Prepared settings assume **Bambu P1S, 0.4 mm nozzle, PLA, textured PEI plate, 0.20 mm layers, 3 walls, 20% infill, no supports, no brim**. The printer operator must verify the real nozzle, filament and build plate, slice the project, and inspect the preview before printing. Do not copy these assumptions to a different nozzle/material without changing the profile. No print job was sent.

| Number on preview | Object | What to report after cooling |
|---|---|---|
| 1–3 | Servo apertures with 1–3 notches | Smallest that accepts the unplugged servo body without force; whether tabs sit flat and cable clears |
| 4–6 | Alignment sockets, 1–3 notches | Which slides onto the common tongue without force or excessive looseness |
| 7 | Common alignment tongue | Use with the three sockets above |
| 8 | M3 screw and nut sample | Only test if actual M3 hardware is available; whether the nut seats and screw passes |
| 9 | Speaker aperture ring | Whether the appropriate speaker mounting rim/body passes through the 52.8 mm opening; do not push on the cone |

The servo openings are 23 × 12, 24 × 13 and 25 × 14 mm. Socket clearance trials are 0.2, 0.3 and 0.4 mm per side. These are trial dimensions, not validated final fits. No electronics need to be powered for these checks. Keep the servo horn detached.

If Bambu Studio rejects the saved project settings, `geometry_only/01_FIT_TESTS_GEOMETRY_ONLY.3mf` retains the same geometry and layout without printer configuration. Select the operator's correct P1S profile explicitly. Individual fit-test STLs are also available; the first three are in `../servo_fit_gauge/`.

## Development parts already made

- 100 × 85 mm base box, approximately 35.67 mm tall including the removable bottom, replacing the earlier thin display plinth.
- Bottom cover with an alignment tongue, provisional M3 captive-nut connections, board support rails and strap slots.
- Rounded rear cable entry and strain-relief tie slots. Final cable opening and clamp depend on the selected cable; glue alone is not the retainer.
- Seats shaped around the original feet, internal wiring holes through the feet and body, and provisional foot fixing holes.
- Torso front and rear development shells with rear speaker slots.
- Head front and rear development shells, with a preliminary neck access opening.
- Left and right arms split into front/rear development parts. Upper-arm cavities reduce material; the fingers remain solid.

There are **12 development parts**. Their current meshes are closed, have positive signed volume, and retain a measured overall height of 180 mm. These checks do not establish strength, clearance, printability or safe motor operation. Torso/head cavities use scaled inner surfaces; wall thickness is not uniform and must be measured before release. Contour alignment lips attempted on these organic shells were not reliable and are not in the current body/head exports. Only the base has its development alignment rim; fit samples establish clearance for the remaining joints.

The files in `HOLD_NOT_FOR_PRINT/` group the development pieces by plate. They are for inspection only. Their support settings and orientation have NOT been validated. Separate face markings and the chest badge remain in the editable assembly; their final print/attachment treatment is also pending.

## Work still required before the full print

1. Continue servo mount CAD using the published dimensions and adjustable interfaces; a test print is optional by user direction. Horn dimensions and shaft position remain inferred until physically checked. Allow adjustment and replacement rather than an irreversible close-fitting mount.
2. Design and test the load-bearing shoulder supports, horn attachments and neck bearing/servo mount. Check the whole movement range for collisions.
3. Finish torso/head/arm alignment features and accessible fasteners. Finalise the feet-to-body attachment and test it.
4. Fit the speaker retainer, microphone and chest switch; measure the microphone/amplifier boards when they arrive.
5. Verify base electronics, connector clearance, cable clamp and selected low-voltage supply. Mains adapter stays outside.
6. Verify minimum walls and mating clearances, then inspect sliced layers/supports for every final part in Bambu Studio.

## Tool verification limitation

The @Computer tool was retried after the user said it was working, but still returned `failed to write kernel assets: The system cannot find the path specified. (os error 3)`. Bambu Studio's CLI initially returned its help, but later info/slicing calls exited without output or a verified sliced result. Therefore no successful Bambu UI inspection or slicing is claimed. The 3MF files were constructed locally from the checked meshes and installed profile data.

## Files

- `Baymax_180_MECHANICAL_DEVELOPMENT.blend`: editable working assembly.
- `assembly_180.png`: exterior preview.
- `fit_plate_preview.png`: top-view render of the actual fit-test project geometry (not a slicer screenshot).
- `mechanical_report.json`: per-part geometry results and remaining work.
- `fit_plate_layout.json`: exact plate positions and dimensions.
- `build_mechanical.py`, `package_plates.py`, `prepare_profiles.py`: reproducible sources.

Original source model and the earlier approved neutral-pose model are preserved under `../reference_model/`.
