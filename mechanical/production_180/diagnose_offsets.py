import bpy,bmesh
from pathlib import Path
from mathutils import Matrix
p=Path(__file__).resolve().parent
bpy.ops.wm.open_mainfile(filepath=str(p.parent/'reference_model/Baymax_ARMS_DOWN_STRAIGHT_HEAD_150mm.blend'))
for name in ['SOURCE - Head','SOURCE - Torso','NEUTRAL - Left arm and hand','NEUTRAL - Right arm and hand']:
 o=bpy.data.objects[name];bm=bmesh.new();bm.from_mesh(o.data);bm.transform(o.matrix_world);bm.normal_update()
 print(name,'volume',bm.calc_volume(signed=True),'dims',list(o.dimensions),'modifiers',[(m.name,m.type) for m in o.modifiers])
 for v in bm.verts:v.co-=v.normal*1.6
 print('inset volume',bm.calc_volume(signed=True))
 bm.free()
