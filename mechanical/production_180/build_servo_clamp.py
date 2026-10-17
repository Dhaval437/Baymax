"""Replaceable SG90 tab-clamping bracket; avoids assuming servo ear-hole centres."""
import bpy,bmesh,json,struct
from pathlib import Path
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'servo_bracket_development';OUT.mkdir(exist_ok=True)
spec=json.loads((ROOT/'servo_design_basis.json').read_text())
bpy.ops.object.select_all(action='SELECT');bpy.ops.object.delete(use_global=False)
def cube(name,loc,dims):
 bpy.ops.mesh.primitive_cube_add(size=1,location=loc);o=bpy.context.object;o.name=name;o.dimensions=dims
 bpy.ops.object.transform_apply(location=False,rotation=False,scale=True);return o
def cyl(loc,r,h):
 bpy.ops.mesh.primitive_cylinder_add(vertices=48,radius=r,depth=h,location=loc);return bpy.context.object
def subtract(o,t):
 m=o.modifiers.new('Cut','BOOLEAN');m.operation='DIFFERENCE';m.solver='EXACT';m.object=t
 bpy.context.view_layer.objects.active=o;bpy.ops.object.modifier_apply(modifier=m.name);bpy.data.objects.remove(t,do_unlink=True)
frame=cube('SG90_clamp_frame',(0,0,1.5),(42,28,3))
subtract(frame,cube('Case aperture',(0,0,1.5),(*spec['proposed_case_aperture_mm'],7)))
parts=[frame]
for side in [-1,1]:
 cap=cube('SG90_tab_clamp_'+('left' if side<0 else 'right'),(side*16,0,6),(7,28,2))
 for y in [-10,10]:
  subtract(frame,cyl((side*16,y,1.5),1.7,7))
  # Elongated cap holes accommodate assembly placement; screw centres belong
  # to our clamp, NOT the servo manufacturer's tab-hole pattern.
  subtract(cap,cube('Clamp adjustment slot',(side*16,y,6),(3.4,5.4,6)))
 parts.append(cap)
reports=[]
for o in parts:
 bm=bmesh.new();bm.from_mesh(o.data);bmesh.ops.triangulate(bm,faces=list(bm.faces))
 bm.to_mesh(o.data)
 report={'name':o.name,'nonmanifold_edges':sum(not e.is_manifold for e in bm.edges),'volume_mm3':bm.calc_volume(signed=True)};bm.free()
 assert report['nonmanifold_edges']==0 and report['volume_mm3']>0
 reports.append(report)
 mesh=o.data;mesh.calc_loop_triangles();verts=[o.matrix_world@v.co for v in mesh.vertices];zmin=min(v.z for v in verts)
 for v in verts:v.z-=zmin
 with (OUT/(o.name+'.stl')).open('wb') as f:
  f.write(b'SG90 adjustable clamp development mm'.ljust(80,b' '));f.write(struct.pack('<I',len(mesh.loop_triangles)))
  for t in mesh.loop_triangles:
   v=[verts[i] for i in t.vertices];n=(v[1]-v[0]).cross(v[2]-v[0]).normalized();f.write(struct.pack('<12fH',*n,*v[0],*v[1],*v[2],0))
scene=bpy.context.scene;scene.unit_settings.system='METRIC';scene.unit_settings.scale_length=.001
scene['STATUS']='Standalone clamp design. Not integrated into shoulder or neck; no physical fit claim.'
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'SG90_adjustable_tab_clamp.blend'))
(OUT/'report.json').write_text(json.dumps({'source':spec['source_url'],'case_aperture_mm':spec['proposed_case_aperture_mm'],'parts':reports,'hardware':'Four M3 screws, nuts and suitable washers per clamp; lengths to be checked against actual tab thickness. Not yet confirmed owned.','status':scene['STATUS']},indent=2))
print(json.dumps(reports))
