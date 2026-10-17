# Head assembly — 16 October 2026

Based on the released 180 mm print package's ASSEMBLY_AND_HARDWARE.txt (step 7) and rebuild_head_v3.py. Physical fit has not yet been confirmed. User reports the electronics work and wants to begin head assembly. Current installed firmware is the audio diagnostic; it does not have a head-centering command. No servo movement or centering was performed while making this guide.

## Gather

- 05_head_front and 05_head_rear: front has the eye details.
- 07_head_carrier: thicker disc with an underside horn recess.
- 07_head_horn_clamp: thinner disc with a larger central opening.
- 14_head_access_plug: small roof service plug.
- 04_torso_front, containing the upper neck-servo cradle.
- One SG90 positional servo and its original short single-arm plastic horn.
- Two M2.5 x 10 mm screws, the servo's own horn retaining screw, narrow cable ties. Optional printed shim if the actual case needs it.

## Sequence

1. Disconnect power. Remove supports and burrs gently. Match the head halves by locating pins/sockets; dry-fit without glue.
2. Before installing a horn, electrically command the unloaded head servo to centre. Then disconnect power. This still needs to be performed using suitable centering firmware, not a sweep command.
3. Seat the servo upright in the torso's neck cradle. Its output shaft faces up, with the output axis slightly toward the front of the case. Secure the case with narrow ties through the cradle slots, keeping the shaft and wires clear.
4. Stack from top to bottom: head-front attachment columns, carrier with its horn recess facing down, original short single horn (spline hub down, horn tip toward the rear of the head), and printed clamp. Align both screw holes. Insert two M2.5 x 10 screws upward through clamp and carrier into the head-front columns. Tighten gently by hand. Do not force a mismatched horn; check the actual fit before trimming any unused tip. Never cut the circular hub or spline.
5. Fit the head facing straight onto the centred servo shaft. Secure the horn with the servo's own centre screw, reached through the roof service hole. Do not substitute an M2.5 screw for this screw.
6. Leave the rear head unglued. After assembly, verify a small, slow head turn with calibrated firmware; do not run the existing broad bench sweep. Only after fit and movement are satisfactory, bond the head shell seam. Keep adhesive away from the moving neck, shaft, horn and carrier. Keep the roof access plug removable.

Start now with step 1 and part identification. Servo centering is the next controlled operation, not something the guide claims has already occurred.

The generated illustration is explanatory; CAD reference is rendered from the actual STL files, with each panel independently scaled. Neither replaces checking the user's physical prints.

Correction after user reported inaccurate AI illustration: use head-attachment-cad.png instead. Printed parts were exported from the final assembly Blender scene in WORLD coordinates using export-head-reference.py; print-oriented STLs must not be interpreted as assembled orientations. render-head-attachment.py renders the actual head front, carrier and clamp with enlarged vertical gaps. Servo and stock horn remain explicitly labelled nominal reference shapes; photo of actual prints/horn requested to verify physical matching. No motors were commanded. The earlier generated illustration is superseded.
