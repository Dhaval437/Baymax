"""Mechanical development set. Dimensions mm. Full robot release is on HOLD.
Only small dimensional coupons are released for fit testing, never motor operation.
"""
import bpy,bmesh,math,json,struct
from pathlib import Path
from mathutils import Vector,Matrix
ROOT=Path(__file__).resolve().parent
for d in ['draft_stl','fit_tests']: (ROOT/d).mkdir(exist_ok=True)
bpy.ops.wm.open_mainfile(filepath=str(ROOT.parent/'reference_model/Baymax_ARMS_DOWN_STRAIGHT_HEAD_150mm.blend'))
scene=bpy.context.scene
draft=bpy.data.collections.new('MECHANICAL DEVELOPMENT - NOT FULL PRINT RELEASE');scene.collection.children.link(draft)
source=bpy.data.collections.new('PRESERVED SCULPT');scene.collection.children.link(source)
source.hide_render=True;source.hide_viewport=True
fit=bpy.data.collections.new('FIT TEST COUPONS - exported separately');scene.collection.children.link(fit)
fit.hide_render=True;fit.hide_viewport=True
def move(o,col):
    for c in list(o.users_collection):c.objects.unlink(o)
    col.objects.link(o);return o
def apply(o,m):
    bpy.context.view_layer.objects.active=o;bpy.ops.object.modifier_apply(modifier=m.name)
def clone(o,name):
    n=o.copy();n.data=o.data.copy();draft.objects.link(n);n.name=name
    n.modifiers.clear()
    return n
def cube(name,loc,dims,col=draft):
    bpy.ops.mesh.primitive_cube_add(size=1,location=loc);o=bpy.context.object;o.name=name;o.dimensions=dims
    bpy.ops.object.transform_apply(location=False,rotation=False,scale=True);return move(o,col)
def cyl(name,loc,r,depth,axis='Z',vertices=48):
    bpy.ops.mesh.primitive_cylinder_add(vertices=vertices,radius=r,depth=depth,location=loc)
    o=bpy.context.object;o.name=name
    if axis=='Y':o.rotation_euler.x=math.pi/2
    if axis=='X':o.rotation_euler.y=math.pi/2
    bpy.ops.object.transform_apply(location=False,rotation=True,scale=True);return move(o,draft)
def boolean(o,tool,op='DIFFERENCE'):
    bpy.context.view_layer.update()
    m=o.modifiers.new('Mechanical cut','BOOLEAN');m.operation=op;m.solver='EXACT';m.object=tool
    apply(o,m);bpy.data.objects.remove(tool,do_unlink=True)
def bevel(o,amount):
    m=o.modifiers.new('Rounded edges','BEVEL');m.width=amount;m.segments=4;apply(o,m)
def world_bake(o):
    bpy.context.view_layer.update()
    matrix=o.matrix_world.copy()
    for v in o.data.vertices:v.co=matrix @ v.co
    o.matrix_world=Matrix.Identity(4);o.data.update();bpy.context.view_layer.update()
def inset(o,d,name):
    n=clone(o,name);world_bake(n)
    lo,hi=bounds(n);mid=Vector(tuple((a+b)/2 for a,b in zip(lo,hi)))
    # Stable nested sculpt copy for development cavities. This is NOT a uniform
    # wall offset: measured minimum-wall checks are required before release.
    factors=[max(.2,1-2*d/(hi[i]-lo[i])) for i in range(3)]
    for v in n.data.vertices:
        delta=v.co-mid;v.co=mid+Vector(tuple(delta[i]*factors[i] for i in range(3)))
    n.data.update();return n
def bounds(o):
    p=[o.matrix_world@v.co for v in o.data.vertices]
    return [min(v[i] for v in p) for i in range(3)],[max(v[i] for v in p) for i in range(3)]

originals=[o for o in list(scene.objects) if o.type=='MESH' and (o.name.startswith('SOURCE -') or o.name.startswith('NEUTRAL -')) and not o.hide_render]
work={}
for o in originals:
    if 'Display plinth' in o.name:move(o,source);continue
    n=clone(o,o.name.replace('SOURCE - ','').replace('NEUTRAL - ',''));n.location.z+=30;world_bake(n)
    work[n.name]=n;move(o,source)
white=bpy.data.materials['Original white sculpt'];dark=bpy.data.materials['Original black details and plinth']
CX=4.820418357849121;BASE_H=35.67171096801758
parts=[]
# Accessible bottom-opening base with nested alignment rim.
base=cube('01_base_box_DRAFT',(CX,0,(BASE_H+2.4)/2),(100,85,BASE_H-2.4));bevel(base,2)
boolean(base,cube('Base cavity',(CX,0,(BASE_H-3-2)/2),(94,79,BASE_H-3+2)))
lid=cube('02_base_bottom_DRAFT',(CX,0,1.2),(100,85,2.4));bevel(lid,.7)
rim=cube('Lid alignment tongue',(CX,0,3.7),(93.4,78.4,2.6))
boolean(rim,cube('Rim hollow',(CX,0,3.7),(90.2,75.2,5)))
boolean(lid,rim,'UNION')
# M3 captive-nut candidates, tested first with separate nut coupon.
for x in [CX-43,CX+43]:
    for y in [-35,35]:
        boss=cyl('Base screw column',(x,y,10.175),4.8,15.65)
        boolean(base,boss,'UNION')
        boolean(base,cyl('M3 clearance',(x,y,8),1.7,18))
        boolean(base,cyl('M3 hex pocket',(x,y,10),3.4,3,vertices=6))
        direction=-1 if x>CX else 1
        boolean(base,cube('Nut insertion slot',(x+direction*4,y,10),(8,5.9,3)))
        boolean(lid,cyl('Lid screw clearance',(x,y,2),1.7,8))
        boolean(lid,cyl('Screw head recess',(x,y,.7),3.1,1.5))
        boolean(lid,cyl('Tongue relief around screw column',(x,y,5.1),5.1,5.8))
# Cable entry plus holes for a reusable tie. Entry remains provisional until cable selected.
boolean(base,cyl('Rear power entry',(CX,41,15),4,12,axis='Y'))
for x in [CX-7,CX+7]:boolean(base,cube('Strain relief tie slot',(x,41,15),(2.2,12,5)))
# Board rests on two rails. Slots support straps without assuming PCB hole positions.
for y in [-12,12]:
    rail=cube('Board support rail',(CX-4,y,5.5),(70,5,7))
    for x in [CX-33,CX+25]:boolean(rail,cube('Board strap slot',(x,y,5.5),(2.5,8,2)))
    boolean(lid,rail,'UNION')
# Feet seats use the actual original soles. Wiring goes through both feet.
feet=[o for k,o in work.items() if k.startswith('Leg ')]
for leg in feet:
    low,high=bounds(leg);fx=(low[0]+high[0])/2
    socket=clone(leg,'Foot socket tool')
    # Expand around the foot's own centre by 0.25 mm on each side for clearance.
    mid=Vector(((low[0]+high[0])/2,(low[1]+high[1])/2,(low[2]+high[2])/2))
    for v in socket.data.vertices:
        d=v.co-mid;v.co=mid+Vector((d.x*(1+.5/(high[0]-low[0])),d.y*(1+.5/(high[1]-low[1])),d.z))
    boolean(base,socket)
    for target in [base,leg]:boolean(target,cyl('Internal wire passage',(fx,-2,65),4,90))
    boolean(leg,cyl('Foot screw pilot',(fx,9,35),1.35,10))
    boolean(base,cyl('Foot screw access',(fx,9,33),1.7,12))
    leg.name='03_'+leg.name.replace(' ','_')+'_DRAFT';parts.append(leg)
parts.extend([base,lid])
for o in [base,lid]:o.data.materials.append(dark)

def shell_split(obj,prefix,wall,plane,tongue=False):
    # Offset cavity preserves exterior. Physical wall checks still required on organic mesh.
    outer_copy=clone(obj,'Outer reference for lip')
    boolean(obj,inset(outer_copy,wall,'Inner cavity'))
    rear=clone(obj,prefix+'_rear_DRAFT');obj.name=prefix+'_front_DRAFT'
    boolean(obj,cube('Front partition',(CX,plane-150-.15,100),(400,300,400)),'INTERSECT')
    boolean(rear,cube('Rear partition',(CX,plane+150+.15,100),(400,300,400)),'INTERSECT')
    if tongue:
        lip=inset(outer_copy,wall+.3,'Alignment lip')
        boolean(lip,inset(outer_copy,wall+1.6,'Lip cavity'))
        boolean(lip,cube('Lip width',(CX,plane,100),(400,5,400)),'INTERSECT')
        bridge=inset(outer_copy,wall-.7,'Lip root')
        boolean(bridge,inset(outer_copy,wall+1.6,'Root cavity'))
        boolean(bridge,cube('Root width',(CX,plane+2,100),(400,1.5,400)),'INTERSECT')
        boolean(rear,bridge,'UNION');boolean(rear,lip,'UNION')
    bpy.data.objects.remove(outer_copy,do_unlink=True)
    return [obj,rear]

torso=work['Torso'];torso_parts=shell_split(torso,'04_torso',2.4,8)
for target in torso_parts:
    boolean(target,cyl('Neck wire and shaft route',(CX,0,164),4.5,24))
    for leg in feet:
        lo,hi=bounds(leg);boolean(target,cyl('Leg wire connection',((lo[0]+hi[0])/2,-2,61),4.5,35))
# Rear grille: narrow slots rather than a large visible cutout.
for x in [CX-15,CX-10,CX-5,CX,CX+5,CX+10,CX+15]:
    boolean(torso_parts[1],cube('Rear speaker grille',(x,33,103),(1.6,30,26)))
parts+=torso_parts
head=work['Head'];head_parts=shell_split(head,'05_head',1.6,0)
for target in head_parts:boolean(target,cyl('Neck access',(0,0,161),4.5,15))
parts+=head_parts
for name in ['Left arm and hand','Right arm and hand']:
    arm=work[name]
    sign=-1 if name.startswith('Left') else 1
    bpy.ops.mesh.primitive_uv_sphere_add(segments=40,ring_count=28,location=(CX+sign*29,4,121))
    inner=move(bpy.context.object,draft);inner.scale=(5.5,7,24);inner.rotation_euler.y=-sign*.18
    bpy.ops.object.transform_apply(location=False,rotation=True,scale=True)
    boolean(arm,inner)
    rear=clone(arm,'06_'+name.replace(' ','_')+'_rear_DRAFT')
    arm.name='06_'+name.replace(' ','_')+'_front_DRAFT'
    boolean(arm,cube('Arm front',(CX,-143,100),(400,300,400)),'INTERSECT')
    boolean(rear,cube('Arm rear',(CX,157.3,100),(400,300,400)),'INTERSECT')
    parts.extend([arm,rear])

# Small independent fit samples, not final assemblies.
coupons=[]
for i,clearance in enumerate([.2,.3,.4],1):
    female=cube(f'fit_lip_{i}_socket',(0,0,2),(24,18,4))
    boolean(female,cube('Fit groove',(0,0,3),(18+2*clearance,12+2*clearance,4)))
    # An edge notch count identifies the trial without requiring tiny text.
    for n in range(i):boolean(female,cube('ID notch',(-7+3*n,-9,2),(1.2,2,6)))
    coupons.append(female)
male=cube('fit_lip_male',(0,0,1),(24,18,2))
boolean(male,cube('Male test tongue',(0,0,3),(18,12,2)),'UNION');coupons.append(male)
nut=cube('fit_M3_nut_and_screw',(0,0,3),(20,14,6))
for x,r in [(-5,3.3),(5,3.4)]:
    boolean(nut,cyl('Hex test',(x,0,4.8),r,3,vertices=6))
    boolean(nut,cyl('M3 hole',(x,0,2),1.7,8))
coupons.append(nut)
# Speaker diameter is known, but the mounting rim must be checked physically.
ring=cyl('fit_speaker_D52_clearance',(0,0,1),28,2)
boolean(ring,cyl('Speaker trial aperture',(0,0,1),26.4,5));coupons.append(ring)

def check(obj):
    if not len(obj.data.vertices):
        return {'name':obj.name,'error':'EMPTY MESH - BOOLEAN FAILED','nonmanifold_edges':-1,'volume_mm3':0}
    bm=bmesh.new();bm.from_mesh(obj.data)
    report={'name':obj.name,'nonmanifold_edges':sum(not e.is_manifold for e in bm.edges),'volume_mm3':bm.calc_volume(signed=True),'faces':len(bm.faces)}
    bm.free();lo,hi=bounds(obj);report['dimensions_mm']=[b-a for a,b in zip(lo,hi)];return report
def stl(obj,folder,orient=False):
    mesh=obj.data;mesh.calc_loop_triangles();verts=[obj.matrix_world@v.co for v in mesh.vertices]
    # Development parts are placed on bed, with split planes facing down where applicable.
    rot=Matrix.Identity(3)
    if orient and ('front_DRAFT' in obj.name):rot=Matrix.Rotation(-math.pi/2,3,'X')
    elif orient and ('rear_DRAFT' in obj.name):rot=Matrix.Rotation(math.pi/2,3,'X')
    elif orient and obj==base:rot=Matrix.Rotation(math.pi,3,'X')
    verts=[rot@v for v in verts]
    lo=Vector(tuple(min(v[i] for v in verts) for i in range(3)))
    hi=Vector(tuple(max(v[i] for v in verts) for i in range(3)))
    shift=Vector(((lo.x+hi.x)/2,(lo.y+hi.y)/2,lo.z));verts=[v-shift for v in verts]
    with (ROOT/folder/(obj.name+'.stl')).open('wb') as f:
        f.write(b'Baymax development mm; read PRINT_STATUS.md'.ljust(80,b' '));f.write(struct.pack('<I',len(mesh.loop_triangles)))
        for t in mesh.loop_triangles:
            v=[verts[i] for i in t.vertices];n=(v[1]-v[0]).cross(v[2]-v[0]).normalized()
            f.write(struct.pack('<12fH',*n,*v[0],*v[1],*v[2],0))

def clean(o):
    bm=bmesh.new();bm.from_mesh(o.data)
    bmesh.ops.triangulate(bm,faces=list(bm.faces))
    bmesh.ops.remove_doubles(bm,verts=list(bm.verts),dist=.00001)
    bmesh.ops.dissolve_degenerate(bm,edges=list(bm.edges),dist=.000001)
    bad=[f for f in bm.faces if f.calc_area()<1e-9]
    if bad:bmesh.ops.delete(bm,geom=bad,context='FACES_ONLY')
    loose=[v for v in bm.verts if not v.link_faces]
    if loose:bmesh.ops.delete(bm,geom=loose,context='VERTS')
    bm.to_mesh(o.data);bm.free();o.data.update()
for o in parts+coupons:clean(o)
reports=[check(o) for o in parts]
tests=[check(o) for o in coupons]
for obj in parts:
    if len(obj.data.vertices):stl(obj,'draft_stl',True)
for obj in coupons:
    stl(obj,'fit_tests');move(obj,fit)
report={'status':'Mechanical development; joints incomplete. Fit samples optional by user direction.', 'height_target_mm':180,'base_height_mm':BASE_H,
 'parts':reports,'fit_tests':tests,'unresolved':['Two additional servo dimensions unconfirmed','M3 hardware ownership unconfirmed',
 'Shoulder load-bearing supports and horn attachments not designed','Head bearing and servo mount not designed','Torso/head/arm mechanical fasteners not designed',
 'Microphone and amplifier dimensions pending arrival','Power cable and clamp sizing pending','Shell offset self-intersection and minimum-wall inspection required',
 'Speaker retaining bracket and chest button mount pending','Full motion sweep and slicer review required']}
points=[o.matrix_world@v.co for o in parts for v in o.data.vertices]
report['measured_assembly_height_mm']=max(v.z for v in points)-min(v.z for v in points)
assert abs(report['measured_assembly_height_mm']-180)<.01
(ROOT/'mechanical_report.json').write_text(json.dumps(report,indent=2))
assert all(r.get('nonmanifold_edges')==0 and r.get('volume_mm3',0)>0 for r in reports+tests), 'Invalid mesh: inspect before exporting plates'
(ROOT/'mechanical_report.json').write_text(json.dumps(report,indent=2))
scene['STATUS']=report['status'];scene['HEIGHT']='180 mm maximum, electronics base included'
camera=scene.camera;camera.location=(225,-400,205);camera.data.ortho_scale=225
camera.rotation_euler=(Vector((CX,0,90))-camera.location).to_track_quat('-Z','Y').to_euler()
scene.cycles.samples=24;scene.cycles.use_denoising=False
bpy.ops.object.select_all(action='DESELECT');base.select_set(True);bpy.context.view_layer.objects.active=base
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'Baymax_180_MECHANICAL_DEVELOPMENT.blend'))
scene.render.filepath=str(ROOT/'assembly_180.png');bpy.ops.render.render(write_still=True)
print(json.dumps(report))
