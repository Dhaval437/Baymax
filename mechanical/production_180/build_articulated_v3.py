"""Articulated prototype geometry. No print release without the generated checks."""
import bpy,bmesh,math,json,struct
from pathlib import Path
from mathutils import Vector,Matrix
ROOT=Path(__file__).resolve().parent
OUT=ROOT/'articulated_v3';OUT.mkdir(exist_ok=True)
bpy.ops.wm.open_mainfile(filepath=str(ROOT/'panel_fasteners_v2/Baymax_180_SERVICE_PANELS_V2.blend'))
COL=bpy.data.collections['MECHANICAL DEVELOPMENT - NOT FULL PRINT RELEASE']
CX=4.820418357849121
parts=[o for o in COL.objects if o.type=='MESH' and o.name.endswith('_DRAFT')]
def move(o):
 for c in list(o.users_collection):c.objects.unlink(o)
 COL.objects.link(o);return o
def cube(name,p,d):
 bpy.ops.object.select_all(action='DESELECT');bpy.ops.mesh.primitive_cube_add(size=1,location=p)
 o=bpy.context.object;o.name=name;o.dimensions=d;bpy.ops.object.transform_apply(location=False,rotation=False,scale=True);return move(o)
def cyl(name,p,r,h,axis='Z'):
 bpy.ops.object.select_all(action='DESELECT');bpy.ops.mesh.primitive_cylinder_add(vertices=64,radius=r,depth=h,location=p)
 o=bpy.context.object;o.name=name
 if axis=='X':o.rotation_euler.y=math.pi/2
 if axis=='Y':o.rotation_euler.x=math.pi/2
 bpy.ops.object.transform_apply(location=False,rotation=True,scale=True);return move(o)
def copy(o,name):
 n=o.copy();n.data=o.data.copy();n.modifiers.clear();COL.objects.link(n);n.hide_viewport=False;n.hide_render=False;n.name=name;return n
def cut(o,t,op='DIFFERENCE'):
 bpy.context.view_layer.update();m=o.modifiers.new('Joint geometry','BOOLEAN');m.operation=op;m.solver='MANIFOLD';m.object=t
 bpy.context.view_layer.objects.active=o;bpy.ops.object.modifier_apply(modifier=m.name);bpy.data.objects.remove(t,do_unlink=True)
def union(o,t):cut(o,t,'UNION')
def clean(o):
 bm=bmesh.new();bm.from_mesh(o.data);bmesh.ops.triangulate(bm,faces=list(bm.faces))
 raw_bad=sum(not e.is_manifold for e in bm.edges)
 bmesh.ops.remove_doubles(bm,verts=list(bm.verts),dist=.001)
 bmesh.ops.dissolve_degenerate(bm,edges=list(bm.edges),dist=.0001)
 loose=[v for v in bm.verts if not v.link_faces]
 if loose:bmesh.ops.delete(bm,geom=loose,context='VERTS')
 # A closed manifold Boolean result can contain legitimate sub-micron edges.
 # Never replace it with a cleanup that creates holes or nonmanifold junctions.
 if raw_bad==0 and any(not e.is_manifold for e in bm.edges):
  bm.free();bm=bmesh.new();bm.from_mesh(o.data)
  bmesh.ops.triangulate(bm,faces=list(bm.faces))
 seen=set();islands=[]
 for v in bm.verts:
  if v in seen:continue
  todo=[v];seen.add(v);count=0
  while todo:
   current=todo.pop();count+=1
   for e in current.link_edges:
    other=e.other_vert(current)
    if other not in seen:seen.add(other);todo.append(other)
  islands.append(count)
 result={'name':o.name,'nonmanifold_edges':sum(not e.is_manifold for e in bm.edges),'volume_mm3':bm.calc_volume(signed=True),'connected_mesh_islands':len(islands),'island_vertices':sorted(islands,reverse=True)}
 if result['nonmanifold_edges']:print('BAD EDGES',o.name,'raw',raw_bad,[(len(e.link_faces),round(e.calc_length(),6),[tuple(v.co) for v in e.verts]) for e in bm.edges if not e.is_manifold][:12],flush=True)
 bm.to_mesh(o.data);bm.free();o.data.update();return result
front=bpy.data.objects['04_torso_front_DRAFT'];rear=bpy.data.objects['04_torso_rear_DRAFT']
def split_tool(o,plane,is_front):
 cut(o,cube('Partition',(CX,plane+(-150 if is_front else 150),100),(400,300,400)),'INTERSECT')
def original(name):
 o=copy(bpy.data.objects[name],'Original envelope tool');o.location.z+=30;bpy.context.view_layer.update();return o
def moving_region(sign,clear=0):
 region=cube('Lower arm region',(CX+sign*30,0,28+clear/2),(100,100,200+clear))
 union(region,cyl('Round arm joint',(CX+sign*30,4.2,128),11+clear,100,'X'))
 return region

for side,sign in [('Left',-1),('Right',1)]:
 print('BUILD ARM',side,flush=True)
 arm_f=bpy.data.objects['06_'+side+'_arm_and_hand_front_DRAFT']
 arm_r=bpy.data.objects['06_'+side+'_arm_and_hand_rear_DRAFT']
 for arm in [arm_f,arm_r]:cut(arm,moving_region(sign),'INTERSECT')
 # Preserve the rounded upper shoulder as fixed body geometry.
 cap=original('NEUTRAL - '+side+' arm and hand');cut(cap,moving_region(sign,.6))
 cap_f=copy(cap,'Fixed shoulder front');cap_r=copy(cap,'Fixed shoulder rear');bpy.data.objects.remove(cap,do_unlink=True)
 split_tool(cap_f,7.85,True);split_tool(cap_r,8.15,False)
 # Buried bridges connect the cap to the torso instead of relying on touching meshes.
 for target,cap_part,is_front in [(front,cap_f,True),(rear,cap_r,False)]:
  bridge=cube('Shoulder bridge',(CX+sign*25,4,147),(14,18,8));split_tool(bridge,7.85 if is_front else 8.15,is_front)
  envelope=original('SOURCE - Torso');union(envelope,original('NEUTRAL - '+side+' arm and hand'))
  cut(bridge,envelope,'INTERSECT')
  union(target,bridge);union(target,cap_part)
 # Bearing sleeve supports the rotating arm hub, coaxial with the servo output.
 sleeve=cyl('Fixed arm bearing',(CX+sign*27,4.2,128),11.5,3,'X')
 cut(sleeve,cyl('Arm bearing clearance',(CX+sign*27,4.2,128),9.3,9,'X'))
 sleeve_f=copy(sleeve,'Bearing front');sleeve_r=copy(sleeve,'Bearing rear');bpy.data.objects.remove(sleeve,do_unlink=True)
 split_tool(sleeve_f,7.85,True);split_tool(sleeve_r,8.15,False)
 for target,segment in [(front,sleeve_f),(rear,sleeve_r)]:
  # Open a full circular seat before adding its accurately sized bearing wall.
  cut(target,cyl('Arm rotating clearance',(CX+sign*29,4.2,128),9.3,14,'X'));union(target,segment)
 # Hub and horn pocket split with the two removable arm panels.
 hub=cyl('Rotating arm hub',(CX+sign*30,4.2,128),9,7,'X')
 # The supplied plastic horn seats in an open rectangular relief. No printed spline.
 cut(hub,cube('Stock horn relief',(CX+sign*30,4.2,121.5),(6,7.5,22)))
 cut(hub,cyl('Horn screw access',(CX+sign*30,4.2,128),3.5,20,'X'))
 hub_f=copy(hub,'Hub front');hub_r=copy(hub,'Hub rear');bpy.data.objects.remove(hub,do_unlink=True)
 split_tool(hub_f,7,True);split_tool(hub_r,7.3,False)
 for arm,h in [(arm_f,hub_f),(arm_r,hub_r)]:
  union(arm,h)
  cut(arm,cube('Stock horn insertion',(CX+sign*30,4.2,121.5),(6,7.5,22)))
  cut(arm,cyl('Accessible shaft screw',(CX+sign*35,4.2,128),3.5,28,'X'))
 # Clamp the supplied horn mechanically instead of relying on glue or a printed spline.
 for arm,y in [(arm_f,-1.8),(arm_r,10.2)]:
  boss=cyl('Horn clamp boss',(CX+sign*36.5,y,118),3,7,'X')
  cut(boss,original('NEUTRAL - '+side+' arm and hand'),'INTERSECT');union(arm,boss)
  cut(arm,cyl('Horn clamp screw pilot',(CX+sign*36,y,118),1.025,7,'X'))
 clamp=cube('07_'+side+'_horn_clamp_DRAFT',(CX+sign*30,4.2,121.5),(1.5,18,22))
 cut(clamp,cyl('Servo spline access',(CX+sign*30,4.2,128),3.5,6,'X'))
 for y in [-1.8,10.2]:cut(clamp,cyl('Clamp bolt clearance',(CX+sign*30,y,118),1.45,6,'X'))
 parts.append(clamp)
 # Compact cradle: tied at the outer end, with open wire exit and exposed tabs.
 cradle=cube('Servo cradle '+side,(CX+sign*13,-1,120.75),(16,26.4,2))
 for y in [-13.45,11.45]:union(cradle,cube('Servo side stop',(CX+sign*13,y,127.75),(16,1.5,12)))
 for y in [-10,8]:cut(cradle,cube('Servo tie slot',(CX+sign*18,y,120.75),(3,3,6)))
 # Rear insertion with the torso open. Cradle is anchored to the front body.
 web=cube('Cradle anchor',(CX+sign*13,-23,120.75),(12,24,2))
 cut(web,original('SOURCE - Torso'),'INTERSECT')
 union(cradle,web);union(front,cradle)

# Neck motor cradle and coaxial bearing; the head remains an independent assembly.
print('BUILD NECK',flush=True)
neck_base=cube('Neck servo platform',(3,4,135.1),(25,26.4,2))
for x in [-4.75,10.75]:union(neck_base,cube('Neck side stop',(x,4,141.6),(1.5,26.4,12)))
for x in [-2,8]:cut(neck_base,cube('Neck strap slot',(x,4,135.1),(3,3,6)))
neck_anchor=cube('Neck front anchor',(3,-20,135.1),(12,24,2));cut(neck_anchor,original('SOURCE - Torso'),'INTERSECT')
union(neck_base,neck_anchor)
union(front,neck_base)
for target in [front,rear]:cut(target,cyl('Neck opening',(3,-1.2,166),4.5,22))
# The light hollow head is carried by the servo's own output bearing.
# Avoid an additional printed bearing that could bind from small axial errors.
# Separate replaceable head carrier accepts the supplied horn and exposes its centre screw.
carrier=cyl('07_head_carrier_DRAFT',(3,-1.2,166),10,2)
cut(carrier,original('SOURCE - Head'),'INTERSECT')
cut(carrier,cube('Head horn recess',(3,1.3,164),(7.5,22,3)))
cut(carrier,cyl('Head horn retaining access',(3,-1.2,166),2.8,10))
for x in [-2.5,8.5]:cut(carrier,cyl('Head carrier fixing',(x,-1.2,166),1.35,10))
parts.append(carrier)
head_clamp=cyl('07_head_horn_clamp_DRAFT',(3,-1.2,162.75),10,1.5)
cut(head_clamp,original('SOURCE - Head'),'INTERSECT')
cut(head_clamp,cyl('Head spline opening',(3,-1.2,162.75),3.5,6))
for x in [-2.5,8.5]:
 cut(head_clamp,cyl('Head clamp screw',(x,-1.2,162.75),1.45,6))
 bpy.ops.mesh.primitive_cone_add(vertices=40,radius1=2.5,radius2=1.45,depth=1.2,location=(x,-1.2,162.6))
 cut(head_clamp,move(bpy.context.object))
parts.append(head_clamp)

# Head carrier screws into blind printed bosses under the head roof.
head_f=bpy.data.objects['05_head_front_DRAFT'];head_r=bpy.data.objects['05_head_rear_DRAFT']
for x in [-2.5,8.5]:
 boss=cyl('Head carrier boss',(x,-1.2,172.6),3,11.2)
 cut(boss,original('SOURCE - Head'),'INTERSECT');union(head_f,boss)
 cut(head_f,cyl('Head attachment pilot',(x,-1.2,170.9),1.025,8.2))
for h in [head_f,head_r]:cut(h,cyl('Head carrier seat',(3,-1.2,165.9),10.2,2.2))
cut(head_f,cyl('Servo screw service access',(3,-1.2,175),2.5,30))

# The speaker rests against a rear retaining rim; ties hold its basket, not its cone.
print('BUILD SPEAKER AND BASE',flush=True)
speaker_ring=cyl('Speaker retaining seat',(CX,18,92),28,3,'Y')
cut(speaker_ring,cyl('Speaker open face',(CX,18,92),25.5,9,'Y'))
for x,z in [(CX-20,92),(CX+20,92),(CX,72),(CX,112)]:
 post=cyl('Speaker support',(x,28,z),3,23,'Y')
 cut(post,original('SOURCE - Torso'),'INTERSECT');union(speaker_ring,post)
for sign in [-1,1]:
 ear=cube('Speaker strap ear',(CX+sign*27,18,92),(5,6,10))
 cut(ear,cube('Speaker strap slot',(CX+sign*27,18,92),(3,10,4)));union(speaker_ring,ear)
union(rear,speaker_ring)
# Low-profile base mounts; remove old central rails while retaining the outer lid rim.
lid=bpy.data.objects['02_base_bottom_DRAFT']
cut(lid,cube('Remove old rails',(CX,0,11.5),(76,40,18)))
for y in [-29.5,-.5]:
 rail=cube('ESP32 edge rail',(CX,y,3.9),(68,3,3))
 for x in [CX-24,CX+24]:cut(rail,cube('Board tie slot',(x,y,4.2),(3,7,1.2)))
 union(lid,rail)
for x in [CX-22,CX+22]:
 rail=cube('Distribution board rail',(x,19,3.9),(3,32,3))
 cut(rail,cube('Distribution strap slot',(x,19,4.2),(7,3,1.2)));union(lid,rail)
for y in [6,24]:union(lid,cube('Amplifier rail',(CX+35,y,3.9),(20,2,3)))

# A generic adhesive microphone pad permits port alignment when the actual module arrives.
pad=cube('Microphone flat mounting pad',(0,-29,135),(20,12,20));cut(pad,original('SOURCE - Torso'),'INTERSECT')
cut(pad,cyl('Microphone acoustic passage',(0,-29,135),1.5,30,'Y'));union(front,pad)
cut(front,cyl('Microphone acoustic passage',(0,-29,135),1.5,30,'Y'))

# Replaceable cable-entry plate slides out when the base lid is removed.
base=bpy.data.objects['01_base_box_DRAFT']
cut(base,cube('Power entry open slot',(CX,41,13.7),(14,10,22.6)))
cut(base,cube('Power insert guides',(CX,40.5,14.7),(18.6,2.4,24.6)))
power_insert=cube('08_power_entry_insert_DRAFT',(CX,40.5,14.4),(18,2,24))
cut(power_insert,cyl('Low voltage cable',(CX,40.5,15),4,6,'Y'))
for x in [CX-6,CX+6]:cut(power_insert,cube('Cable tie retention',(x,40.5,15),(2.2,6,5)))
parts.append(power_insert)

# Front talk-button opening and an adjustable removable switch bracket.
# Designed around a 6 x 6 x 5 mm tactile switch; the actual switch still needs identification.
cut(base,cyl('Talk button guide',(CX,-41,19),2,10,'Y'))
button_bracket=cube('09_button_bracket_DRAFT',(CX,-33,19),(14,2,14))
for sign in [-1,1]:
 union(button_bracket,cube('Switch side',(CX+sign*4,-35,19),(1.5,4,8)))
 union(button_bracket,cube('Bracket foot',(CX+sign*6,-32,8.2),(2,10,11.6)))
 cut(button_bracket,cube('Adjustment slot',(CX+sign*6,-32,4),(1.2,5,4)))
parts.append(button_bracket)
button=cyl('10_talk_button_DRAFT',(CX,-43.75,19),4,1.5,'Y')
union(button,cyl('Button stem',(CX,-40.5,19),1.75,6,'Y'));parts.append(button)
retainer=cyl('11_button_retainer_DRAFT',(CX,-38.7,19),3.2,1,'Y')
cut(retainer,cyl('Retainer stem fit',(CX,-38.7,19),1.85,4,'Y'));parts.append(retainer)

# Cosmetic originals are retained as independent printable inserts.
for o in list(COL.objects):
 if o.type=='MESH' and (o.name.startswith('Face marking') or o.name=='Chest badge'):
  o.name='12_'+o.name.replace(' ','_')+'_DRAFT';parts.append(o)

# Trim the hidden upper legs and provide accessible torso-to-leg screws.
for leg in [o for o in parts if o.name.startswith('03_Leg')]:
 vertices=[leg.matrix_world@v.co for v in leg.data.vertices]
 fx=(min(v.x for v in vertices)+max(v.x for v in vertices))/2
 trim=original('SOURCE - Torso')
 cut(trim,cube('Leg hidden top trim',(fx,0,165),(70,80,200)),'INTERSECT')
 cut(leg,trim)
 socket=copy(leg,'Torso leg socket');bpy.context.view_layer.update()
 for v in socket.data.vertices:
  v.co.x=fx+(v.co.x-fx)*1.018;v.co.y*=1.018
 for target in [front,rear]:cut(target,copy(socket,'Socket clearance'))
 bpy.data.objects.remove(socket,do_unlink=True)
 bridge=cube('Leg attachment bridge',(fx,-4,66.5),(14,32,3))
 cut(bridge,original('SOURCE - Torso'),'INTERSECT');union(front,bridge)
 cut(front,cyl('Leg bolt clearance',(fx,9,66.5),1.7,8))
 cut(front,cyl('Leg wire passage',(fx,-2,65),4,12))
 # Legs are bonded into the keyed torso seats; the base remains screw-removable.
# Maintain space around the speaker at the new lower attachment bridges.
cut(front,cyl('Speaker installation clearance',(CX,3,92),26.5,28,'Y'))

# Button bracket feet use two captive M2 nuts in sliding pockets.
cut(button_bracket,cube('Remove temporary bracket legs',(CX,-32,7),(25,14,10)))
for sign in [-1,1]:
 foot=cube('Button mounting foot',(CX+sign*8,-31,3.9),(7,12,3))
 cut(foot,cube('Sliding M2 nut pocket',(CX+sign*8,-29,4.6),(4.2,7.2,2.2)))
 cut(foot,cube('M2 bolt travel',(CX+sign*8,-29,3.9),(2.2,5.2,7)))
 union(button_bracket,foot)
 union(button_bracket,cube('Button vertical support',(CX+sign*8,-34,9.5),(4,4,13)))
 cut(lid,cyl('Button bracket M2 bolt',(CX+sign*8,-27,2),1.1,7))

# Switch mounting face at Y=-32 gives 0.2 mm nominal actuator clearance
# for a 5.3 mm total-height tactile switch, with sliding adjustment available.
button_bracket.location.y+=2

exec((ROOT/'rebuild_head_v3.py').read_text())
exec((ROOT/'joint_relief_v3.py').read_text())
exec((ROOT/'finishing_features_v3.py').read_text())
reports=[clean(o) for o in parts]
report={'status':'Engineering prototype under validation; NOT PRINT RELEASED','parts':reports,
 'unverified':['Tab and horn clearances','Mount attachment continuity','Body and arm motion sweep','Head attachment and rotation','Speaker and button retainers','Base wiring and power entry','Slicer review']}
(OUT/'geometry_report.json').write_text(json.dumps(report,indent=2))
bpy.context.scene['STATUS']=report['status']
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
print(json.dumps(report),flush=True)
