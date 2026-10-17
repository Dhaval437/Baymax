"""Inspect component clearances against the real development shells, in mm."""
import bpy,bmesh,json,math,sys
from pathlib import Path
from mathutils import Vector
ROOT=Path(__file__).resolve().parent
source=ROOT/'Baymax_180_MECHANICAL_DEVELOPMENT.blend'
with_fasteners='--shell-fasteners' in sys.argv
if with_fasteners:source=ROOT/'panel_fasteners_v2/Baymax_180_SERVICE_PANELS_V2.blend'
bpy.ops.wm.open_mainfile(filepath=str(source))
cx=4.820418357849121
col=bpy.data.collections.new('COMPONENT ENVELOPES - NOT PRINTABLE');bpy.context.scene.collection.children.link(col)
def box(name,pos,size):
 bpy.ops.object.select_all(action='DESELECT');bpy.ops.mesh.primitive_cube_add(size=1,location=pos)
 o=bpy.context.object;o.name=name;o.dimensions=size
 bpy.ops.object.transform_apply(location=False,rotation=False,scale=True)
 for c in list(o.users_collection):c.objects.unlink(o)
 col.objects.link(o);o.display_type='WIRE';o.show_in_front=True;o.hide_render=True;return o
components=[]
# Body dimensions are manufacturer references. Shaft offset remains provisional.
for sign,label in [(-1,'Left'),(1,'Right')]:
 components.append(box(label+' shoulder servo CASE',(cx+sign*13,-1,128),(22.8,22.4,12.5)))
components.append(box('Neck servo CASE',(3,0,146.5),(12.5,22.4,22.8)))
bpy.ops.mesh.primitive_cylinder_add(vertices=64,radius=26,depth=26,location=(cx,3,94),rotation=(math.pi/2,0,0))
speaker=bpy.context.object;speaker.name='Speaker measured envelope';bpy.ops.object.transform_apply(location=False,rotation=True,scale=True)
for c in list(speaker.users_collection):c.objects.unlink(speaker)
col.objects.link(speaker);speaker.display_type='WIRE';speaker.show_in_front=True;speaker.hide_render=True;components.append(speaker)
def intersection(a,b):
 o=a.copy();o.data=a.data.copy();bpy.context.scene.collection.objects.link(o);o.hide_render=False;o.hide_viewport=False
 m=o.modifiers.new('Clearance inspection','BOOLEAN');m.operation='INTERSECT';m.solver='EXACT';m.object=b
 bpy.context.view_layer.objects.active=o;bpy.context.view_layer.update();bpy.ops.object.modifier_apply(modifier=m.name)
 bm=bmesh.new();bm.from_mesh(o.data);v=abs(bm.calc_volume(signed=True));bm.free();bpy.data.objects.remove(o,do_unlink=True);return v
reports=[]
shells=[bpy.data.objects[n] for n in ['04_torso_front_DRAFT','04_torso_rear_DRAFT']]
for c in components:
 for s in shells:
  volume=intersection(c,s);reports.append({'component':c.name,'against':s.name,'intersection_mm3':round(volume,3),'pass':volume<.01})
for i,a in enumerate(components):
 for b in components[i+1:]:
  v=intersection(a,b);reports.append({'component':a.name,'against':b.name,'intersection_mm3':round(v,3),'pass':v<.01})
report={'source':source.name,'checks':reports,'limits':'Rigid case envelopes only. Servo tabs, horns, cable exits, brackets, minimum walls and motion still require checking.'}
report_name='internal_layout_with_fasteners.json' if with_fasteners else 'internal_layout_audit.json'
(ROOT/report_name).write_text(json.dumps(report,indent=2))
bpy.context.scene['STATUS']='Component layout audit; intersections are unfinished design work'
blend_name='Baymax_180_INTERNAL_LAYOUT_WITH_FASTENERS.blend' if with_fasteners else 'Baymax_180_INTERNAL_LAYOUT_AUDIT.blend'
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/blend_name))
print(json.dumps(report),flush=True)
