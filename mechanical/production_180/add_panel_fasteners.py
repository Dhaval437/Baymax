"""Add accessible rear screws and internal standoffs to the approved sculpt shells.
Manufacturing draft: conventional M3/M2.5 screws; physical strength not validated.
"""
import bpy,bmesh,json,math,struct
from pathlib import Path
from mathutils import Vector,Matrix
from mathutils.bvhtree import BVHTree
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'panel_fasteners_v2';OUT.mkdir(exist_ok=True)
bpy.ops.wm.open_mainfile(filepath=str(ROOT/'Baymax_180_MECHANICAL_DEVELOPMENT.blend'))
scene=bpy.context.scene
collection=bpy.data.collections['MECHANICAL DEVELOPMENT - NOT FULL PRINT RELEASE']
def cylinder(name,x,y,z,r,depth):
 bpy.ops.mesh.primitive_cylinder_add(vertices=40,radius=r,depth=depth,location=(x,y,z),rotation=(math.pi/2,0,0))
 o=bpy.context.object;o.name=name
 bpy.ops.object.transform_apply(location=False,rotation=True,scale=True)
 for c in list(o.users_collection):c.objects.unlink(o)
 collection.objects.link(o);return o
def boolean(o,t,op='DIFFERENCE'):
 if op=='UNION':
  source_name=None
  if o.name.startswith('04_torso'):source_name='SOURCE - Torso'
  elif o.name.startswith('05_head'):source_name='SOURCE - Head'
  elif o.name.startswith('06_Left'):source_name='NEUTRAL - Left arm and hand'
  elif o.name.startswith('06_Right'):source_name='NEUTRAL - Right arm and hand'
  if source_name:
   original=bpy.data.objects[source_name]
   envelope=original.copy();envelope.data=original.data.copy();envelope.modifiers.clear()
   collection.objects.link(envelope);envelope.hide_viewport=False;envelope.hide_render=False
   envelope.location.z+=30
   boolean(t,envelope,'INTERSECT')
 bpy.context.view_layer.update();m=o.modifiers.new('Service fastener','BOOLEAN');m.operation=op;m.solver='MANIFOLD';m.object=t
 bpy.context.view_layer.objects.active=o;bpy.ops.object.modifier_apply(modifier=m.name);bpy.data.objects.remove(t,do_unlink=True)
def hit_y(obj,x,z,front):
 origin=Vector((x,-100 if front else 100,z));direction=Vector((0,1 if front else -1,0))
 bpy.context.view_layer.update()
 vertices=[obj.matrix_world@v.co for v in obj.data.vertices]
 tree=BVHTree.FromPolygons(vertices,[list(p.vertices) for p in obj.data.polygons])
 loc,normal,index,distance=tree.ray_cast(origin,direction)
 if loc is None:raise ValueError('No shell at proposed fastener '+obj.name+str((x,z)))
 return loc.y
bolts=[]
def join_pair(front,rear,points,seam,screw_diameter,boss_radius):
 for number,(x,z) in enumerate(points,1):
  yfront=hit_y(front,x,z,True);yback=hit_y(rear,x,z,False)
  end=seam-.15
  # Small overlap into exterior skin, never beyond the existing outer face.
  start=yfront+.8
  if end-start<1:raise ValueError('Insufficient front boss depth')
  boolean(front,cylinder('Front screw boss',x,(start+end)/2,z,boss_radius,end-start),'UNION')
  # Pilot intended for a screw tapped gently into printed plastic.
  engagement=min(10,end-start-.5)
  pilot_d=screw_diameter-.45
  boolean(front,cylinder('Blind pilot',x,end-engagement/2+.4,z,pilot_d/2,engagement+.8))
  rear_start=seam+.15;rear_end=yback-.8
  if rear_end>rear_start:
   boolean(rear,cylinder('Rear spacer',x,(rear_start+rear_end)/2,z,boss_radius,rear_end-rear_start),'UNION')
  if boss_radius>=3.3:
   # A short locating collar registers each panel around the screw post.
   locating_radius=2.5 if screw_diameter==3 else 2.15
   boolean(front,cylinder('Locating collar',x,end+.6,z,locating_radius,2.4),'UNION')
   boolean(front,cylinder('Collar pilot',x,end+1,z,pilot_d/2,4))
   boolean(rear,cylinder('Collar clearance pocket',x,end+1,z,locating_radius+.25,2.4))
  boolean(rear,cylinder('Screw clearance',x,(rear_start+yback)/2,z,(screw_diameter+.4)/2,yback-rear_start+4))
  # A shallow head seat; washer/head remains accessible from the back.
  boolean(rear,cylinder('Head recess',x,yback-.35,z,(screw_diameter+2.6)/2,1.4))
  desired_length=yback-end+engagement-.5
  lengths=[6,8,10,12,16,20,25,30,35,40]
  length=max([n for n in lengths if n<=desired_length],default=6)
  bolts.append({'pair':front.name.replace('_front_DRAFT',''),'x_mm':x,'z_mm':z,'thread':'M'+str(screw_diameter),
    'candidate_length_mm':length,'pilot_engagement_mm':length-(yback-end),
    'note':'Printed pilot; final screw/head dimensions and torque require assembly check.'})
  print('FASTENER',bolts[-1],flush=True)

cx=4.820418357849121
front=bpy.data.objects['04_torso_front_DRAFT'];rear=bpy.data.objects['04_torso_rear_DRAFT']
join_pair(front,rear,[(cx-27,78),(cx+27,78),(cx-15,145),(cx+15,145)],8,3,4)
join_pair(bpy.data.objects['05_head_front_DRAFT'],bpy.data.objects['05_head_rear_DRAFT'],[(-6,175),(6,175)],0,2.5,2.8)
for side in ['Left','Right']:
 front=bpy.data.objects['06_'+side+'_arm_and_hand_front_DRAFT'];rear=bpy.data.objects['06_'+side+'_arm_and_hand_rear_DRAFT']
 points=[]
 for z in [98,111]:
  verts=[front.matrix_world@v.co for v in front.data.vertices if abs((front.matrix_world@v.co).z-z)<1]
  if not verts:raise ValueError('Missing arm section')
  x=(min(v.x for v in verts)+max(v.x for v in verts))/2
  points.append((x,z))
 join_pair(front,rear,points,7.15,2.5,3.3)

reports=[]
objects=[o for o in collection.objects if o.type=='MESH' and o.name.endswith('_DRAFT')]
for o in objects:
 bm=bmesh.new();bm.from_mesh(o.data);bmesh.ops.triangulate(bm,faces=list(bm.faces))
 bmesh.ops.remove_doubles(bm,verts=list(bm.verts),dist=.001)
 bmesh.ops.dissolve_degenerate(bm,edges=list(bm.edges),dist=.0001)
 bad=[f for f in bm.faces if f.calc_area()<1e-9]
 if bad:bmesh.ops.delete(bm,geom=bad,context='FACES_ONLY')
 loose=[v for v in bm.verts if not v.link_faces]
 if loose:bmesh.ops.delete(bm,geom=loose,context='VERTS')
 boundary=[e for e in bm.edges if e.is_boundary]
 if boundary and len(boundary)<=20 and max(e.calc_length() for e in boundary)<.05:
  bmesh.ops.holes_fill(bm,edges=boundary,sides=6)
  bmesh.ops.recalc_face_normals(bm,faces=list(bm.faces))
 print('MESH',o.name,[(len(e.link_faces),round(e.calc_length(),6)) for e in bm.edges if not e.is_manifold][:15],flush=True)
 report={'name':o.name,'nonmanifold_edges':sum(not e.is_manifold for e in bm.edges),'volume_mm3':bm.calc_volume(signed=True)}
 reports.append(report);bm.to_mesh(o.data);bm.free();o.data.update()
 if report['nonmanifold_edges'] or report['volume_mm3']<=0:continue
 o.data.calc_loop_triangles();rot=Matrix.Identity(3)
 if '_front_DRAFT' in o.name:rot=Matrix.Rotation(-math.pi/2,3,'X')
 elif '_rear_DRAFT' in o.name:rot=Matrix.Rotation(math.pi/2,3,'X')
 verts=[rot@(o.matrix_world@v.co) for v in o.data.vertices];low=[min(v[i] for v in verts) for i in range(3)]
 for v in verts:v.z-=low[2]
 with (OUT/(o.name+'.stl')).open('wb') as f:
  f.write(b'Development V2 with service screw bosses mm'.ljust(80,b' '));f.write(struct.pack('<I',len(o.data.loop_triangles)))
  for t in o.data.loop_triangles:
   v=[verts[i] for i in t.vertices];normal=(v[1]-v[0]).cross(v[2]-v[0]).normalized()
   f.write(struct.pack('<12fH',*normal,*v[0],*v[1],*v[2],0))
(OUT/'panel_fastener_report.json').write_text(json.dumps({'fasteners':bolts,'mesh_checks':reports,'status':'Panel fastening development. Servo joints, component collision and physical fit still unverified.'},indent=2))
assert all(r['nonmanifold_edges']==0 and r['volume_mm3']>0 for r in reports)
scene['STATUS']='V2 internal rear-access screw bosses; motor joint integration incomplete.'
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'Baymax_180_SERVICE_PANELS_V2.blend'))
print('SAVED SERVICE PANELS',len(reports),flush=True)
