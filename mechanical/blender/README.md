# 150 mm Baymax — editable enclosure draft

Open `Baymax_150mm_DRAFT.blend` in Blender. This file is a complete exterior and preliminary packaging model, **not a finished mechanical design or an assembly-ready print set**.

## What is included

- Overall rest height: 150 mm, including feet and head. Approximate width 130 mm and depth 71 mm.
- Hollow pear-shaped torso with a separate rear panel, rear speaker grille and provisional power-cable opening.
- Hollow head with two black eyes and a connecting line; separate front/rear shells.
- Two separate hollow arms and two stationary flat-bottom feet.
- Neck sleeve and illustrative shoulder apertures.
- Chest button appearance placeholder. Its actual switch pocket is not designed yet.
- Named head and shoulder controls in `04_JOINT_CONTROLS` for manual posing. These are conceptual axes, not a validated mechanism.
- Hardware envelopes in `03_HARDWARE_ENVELOPES`, hidden initially. Toggle the collection's viewport visibility in the Outliner to inspect them.

The blue box represents the reported 64 × 29 × 15 mm ESP32 board, standing vertically. The green cylinder represents one reported Ø52 × 26 mm speaker, facing backward. Orange boxes represent the reported servo envelopes. These boxes are conservative placeholders, not detailed models of the motor body, tabs, shaft or horn. Only one servo is currently owned.

## What must be resolved before printing the robot

The packaging layout is intentionally provisional. The ESP32 was moved downward and forward to separate it from the neck-servo envelope; shoulder servos sit farther back. The script checks hardware bounding-box overlaps and hardware/shell surface intersections and records them in `geometry_report.json`. Remaining shell contacts need resolution before mounts are designed. The layout must be revised around measured motor bodies and shaft offsets; it may require changing body width/depth while retaining the agreed 150 mm height. Static arm clearance cuts do not validate clearance throughout motion.

There are no final servo brackets, horn pockets, bearing supports, shell fastening bosses, alignment lips, board standoffs or speaker retainers. Feet overlap the lower torso in the visual assembly and need a defined attachment interface. The microphone/amplifier dimensions, USB cable bends and power distribution must be checked before placing their mounts. Head and arm motion limits are illustrative only.

**Do not send the full STL folder for printing yet.** First print the small separate gauges in `../servo_fit_gauge/`, report the best-fitting gauge, and then validate small mount/interface samples before committing to the full body. All draft STLs use millimetres and assembled coordinates; they still require print orientation and support review in Bambu Studio.

## Files and checks

- `build_baymax.py`: reproducible Blender Python source.
- `Baymax_150mm_DRAFT.blend`: editable rest assembly with materials, component envelopes and studio camera.
- `preview_front.png`, `preview_rear.png`, `preview_packaging.png`: rendered inspection views.
- `draft_stl/`: separate draft shell meshes, not a manufacturing release.
- `geometry_report.json`: measured mesh bounds, signed volume and non-manifold edge count. Mesh checks do not establish mechanical fit, wall thickness everywhere or printability.

Rebuild with the installed Blender executable using `--background --python mechanical/blender/build_baymax.py` from the project folder. The script regenerates its own draft outputs. Keep custom edits in a differently named .blend file.

No camera hardware is included in this version. Keep the ESP32 unplugged during mechanical planning; no electronics or servo power is required to inspect these files.
