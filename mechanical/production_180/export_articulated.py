"""Export oriented meshes and quantitative wall samples for slicer review."""
import bpy,bmesh,json,struct,math
from pathlib import Path
from mathutils import Matrix,Vector
from mathutils.bvhtree import BVHTree
R=Path(__file__).resolve().parent/'articulated_v3'
bpy.ops.wm.open_mainfile(filepath=str(R/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
out=R/'review_stl';out.mkdir(exist_ok=True)
parts=[o for o in bpy.data.collections['MECHANICAL DEVELOPMENT - NOT FULL PRINT RELEASE'].objects if o.type=='MESH' and o.name.endswith('_DRAFT')]
reports=[]
for o in parts:
 bm=bmesh.new();bm.from_mesh(o.data)
 bad=sum(not e.is_manifold for e in bm.edges)
 if bad:raise ValueError(o.name+' has '+str(bad)+' nonmanifold edges')
 bm.free()
 o.data.calc_loop_triangles()
 vertices=[o.matrix_world@v.co for v in o.data.vertices]
 faces=[list(t.vertices) for t in o.data.loop_triangles]
 tree=BVHTree.FromPolygons(vertices,faces,all_triangles=True)
 distances=[];thin_area=0.;sample_area=0.;thin_points=[]
 step=max(1,len(faces)//6000)
 for f in faces[::step]:
  a,b,c=[vertices[i] for i in f];cross=(b-a).cross(c-a);area=cross.length/2
  if area<.002:continue
  n=cross.normalized();p=(a+b+c)/3
  hit,normal,index,distance=tree.ray_cast(p-n*.015,-n,100.)
  if hit is None or normal.dot(n)>-.05:continue
  t=distance+.015;distances.append(t);sample_area+=area
  if t<.8:
   thin_area+=area
   if len(thin_points)<20:thin_points.append([round(a,3) for a in p])
 transform=Matrix.Identity(4)
 if o.name.startswith('01_'):transform=Matrix.Rotation(math.pi,4,'X')
 elif '_front_' in o.name:transform=Matrix.Rotation(-math.pi/2,4,'X')
 elif '_rear_' in o.name:transform=Matrix.Rotation(math.pi/2,4,'X')
 elif o.name.startswith(('07_Left','07_Right','13_')):transform=Matrix.Rotation(math.pi/2,4,'Y')
 elif o.name.startswith(('08_','10_','11_')):transform=Matrix.Rotation(math.pi/2,4,'X')
 v=[transform@p for p in vertices];low=Vector(tuple(min(p[i] for p in v) for i in range(3)))
 v=[p-low for p in v]
 with (out/(o.name+'.stl')).open('wb') as fp:
  fp.write(b'Baymax 180 - oriented geometry for slicer review'.ljust(80,b' '));fp.write(struct.pack('<I',len(faces)))
  for f in faces:
   a,b,c=[v[i] for i in f];n=(b-a).cross(c-a).normalized()
   fp.write(struct.pack('<12fH',*n,*a,*b,*c,0))
 reports.append({'part':o.name,'triangles':len(faces),'nonmanifold_edges':bad,'oriented_dimensions_mm':[round(max(p[i] for p in v),3) for i in range(3)],'wall_samples':len(distances),'sampled_min_mm':round(min(distances),3) if distances else None,'sampled_area_under_0_8_mm_percent':round(100*thin_area/max(sample_area,.001),3),'thin_sample_locations':thin_points})
(R/'export_wall_report.json').write_text(json.dumps(reports,indent=2))
print(json.dumps(reports),flush=True)
