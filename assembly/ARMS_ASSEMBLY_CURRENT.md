# Arm assembly — 16 October 2026

User reports the head assembly is done and requests arm assembly images. No servo was commanded during preparation of this guide. Installed firmware remains the audio diagnostic; do not assume arm centering has been performed.

## Source and image

`arms-assembly-cad.png` uses actual front/rear arm and horn-clamp meshes exported in world coordinates from the final articulated Blender file. Left/right labels retain CAD naming. Both are displayed from the body-facing side, normalized to show the same assembly relationship. Explosion spacing is enlarged. Blue servo and orange single horn are explicitly nominal reference shapes; actual hardware fit is not established by the image.

The source release guide is `mechanical/production_180/PRINT_PACKAGE_180MM/ASSEMBLY_AND_HARDWARE.txt`, especially steps 5, 6 and 12. Joint geometry was checked against build_articulated_v3.py and finishing_features_v3.py.

## Parts per arm

- Matching `06_Left` or `06_Right` arm-and-hand front and rear shell.
- Corresponding `07_Left_horn_clamp` or `07_Right_horn_clamp`, rectangular with central output-housing clearance and two small fixing holes.
- Corresponding `13_Left_arm_access_plug` or `13_Right_arm_access_plug`.
- SG90 positional servo, original short single-arm horn, original horn retaining screw.
- Two M2.5 x 10 mm clamp screws; two M2.5 x 20 mm rear-cover screws; narrow cable ties. Optional existing printed case shim if needed.

## Assembly

1. Match printed front/rear pairs and remove supports gently. Dry-fit without glue.
2. Centre each unloaded servo electrically with the horn removed, then disconnect power before handling the parts. Use a centering command, not a sweep.
3. With torso rear open, seat the servos horizontally in the torso's internal shoulder cradles. Shafts point outward through shoulder openings. Tie cases through provided slots; keep wiring and ties off the shafts. Do not disturb the completed head assembly.
4. Seat a short original horn in each arm hub pocket, tip pointing down toward the hand. The printed clamp is on the body-facing side. Dry-fit both shell halves to align the clamp bosses: the geometry has one clamp-screw boss in each half. Use two M2.5 x 10 mm screws per clamp. Do not force an unsuitable horn or substitute a printed spline.
5. Use the two M2.5 x 20 mm rear-cover screws per arm. Keep the assembly accessible while checking the hub and horn fit. Hand-tighten only.
6. At servo centre, fit the arm with its hand down. Install the servo's own horn retaining screw through the outer shoulder access hole. Keep the access plug removable.
7. Test a small, slow lift on one arm at a time using calibrated firmware. Existing broad bench sweeps are not an appropriate first mounted test. Do not force a binding joint.

No glue in the shoulder bearing clearance, horn interface, moving seam or removable arm covers.
