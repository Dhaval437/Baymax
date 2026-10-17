# Servo body fit gauges — first small print

These test the opening for the lower rectangular servo body, **not** the mounting-tab span and not the horn. They are not finished servo holders, and they do not prove arm strength or alignment. The apertures are trial sizes based on the photographed form; the user's 30 × 32 × 11 mm overall measurements remain recorded separately. No exact SG90 manufacturing dimensions are assumed.

| File | Edge marks | Opening, mm | Outside, mm |
|---|---|---|---|
| servo-fit-1.stl | One notch | 23 × 12 | 31 × 20 × 2 |
| servo-fit-2.stl | Two notches | 24 × 13 | 32 × 21 × 2 |
| servo-fit-3.stl | Three notches | 25 × 14 | 33 × 22 × 2 |

## Print on the P1S

1. Import the three STL files into Bambu Studio as **separate objects**. Arrange them on the plate, flat as supplied. STL units are millimetres; confirm the outside dimensions match the table. Keep scale at 100%.
2. Use your normal white PLA profile, 0.20 mm layers and three walls. No supports are needed. Use the normal bed/filament settings you already use successfully. A brim is optional if your normal plate adhesion needs it.
3. Slice and inspect the preview: three flat frames, each with an open centre. The 2 mm thickness is ten layers at 0.20 mm.
4. Print, let cool, and remove any small edge burrs. Keep the servo unplugged and its horn detached.
5. Gently pass the servo connector and wire through an opening, then try inserting the lower rectangular servo body until its mounting tabs rest on the frame. Keep the wire clear of the edge. **Do not force a tight fit or press on the output shaft.** If the cable exit prevents seating, report that instead of squeezing it.
6. Report which notch count gives the closest fit that slides in without force, whether it wobbles, and whether both mounting tabs sit flat. If none fit, say which dimension catches (long side, thin side, or wire exit).

That result sets the holder's body opening. We will locate the mounting holes and shaft separately and make a holder test before printing the full Baymax body.

## Horns in the user's photo

- Left: short single-arm horn; first candidate for a compact shoulder attachment.
- Middle: double-arm horn.
- Right: cross horn.
- Three screws are visible; two appear longer and one shorter. The shorter one is a candidate for retaining the horn on the servo shaft, but thread/fit must be checked gently rather than inferred from the picture. Do not force a screw or drill the spline hub.

The plastic horn engages the servo's splined shaft; the printed arm will attach to the supplied horn. We will not rely on printing a matching fine spline. Do not install the horn permanently until the servo has been centred electrically.

## Validation

`generate.py` produces these files using only Python's standard library. It checks every mesh edge has exactly two incident faces, face winding is consistent, triangles are non-degenerate, and mesh volume matches the intended frame minus aperture and notches. Slicer review and physical fit remain required; no printer job has been started.
