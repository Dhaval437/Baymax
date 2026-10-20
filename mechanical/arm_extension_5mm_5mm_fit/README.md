# 5 mm Baymax arm extender — same 5 mm fittings

Shortened the previous 10 mm spacer body to **5 mm** on 19 October 2026. The previous files remain unchanged.

| Feature | Dimension |
|---|---:|
| Spacer body length | 5 mm |
| Body outside diameter | 8 mm |
| Male peg diameter | 5 mm |
| Male peg projection | 3 mm |
| Female socket diameter | 5 mm |
| Female socket depth | 3 mm |
| Total length including peg | 8 mm |

Use `Baymax_arm_extension_5mm_5mm_pair.stl` for both arms, or the single STL for one part. Units are millimetres; import at **100% scale**. Do not scale the old STL to 50%: that would also shrink the fittings. The editable OpenSCAD file is included.

For the previously confirmed Bambu P1S, 0.4 mm nozzle, PLA and textured PEI: start with 0.12 mm layers, 4 walls, 100% infill and a 3 mm outer brim. Place the wide socket end on the plate, peg pointing up. The socket roof bridges 5 mm; check its preview and clean loose strands before fitting. These are STL geometry files, not sliced print instructions.

The nominal diameters, smooth round surfaces and lack of fit allowance are unchanged. As with the earlier part, it has no servo spline teeth and is a fit prototype, not a verified torque-transmitting coupling. Test the fit gently with power off. Do not force or glue it onto the servo shaft.

The generator verifies closed edges, topology and positive volume. Physical fit and loaded strength remain untested. See `dimensions_and_mesh_check.json` for the dimensions and mesh checks.
