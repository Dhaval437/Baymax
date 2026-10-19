# 10 mm arm extension — round fit prototype

Created from your requested dimensions on 18 October 2026.

| Feature | Dimension |
|---|---:|
| Male peg diameter | 5 mm |
| Female hole diameter | 5 mm |
| Female hole depth | 3 mm |
| Spacer body length | 10 mm |
| Male peg length | 3 mm (assumed to match hole depth) |
| Body outside diameter | 8 mm (chosen for 1.5 mm socket walls) |
| Total end-to-end length | 13 mm |

The male peg projects beyond the 10 mm body. With 3 mm engagement at both ends, the nominal added shaft reach is 10 mm. This is the interpretation used for your request, not a 10 mm overall end-to-end part.

Open **Baymax_arm_extension_10mm_5mm_pair.stl** in Bambu Studio for two identical parts, one per arm. Import the pair as separate objects if prompted. Use 100% scale; units are millimetres. The single STL and editable OpenSCAD source are also supplied.

Suggested starting print settings for your P1S: 0.5 mm nozzle, PLA, textured PEI, 0.12 mm layers, 4 walls, 100% infill, no supports, 3 mm outer brim. Keep the broad socket end flat on the plate and the peg pointing up. The socket roof has a short 5 mm bridge. Preview that roof and clear any loose bridging strands from the socket after printing. The files are geometry, not sliced G-code.

Both 5 mm diameters are nominal, with no fit allowance added. Printed holes may shrink. Test gently with power disconnected; never force the sleeve onto the servo or use the retaining screw to pull it on.

**Important fit limitation:** the model has smooth round male and female surfaces. A servo shaft and stock horn normally use fine matching teeth to transmit rotation. A smooth 5 mm peg/hole is not a verified replacement for those teeth and may slip even if it fits. Do not glue this prototype onto the servo shaft or run the loaded arm on the assumption that diameter alone guarantees drive. A final drive coupling needs the actual spline/interface geometry or a positively fastened stock-horn connection. Your glued arm horn has not been measured beyond the supplied dimensions.

The STL meshes are closed and have positive volume; physical fit, torque transmission and clearance inside the assembled shoulder remain unverified.

