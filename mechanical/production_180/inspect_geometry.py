import bpy,json
from pathlib import Path
from mathutils import Vector
r=Path(__file__).resolve().parent/'articulated_v3'
bpy.ops.wm.open_mainfile(filepath=str(r/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
for name in ['SOURCE - Head','SOURCE - Torso','05_head_front_DRAFT','04_torso_front_DRAFT','NEUTRAL - Left arm and hand','03_Leg_left_DRAFT']:
 o=bpy.data.objects[name];v=[o.matrix_world@p.co for p in o.data.vertices]
 print(name,[round(min(p[i] for p in v),2) for i in range(3)],[round(max(p[i] for p in v),2) for i in range(3)],flush=True)
