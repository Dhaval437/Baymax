# Baymax enclosure planning

**Latest servo decision:** The user chose to skip mandatory test printing. Continue from TIANKONGRC's published SG90 dimensions with adjustable, replaceable mounts. `mechanical/production_180/servo_design_basis.json` records the source, proposed clearances and unverified details. Prior statements requiring the gauge print before any further CAD are superseded.

## Current approved layout — 180 mm including base

The user approved a maximum overall height of **180 mm**, with both arms down and the head level, using the supplied original Baymax sculpt. An electronics base replaces the thin display plinth. Current mechanical development lives in `mechanical/production_180/`; its `PRINT_STATUS.md` is authoritative for print readiness. The fit gauges have **not** been printed. Full-body print release remains on hold pending physical fits and final mechanical interfaces. Earlier 150 mm descriptions below describe the preserved exterior before its taller base was added.

## Blender draft — 29 September 2026

An editable 150 mm exterior and preliminary internal packaging model is now in `mechanical/blender/Baymax_150mm_DRAFT.blend`. See `mechanical/blender/README.md` for limitations and `geometry_report.json` for mesh checks and detected envelope/shell contacts. Separate draft shell STLs and front, rear and cutaway previews are included. These are not an assembly-ready manufacturing release. Continue with the servo fit gauges before full-body printing.

## Agreed target

- Overall height: **150 mm**, including head and feet.
- Independent shoulder movement for both arms and left/right head rotation: three servos total. One existing SG90; two additional servos not yet selected.
- Camera postponed. Provide a serviceable head and potential cable route through the neck.
- Concealed internal electronics with a removable rear panel. Laptop-connected voice over Wi-Fi initially.
- No suitable servo power adapter currently owned, per user. Servo power remains disconnected until a supply is selected and checked.

## User measurements

Reported in centimetres and converted to millimetres. These are user measurements, not independently checked manufacturing dimensions.

| Component | Reported overall envelope |
|---|---|
| ESP32-S3 board | 64 mm long × 29 mm wide × 15 mm high |
| One speaker | 52 mm diameter × 26 mm deep |
| Existing SG90 servo | 30 mm long × 32 mm wide × 11 mm high |

The 29 September 5:39 PM ruler photo clarifies orientation: the output shaft points right, and the mounting tabs extend upward/downward in the image. Tentatively map the reported 30 mm to base-to-shaft overall height, 32 mm to the tab-to-tab span, and 11 mm to thickness. These are planning dimensions, not precise dimensions extracted from the photo: the zero alignment and perspective do not support sub-millimetre measurement, and thickness is not shown. Preserve the original user measurements. The body pocket, mounting-hole centres, shaft offset and horn sweep still need a physical fit check before finalising the holder. The board's 15 mm height may not include plugged-in jumper connectors or cable bend space.

## Proposed arrangement to check in CAD

The 5:43 PM photo shows a short single-arm horn (left), a double-arm horn (middle), a cross horn (right), and three screws. Use the supplied single-arm horn as the first shoulder-attachment candidate; precise hole positions and shaft engagement are not measurable reliably from this photo. A small trial aperture gauge set is in `mechanical/servo_fit_gauge/`; these are fit tests, not final mounts.

- Put one speaker in the lower torso, facing a rear grille, with room for its terminals and wires.
- Place the ESP32 vertically above or alongside the speaker as fit permits, with USB access through the service panel. Do not assume its 64 mm length stacks above the speaker within the available torso height.
- Place a servo at each shoulder, with shafts aligned to lift each rigid arm. Support the head swivel with a neck servo and a mechanical bearing/support so head loads are not carried only by the horn screw.
- Use a lightweight hollow head and arms, a stable pair of feet, and accessible internal fasteners.
- Reserve room for the microphone, amplifier, chest button, wiring, connector clearance and motion clearance. Their exact mounts remain pending.

This is a layout proposal, not a verified fit. Body width/depth, wall thickness, clearances, horn geometry and fastener positions have not been fixed. The 52 mm speaker requires more than 52 mm of internal width at its mounting plane once clearance and its mounting method are included. Do not print a final shell or purchase additional servos until the component layout and motion envelopes have been checked.
