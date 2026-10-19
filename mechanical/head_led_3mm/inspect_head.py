import bpy,json
from pathlib import Path
from mathutils import Vector
from mathutils.bvhtree import BVHTree
root=Path(__file__).resolve().parents[2]
bpy.ops.wm.open_mainfile(filepath=str(root/'mechanical/production_180/articulated_v3/Baymax_180_ARTICULATED_PROTOTYPE.blend'))
out=[]
for o in bpy.data.objects:
 if o.type=='MESH' and any(s in o.name.lower() for s in ['head','face']):
  v=[o.matrix_world@p.co for p in o.data.vertices]
  if not v:continue
  out.append({'name':o.name,'min':[min(p[i] for p in v) for i in range(3)],'max':[max(p[i] for p in v) for i in range(3)]})
Path(__file__).with_name('source_bounds.json').write_text(json.dumps(out,indent=2))
print(json.dumps(out))
