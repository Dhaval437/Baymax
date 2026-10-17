# Original Baymax sculpt — replacement working model

**Active mechanical work:** the approved 180 mm assembly with electronics base is under `../production_180/`. Read `../production_180/PRINT_STATUS.md` before sending anything to print. The files here preserve the 150 mm exterior used as its source.

**Latest file:** `Baymax_ARMS_DOWN_STRAIGHT_HEAD_150mm.blend` keeps both arms down and levels the head's sideways tilt. The head and all three face markings were rotated together using the eye centers as the reference; the head was then positioned vertically to retain 150 mm overall height. The neck interface remains provisional. See `straight_head_front.png` and `straight_head_report.json`.

## Current model: both arms down

Open **`Baymax_BOTH_ARMS_DOWN_150mm.blend`** for the latest version. The raised, bent arm was replaced with a mirrored copy of the original lowered arm, including its hand and fingers. Both arms are independent mesh objects in a neutral lowered pose. The original waving arm remains hidden in a reference-only collection; the original source files are unchanged.

The updated assembly measures approximately **94.21 × 72.76 × 150 mm**, including the original black display plinth. Both arm meshes have zero non-manifold edges and positive enclosed volume. See `neutral_arms_report.json`. These checks verify the mesh edit, not the future motor mechanism. Servo mounts, shoulder clearance through motion and interior hollowing remain pending. The earlier waving-pose description below applies to the preserved source copy.

This replaces the earlier procedurally drawn exterior. The user's local `Downloads/Baymax1_color.3mf` contains the waving Baymax sculpt shown in the supplied photographs. Its mesh geometry and relative component transforms are preserved, with a single uniform scale and translation to put the assembly on the ground at **150 mm overall height, including the original black plinth**. Width is approximately 103.85 mm and depth 72.76 mm.

Open `Baymax_ORIGINAL_150mm_WORKING.blend`. The head, torso, two arms with hands, two legs, badge, face details and base have been exposed as separate objects using the source's existing disconnected mesh pieces. This does not add physical joints or make them independently printable mechanisms. The pose and proportions remain those of the source sculpt.

The 3MF metadata attributes the original design to **GeekSculpt3D**, title **Big Hero 6 Baymax Adorable Collectible Figurine**, with license metadata **Standard Digital File License**. The source archive is retained unmodified as `source_Baymax1_color.3mf`. A separate recently downloaded `baymax.stl` was also copied as `source_baymax.stl`; it has different proportions and is not the source of this Blender file. No files were uploaded or published.

## Current checks

- Source color meshes have zero non-manifold edges.
- All geometry is uniformly scaled, preserving the original proportions.
- The Blender file saves correctly and the front and reverse renders were generated.
- The original body contains seven disconnected pieces; the black mesh contains four.
- See `source_inspection.json` for precise bounds and component counts.

## Still needed for the functional robot

This is a faithful editable exterior, not an assembly-ready robot. Interior hollowing, shoulder joint cuts, neutral head pivot, brackets, rear access panel, fasteners, wire routing and component clearance remain to be designed and checked. The sculpt has a permanently bent waving arm; one shoulder servo can move the whole arm, but will not straighten its elbow. Matching this appearance at 150 mm while fitting the reported electronics must be checked rather than assumed. Do not print the complete sculpt as the robot enclosure yet.

The desktop-control helper failed to initialize, so the current unsaved Bambu Studio state could not be inspected. This working model comes from the saved local 3MF that visibly matches the supplied reference photos. The source Bambu Studio project was not modified.
