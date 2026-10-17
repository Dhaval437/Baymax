import bpy, json, struct
from pathlib import Path
root=Path(__file__).resolve().parents[1]
bpy.ops.wm.open_mainfile(filepath=str(root/'mechanical/production_180/articulated_v3/Baymax_180_ARTICULATED_PROTOTYPE.blend'))
dest=root/'assembly/arm-cad';dest.mkdir(exist_ok=True)
names=['04_torso_front_DRAFT']
for side in ['Left','Right']:
 names += ['06_'+side+'_arm_and_hand_front_DRAFT','06_'+side+'_arm_and_hand_rear_DRAFT','07_'+side+'_horn_clamp_DRAFT','13_'+side+'_arm_access_plug_DRAFT']
report=[]
for name in names:
 o=bpy.data.objects[name];o.data.calc_loop_triangles();v=[o.matrix_world@p.co for p in o.data.vertices]
 with (dest/(name+'.stl')).open('wb') as f:
  f.write(b'WORLD COORDINATES - arm assembly reference'.ljust(80,b' '));f.write(struct.pack('<I',len(o.data.loop_triangles)))
  for t in o.data.loop_triangles:
   a,b,c=[v[i] for i in t.vertices];n=(b-a).cross(c-a).normalized()
   f.write(struct.pack('<12fH',*n,*a,*b,*c,0))
 report.append({'name':name,'min':[min(p[i] for p in v) for i in range(3)],'max':[max(p[i] for p in v) for i in range(3)]})
(dest/'bounds.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
