import bpy
from pathlib import Path
from mathutils import Vector
from mathutils.bvhtree import BVHTree
R=Path(__file__).resolve().parent/'articulated_v3'
bpy.ops.wm.open_mainfile(filepath=str(R/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
for name,pos in [('05_head_front_DRAFT',(12.282,-8.488,170.161)),('06_Right_arm_and_hand_front_DRAFT',(38.573,-12.111,108.888))]:
 o=bpy.data.objects[name];o.data.calc_loop_triangles();vs=[o.matrix_world@v.co for v in o.data.vertices]
 t=BVHTree.FromPolygons(vs,[list(f.vertices) for f in o.data.loop_triangles],all_triangles=True)
 p,n,i,d=t.find_nearest(Vector(pos));hit,nn,ii,dd=t.ray_cast(p-n*.015,-n,100)
 print(name,'p',p,'normal',n,'hit',hit,'hitnormal',nn,'thickness',dd,flush=True)
