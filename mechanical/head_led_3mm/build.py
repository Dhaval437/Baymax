"""LED-head prototype using original head and unchanged servo mounting datums, mm."""
import bpy,bmesh,math,json,struct
from pathlib import Path
from mathutils import Vector,Matrix
from mathutils.bvhtree import BVHTree
OUT=Path(__file__).resolve().parent
ROOT=OUT.parents[1]
bpy.ops.wm.open_mainfile(filepath=str(ROOT/'mechanical/production_180/articulated_v3/Baymax_180_ARTICULATED_PROTOTYPE.blend'))
COL=bpy.data.collections.new('LED HEAD 3MM — FIT PROTOTYPE');bpy.context.scene.collection.children.link(COL)
def own(o):
 for c in list(o.users_collection):c.objects.unlink(o)
 COL.objects.link(o);return o
def clone(o,name):
 n=o.copy();n.data=o.data.copy();n.modifiers.clear();COL.objects.link(n);n.name=name;n.hide_viewport=False;n.hide_render=False
 bpy.context.view_layer.objects.active=n;n.select_set(True)
 return n
def cube(name,p,d):
 bpy.ops.object.select_all(action='DESELECT');bpy.ops.mesh.primitive_cube_add(size=1,location=p)
 o=bpy.context.object;o.name=name;o.dimensions=d;bpy.ops.object.transform_apply(location=False,rotation=False,scale=True);return own(o)
def cyl(name,p,r,h,axis='Y'):
 bpy.ops.object.select_all(action='DESELECT');bpy.ops.mesh.primitive_cylinder_add(vertices=64,radius=r,depth=h,location=p)
 o=bpy.context.object;o.name=name
 if axis=='Y':o.rotation_euler.x=math.pi/2
 elif axis=='X':o.rotation_euler.y=math.pi/2
 bpy.ops.object.transform_apply(location=False,rotation=True,scale=True);return own(o)
def boolean(o,t,op='DIFFERENCE'):
 bpy.context.view_layer.update();m=o.modifiers.new('LED assembly','BOOLEAN');m.operation=op;m.solver='MANIFOLD';m.object=t
 bpy.context.view_layer.objects.active=o;bpy.ops.object.modifier_apply(modifier=m.name);bpy.data.objects.remove(t,do_unlink=True)
def union(o,t):boolean(o,t,'UNION')
def worldtree(o):
 bpy.context.view_layer.update();return BVHTree.FromPolygons([o.matrix_world@v.co for v in o.data.vertices],[list(p.vertices) for p in o.data.polygons])
def surface(o,x,z,front):
 p=worldtree(o).ray_cast(Vector((x,-100 if front else 100,z)),Vector((0,1 if front else -1,0)))[0]
 assert p is not None,(o.name,x,z);return p.y
def stats(o):
 bm=bmesh.new();bm.from_mesh(o.data);bmesh.ops.triangulate(bm,faces=list(bm.faces))
 seen=set();islands=0
 for v in bm.verts:
  if v in seen:continue
  islands+=1;seen.add(v);q=[v]
  while q:
   v=q.pop()
   for e in v.link_edges:
    w=e.other_vert(v)
    if w not in seen:seen.add(w);q.append(w)
 result={'part':o.name,'nonmanifold_edges':sum(not e.is_manifold for e in bm.edges),'islands':islands,'volume_mm3':bm.calc_volume(signed=True),'triangles':len(bm.faces)}
 bm.free();return result
def cleanup(o):
 bm=bmesh.new();bm.from_mesh(o.data)
 bmesh.ops.triangulate(bm,faces=list(bm.faces))
 bmesh.ops.remove_doubles(bm,verts=list(bm.verts),dist=.0001 if 'head_front' in o.name else .001)
 bmesh.ops.dissolve_degenerate(bm,edges=list(bm.edges),dist=.00001)
 badfaces=[f for f in bm.faces if f.calc_area()<(1e-8 if 'head_front' in o.name else 1e-12)]
 if badfaces:bmesh.ops.delete(bm,geom=badfaces,context='FACES_ONLY')
 wire=[e for e in bm.edges if not e.link_faces]
 if wire:bmesh.ops.delete(bm,geom=wire,context='EDGES')
 loose=[v for v in bm.verts if not v.link_faces]
 if loose:bmesh.ops.delete(bm,geom=loose,context='VERTS')
 boundary=[e for e in bm.edges if e.is_boundary]
 if boundary and len(boundary)<=20 and max(e.calc_length() for e in boundary)<.05:
  bmesh.ops.holes_fill(bm,edges=boundary,sides=8)
 print('CLEAN',o.name,[(len(e.link_faces),round(e.calc_length(),6)) for e in bm.edges if not e.is_manifold][:12],flush=True)
 bmesh.ops.recalc_face_normals(bm,faces=list(bm.faces))
 bm.to_mesh(o.data);bm.free();o.data.update()
def overlap(a,b):
 t=clone(a,'Intersection check');boolean(t,clone(b,'Check cutter'),'INTERSECT');s=stats(t);bpy.data.objects.remove(t,do_unlink=True);return max(0,s['volume_mm3'])
carrier=clone(bpy.data.objects['07_head_carrier_DRAFT'],'05_Original_head_carrier')
clamp=clone(bpy.data.objects['07_head_horn_clamp_DRAFT'],'06_Original_horn_clamp')
plug=clone(bpy.data.objects['14_head_access_plug_DRAFT'],'07_Original_roof_plug')
def ellipsoid(name,p,s):
 bpy.ops.mesh.primitive_uv_sphere_add(segments=96,ring_count=64,location=p)
 o=own(bpy.context.object);o.name=name;o.scale=s
 bpy.ops.object.transform_apply(location=False,rotation=False,scale=True);return o
# A smooth replacement exterior removes the old solid eye relief completely.
# Overall envelope remains about28 x28 x18.5mm; all motor datums below are original.
outer=ellipsoid('Smooth replacement exterior',(.58,-1.38,170.76),(13.88,13.8,9.24))
front=clone(outer,'01_LED_head_front')
boolean(front,ellipsoid('Inner head cavity',(.7,-1.2,171),(10.5,10,6.6)))
boolean(front,cyl('Original output shaft clearance',(3,-1.2,163),4.5,15,'Z'))
rear=clone(front,'02_LED_head_rear')
boolean(front,cube('Front split',(0,-150.15,170),(100,300,100)),'INTERSECT')
boolean(rear,cube('Rear split',(0,150.15,170),(100,300,100)),'INTERSECT')
for x in [-11.5,12.5]:
 peg=cyl('Original locating peg',(x,.15,171),1.6,2.4)
 boolean(peg,clone(outer,'Locator envelope'),'INTERSECT');union(front,peg)
 boolean(rear,cyl('Locating socket',(x,.4,171),1.85,2.0))
for x in [-1,7]:
 boss=cyl('Original head carrier column',(x,-4,174),3,8.4,'Z')
 boolean(boss,clone(outer,'Column envelope'),'INTERSECT');union(front,boss)
 boolean(front,cyl('Original carrier pilot',(x,-4,173),1.025,7,'Z'))
for shell in [front,rear]:
 boolean(shell,cyl('Original carrier clearance',(3,-1.2,169),8.2,2.3,'Z'))
 boolean(shell,cyl('Horn clamp insertion clearance',(3,-1.2,164.5),8.2,9.0,'Z'))
 boolean(shell,cyl('Original roof screw access',(3,-1.2,179),2.5,24,'Z'))
parts=[front,rear,carrier,clamp,plug]
eyes=[];retainers=[]
# Body OD3, flange OD3.8, flange thickness0.7, lens tip-to-flange5.2 assumed.
# Recess opens toward rear; C-fork slides sideways from centre, around the leads.
for side,x in [('Right',-5.5),('Left',5.6)]:
 z=173.3;seat=-8.8
 boss=cyl('Eye boss',(x,-9.9,z),2.75,4.0)
 boolean(boss,clone(outer,'Eye boss outer limit'),'INTERSECT');union(front,boss)
 boolean(front,cyl('3.3mm LED bore',(x,-14,z),1.65,12))
 # Counterbore leaves a flange shoulder at y=-8.8 and room for removal.
 boolean(front,cyl('Flange seat',(x,-8.0,z),2.05,1.6))
 # Top/bottom rails allow insertion through the open rear from centre outwards.
 for dz in [-2.5,2.5]:
  rail=cube('LED keeper rail',(x,-7.75,z+dz),(4.5,1.9,1.5));union(front,rail)
 boolean(front,cube('Keeper insertion groove',(x/2,-7.6,z),(abs(x)+4.4,1.0,5.2)))
 boolean(front,cyl('Clear flange after rails',(x,-8.0,z),2.05,1.6))
 boolean(front,cyl('Clear lens after rails',(x,-14,z),1.65,12))
 fork=cube('03_'+side+'_LED_retainer',(x,-7.6,z),(4.0,.7,4.9))
 boolean(fork,cube('Lead escape',(x+(1 if x>0 else -1),-7.6,z),(3.6,2.0,2.2)))
 # Hardware envelopes for geometric collision checks, never exported as print parts.
 led=cyl('REFERENCE '+side+' LED lens',(x,seat-2.6,z),1.5,5.2)
 union(led,cyl('REFERENCE LED flange',(x,seat+.35,z),1.9,.7))
 eyes.append(led);retainers.append(fork);parts.append(fork)

# Rear screws clear the LED bodies and original vertical carrier fixing holes.
fasteners=[]
for x in [-9.0,10.0]:
 z=175.7;yf=surface(outer,x,z,True);yb=surface(outer,x,z,False)
 boss=cyl('Rear cover threaded boss',(x,(yf+.5-.15)/2,z),2.2,-.15-(yf+.5))
 boolean(boss,clone(outer,'Boss exterior limit'),'INTERSECT');union(front,boss)
 boolean(front,cyl('M2 pilot',(x,-2.1,z),.8,4.3))
 back=cyl('Rear screw support',(x,(.15+yb-.5)/2,z),2.2,yb-.5-.15)
 boolean(back,clone(outer,'Rear support limit'),'INTERSECT');union(rear,back)
 boolean(rear,cyl('M2 clearance',(x,(yb+.15)/2,z),1.1,yb+3))
 boolean(rear,cyl('M2 head counterbore',(x,yb-.35,z),2.0,1.4))
 fasteners.append({'x':x,'z':z,'outer_back_y':yb,'screw':'M2 x 8 mm','engagement_mm':8-(yb-.15)})
for x in [-5.5,5.6]:
 boolean(front,cube('Clear keeper groove after cover posts',(x/2,-7.6,173.3),(abs(x)+4.4,1.0,5.2)))
# Rear-bottom wire exit avoids original carrier and servo shaft. Hand route a slack loop.
boolean(rear,cyl('Head LED cable exit',(0,8.8,164.5),1.5,7,'Z'))
# Slot in rear interior gives a tiny nylon tie an anchor away from service roof plug.
anchor=cube('Wire tie anchor',(0,9.1,169.3),(5,3,2.2))
boolean(anchor,clone(outer,'Anchor envelope'),'INTERSECT');union(rear,anchor)
boolean(rear,cube('Wire tie slot',(0,9.1,169.3),(3.0,5,1.0)))

for p in parts:cleanup(p)
checks=[]
for led in eyes:
 for target in [carrier,clamp,front,rear]:
  checks.append({'a':led.name,'b':target.name,'intersection_mm3':round(overlap(led,target),6)})
for fork in retainers:
 for target in [carrier,clamp,front,rear]:checks.append({'a':fork.name,'b':target.name,'intersection_mm3':round(overlap(fork,target),6)})
 # A sideways insertion path must be available with rear cover removed.
 for step in [0,.25,.5,.75]:
  sample=clone(fork,'Retainer insertion sample');sample.location.x*=step
  checks.append({'a':fork.name+' insertion '+str(step),'b':front.name,'intersection_mm3':round(overlap(sample,front),6)})
  bpy.data.objects.remove(sample,do_unlink=True)
checks.append({'a':front.name,'b':rear.name,'intersection_mm3':round(overlap(front,rear),6)})
for mount in [carrier,clamp]:
 for shell in [front,rear]:checks.append({'a':mount.name,'b':shell.name,'intersection_mm3':round(overlap(mount,shell),6)})
reports=[stats(p) for p in parts]
report={'units':'mm','led_assumptions':{'body_diameter':3,'flange_diameter':3.8,'flange_thickness':.7,'tip_to_flange':5.2,'bore':3.3},'fasteners':fasteners,'mesh_checks':reports,'intersections':checks,'physical_fit_tested':False}
(OUT/'checks.json').write_text(json.dumps(report,indent=2))
print(json.dumps(report),flush=True)
# Export world-space reference plus individually oriented printing parts.
for sub in ['assembly_meshes','STL']: (OUT/sub).mkdir(exist_ok=True)
def export(o,path,orient=False):
 o.data.calc_loop_triangles();rot=Matrix.Identity(3)
 if orient:
  if o==front:rot=Matrix.Rotation(-math.pi/2,3,'X')
  elif o==rear:rot=Matrix.Rotation(math.pi/2,3,'X')
  elif o in retainers:rot=Matrix.Rotation(math.pi/2,3,'X')
 v=[rot@(o.matrix_world@p.co) for p in o.data.vertices]
 if orient:
  lo=Vector([min(p[i] for p in v) for i in range(3)]);v=[p-lo for p in v]
 with path.open('wb') as f:
  f.write(b'Baymax 3mm LED head FIT PROTOTYPE - mm'.ljust(80,b' '));f.write(struct.pack('<I',len(o.data.loop_triangles)))
  for t in o.data.loop_triangles:
   a,b,c=[v[i] for i in t.vertices];n=(b-a).cross(c-a).normalized();f.write(struct.pack('<12fH',*n,*a,*b,*c,0))
for p in parts:
 export(p,OUT/'assembly_meshes'/(p.name+'.stl'));export(p,OUT/'STL'/(p.name+'.stl'),True)
for p in eyes:export(p,OUT/'assembly_meshes'/(p.name+'.stl'))
bpy.data.objects.remove(outer,do_unlink=True)
for o in bpy.data.objects:
 o.hide_render=o.name not in {p.name for p in parts+eyes}
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'Baymax_LED_head_3mm.blend'))
assert all(r['nonmanifold_edges']==0 and r['islands']==1 and r['volume_mm3']>0 for r in reports),'Mesh check failed'
assert all(c['intersection_mm3']<.01 for c in checks),'Component collision; inspect checks.json'
