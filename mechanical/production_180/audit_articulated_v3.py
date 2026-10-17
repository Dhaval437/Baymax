"""Static and sampled-motion interference measurements, not a physical-fit guarantee."""
import bpy,bmesh,math,json
from pathlib import Path
from mathutils import Vector,Matrix
ROOT=Path(__file__).resolve().parent/'articulated_v3'
bpy.ops.wm.open_mainfile(filepath=str(ROOT/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
CX=4.820418357849121
parts=[o for o in bpy.data.collections['MECHANICAL DEVELOPMENT - NOT FULL PRINT RELEASE'].objects if o.type=='MESH' and o.name.endswith('_DRAFT')]
def bounds(o):
 v=[o.matrix_world@Vector(p) for p in o.bound_box]
 return [min(p[i] for p in v) for i in range(3)],[max(p[i] for p in v) for i in range(3)]
def volume(a,b):
 bpy.context.view_layer.update();la,ha=bounds(a);lb,hb=bounds(b)
 if any(min(ha[i],hb[i])-max(la[i],lb[i])<.001 for i in range(3)):return 0.
 o=a.copy();o.data=a.data.copy();bpy.context.scene.collection.objects.link(o)
 o.hide_viewport=False;o.hide_render=False
 m=o.modifiers.new('Measured interference','BOOLEAN');m.operation='INTERSECT';m.solver='MANIFOLD';m.object=b
 bpy.context.view_layer.objects.active=o;bpy.context.view_layer.update();bpy.ops.object.modifier_apply(modifier=m.name)
 bm=bmesh.new();bm.from_mesh(o.data);v=abs(bm.calc_volume(signed=True));bm.free()
 bpy.data.objects.remove(o,do_unlink=True);return round(v,4)
def box(name,p,d):
 bpy.ops.mesh.primitive_cube_add(size=1,location=p);o=bpy.context.object;o.name=name;o.dimensions=d
 bpy.ops.object.transform_apply(location=False,rotation=False,scale=True);return o
static=[]
for i,a in enumerate(parts):
 for b in parts[i+1:]:
  v=volume(a,b)
  if v>.03:static.append({'a':a.name,'b':b.name,'mm3':v});print('STATIC',static[-1],flush=True)
components=[box(side+' servo case',(CX+sign*13,-1,128),(22.8,22.4,12.5)) for side,sign in [('Left',-1),('Right',1)]]
components += [box('Neck servo case',(3,4,147.5),(12.5,22.4,22.8)),box('ESP32 envelope',(CX,-15,12.9),(64,29,15)),box('Distribution envelope',(CX,19,14.4),(50,30,18)),box('Amplifier envelope',(CX+35,15,11.4),(20,20,12))]
def cylinder(name,p,r,h,axis):
 bpy.ops.mesh.primitive_cylinder_add(vertices=64,radius=r,depth=h,location=p)
 o=bpy.context.object;o.name=name
 if axis=='X':o.rotation_euler.y=math.pi/2
 bpy.ops.object.transform_apply(location=False,rotation=True,scale=True);return o
def add(a,b):
 m=a.modifiers.new('Full servo envelope','BOOLEAN');m.operation='UNION';m.solver='MANIFOLD';m.object=b
 bpy.context.view_layer.objects.active=a;bpy.context.view_layer.update();bpy.ops.object.modifier_apply(modifier=m.name)
 bpy.data.objects.remove(b,do_unlink=True)
for a,sign in zip(components[:2],[-1,1]):
 add(a,box('Servo wings',(CX+sign*21.3,-1,128),(2.4,32.4,12.5)))
 add(a,cylinder('Servo output housing',(CX+sign*27.4,4.2,128),6.25,6.02,'X'))
 add(a,cylinder('Servo spline',(CX+sign*32.4,4.2,128),2.5,4.02,'X'))
neck=components[2]
add(neck,box('Neck wings',(3,4,155.8),(12.5,32.4,2.4)))
add(neck,cylinder('Neck output housing',(3,-1.2,161.9),6.25,6.02,'Z'))
add(neck,cylinder('Neck spline',(3,-1.2,166.9),2.5,4.02,'Z'))
bpy.ops.mesh.primitive_cylinder_add(vertices=64,radius=26,depth=26,location=(CX,3.5,92),rotation=(math.pi/2,0,0));components.append(bpy.context.object);components[-1].name='Speaker measured envelope'
bpy.ops.object.transform_apply(location=False,rotation=True,scale=True)
component_hits=[]
for c in components:
 for p in parts:
  v=volume(c,p)
  if v>.03:component_hits.append({'component':c.name,'part':p.name,'mm3':v});print('COMPONENT',component_hits[-1],flush=True)
for i,a in enumerate(components):
 for b in components[i+1:]:
  v=volume(a,b)
  if v>.03:component_hits.append({'component':a.name,'part':b.name,'mm3':v})
motion=[]
fixed=[o for o in parts if o.name.startswith(('01_','03_','04_'))]+components
groups=[]
for side in ['Left','Right']:
 group=[o for o in parts if o.name.startswith('06_'+side) or o.name=='07_'+side+'_horn_clamp_DRAFT' or o.name.startswith('13_'+side)]
 groups.append((side+' arm',group,Vector((CX,4.2,128)),'X',range(0,-31,-2)))
head=[o for o in parts if o.name.startswith('05_') or o.name.startswith('07_head') or o.name.startswith('14_')]
groups.append(('Head',head,Vector((3,-1.2,166)),'Z',range(-20,21,2)))
for label,group,pivot,axis,angles in groups:
 original={o:o.matrix_world.copy() for o in group}
 for angle in angles:
  transform=Matrix.Translation(pivot)@Matrix.Rotation(math.radians(angle),4,axis)@Matrix.Translation(-pivot)
  for a in group:a.matrix_world=transform@original[a]
  for a in group:
   for b in fixed:
    v=volume(a,b)
    if v>.03:motion.append({'group':label,'angle':angle,'a':a.name,'b':b.name,'mm3':v});print('MOTION',motion[-1],flush=True)
 for a in group:a.matrix_world=original[a]
report={'status':'Interference audit; positive overlaps require review','static_overlaps':static,'component_overlaps':component_hits,'sampled_motion_overlaps':motion,'limits':'2 degree samples; nominal servo case, wing, turret and spline envelopes included. Cable bends, flexible ties, horn-specific geometry and supplier variations require physical assembly verification.'}
(ROOT/'interference_report.json').write_text(json.dumps(report,indent=2))
print('AUDIT COMPLETE',len(static),len(component_hits),len(motion),flush=True)
