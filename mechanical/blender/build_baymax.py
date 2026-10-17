"""Editable 150 mm Baymax packaging draft; run with Blender --background --python.
All geometry coordinates and STL coordinates are millimetres. Not production CAD.
"""
import bpy, bmesh, math, json, struct
from pathlib import Path
from mathutils import Vector

ROOT = Path(__file__).resolve().parent
OUT = ROOT / 'draft_stl'
OUT.mkdir(exist_ok=True)
bpy.ops.object.select_all(action='SELECT')
bpy.ops.object.delete(use_global=False)
scene = bpy.context.scene
scene.unit_settings.system = 'METRIC'
scene.unit_settings.scale_length = .001
scene.unit_settings.length_unit = 'MILLIMETERS'
collections = {}
for name in ['01_SHELL_DRAFT', '02_FACE_AND_BUTTON', '03_HARDWARE_ENVELOPES', '04_JOINT_CONTROLS', '05_STUDIO']:
    col = bpy.data.collections.new(name)
    scene.collection.children.link(col)
    collections[name] = col

def move(obj, collection):
    for col in list(obj.users_collection): col.objects.unlink(obj)
    collections[collection].objects.link(obj)
    return obj

def material(name, color, roughness=.6):
    mat = bpy.data.materials.new(name)
    mat.diffuse_color = (*color, 1)
    mat.use_nodes = True
    bs = mat.node_tree.nodes.get('Principled BSDF')
    bs.inputs['Base Color'].default_value = (*color, 1)
    bs.inputs['Roughness'].default_value = roughness
    return mat

white = material('Warm white PLA', (.86, .88, .89))
black = material('Black face markings', (.009, .012, .018))
gray = material('Joint sleeve', (.53, .58, .62))
blue = material('ESP32 measured envelope', (.04, .27, .65))
orange = material('Servo reported envelope', (.95, .25, .055))
green = material('Speaker measured envelope', (.07, .5, .32))
floor_mat = material('Studio surface', (.115, .16, .20))

def apply(obj, mod):
    bpy.context.view_layer.objects.active = obj
    bpy.ops.object.modifier_apply(modifier=mod.name)

def sphere(name, loc, radii, mat=white, collection='01_SHELL_DRAFT'):
    bpy.ops.mesh.primitive_uv_sphere_add(segments=64, ring_count=40, location=loc)
    obj = bpy.context.object
    obj.name = name
    obj.scale = radii
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    obj.data.materials.append(mat)
    for p in obj.data.polygons: p.use_smooth = True
    return move(obj, collection)

def cube(name, loc, dims, mat=None, collection='03_HARDWARE_ENVELOPES'):
    bpy.ops.mesh.primitive_cube_add(size=1, location=loc)
    obj=bpy.context.object
    obj.name=name
    obj.dimensions=dims
    bpy.ops.object.transform_apply(location=False, rotation=False, scale=True)
    if mat: obj.data.materials.append(mat)
    return move(obj, collection)

def boolean(obj, cutter, operation='DIFFERENCE', remove=True):
    mod=obj.modifiers.new('Machined draft geometry', 'BOOLEAN')
    mod.operation=operation
    mod.solver='EXACT'
    mod.object=cutter
    apply(obj,mod)
    if remove: bpy.data.objects.remove(cutter, do_unlink=True)

def cylinder(name, loc, radius, depth, mat=white, axis='Z', collection='01_SHELL_DRAFT'):
    bpy.ops.mesh.primitive_cylinder_add(vertices=64, radius=radius, depth=depth, location=loc)
    obj=bpy.context.object
    obj.name=name
    if axis=='Y': obj.rotation_euler[0]=math.pi/2
    if axis=='X': obj.rotation_euler[1]=math.pi/2
    bpy.ops.object.transform_apply(location=False, rotation=True, scale=True)
    obj.data.materials.append(mat)
    return move(obj,collection)

def duplicate(obj, name):
    new=obj.copy(); new.data=obj.data.copy(); new.name=name
    obj.users_collection[0].objects.link(new)
    return new

def split_shell(obj, prefix, split_y=0, gap=.3):
    back=duplicate(obj,prefix+'_rear_DRAFT')
    obj.name=prefix+'_front_DRAFT'
    # Keep a small visible seam. Hollow pieces still need fastening features.
    boolean(obj,cube('front half tool',(0,split_y-150-gap/2,100),(400,300,400)), 'INTERSECT')
    boolean(back,cube('rear half tool',(0,split_y+150+gap/2,100),(400,300,400)), 'INTERSECT')
    return [obj,back]

def hollow_ellipsoid(name, loc, radii, wall=2):
    obj=sphere(name,loc,radii)
    boolean(obj,sphere('inner tool',loc,tuple(r-wall for r in radii)))
    return obj

def torso_mesh(name, inset=0):
    # Lathed pear silhouette. Ring locations avoid a sharp equatorial seam.
    profile=[(20,23,20),(23,31,25),(30,38,30),(43,43,34),(58,45,36),
             (73,44,35),(87,42,33),(99,40,30),(107,36,26),(113,27,19),(117,13,11)]
    verts=[]; faces=[]; n=64
    for z,rx,ry in profile:
        zz=z + (inset if z==20 else -inset if z==117 else 0)
        for i in range(n):
            a=2*math.pi*i/n
            verts.append(((rx-inset)*math.cos(a),(ry-inset)*math.sin(a),zz))
    for j in range(len(profile)-1):
        for i in range(n):
            a=j*n+i; b=j*n+(i+1)%n
            faces.append((a,b,b+n,a+n))
    faces.append(tuple(reversed(range(n))))
    faces.append(tuple((len(profile)-1)*n+i for i in range(n)))
    mesh=bpy.data.meshes.new(name); mesh.from_pydata(verts,[],faces); mesh.update()
    obj=bpy.data.objects.new(name,mesh); collections['01_SHELL_DRAFT'].objects.link(obj)
    obj.data.materials.append(white)
    # Subdivision rounds the profile; preserve bottom and top cap regions.
    mod=obj.modifiers.new('Rounded pear profile','SUBSURF'); mod.levels=2
    apply(obj,mod)
    for p in obj.data.polygons: p.use_smooth=True
    return obj

body=torso_mesh('Torso')
boolean(body,torso_mesh('Torso inner tool',2))
boolean(body,cylinder('Neck cable opening',(0,0,116),8,18))
# Shoulder apertures are clearance concepts, not fitted bearings.
for sign in [-1,1]:
    boolean(body,cylinder('Shoulder opening',(sign*40,8,96),5.5,24,axis='X'))
parts=split_shell(body,'01_torso',split_y=9)
# Speaker faces rear; grille in rear panel. Board occupies the front cavity.
for x in [-15,-10,-5,0,5,10,15]:
    boolean(parts[1],cube('Rear grille slot',(x,32,52),(1.8,24,25),'', '01_SHELL_DRAFT'))
boolean(parts[1],cube('Power cable opening',(0,27,29),(10,24,6)))

head=hollow_ellipsoid('Head',(0,-1,135),(34,22,15),1.8)
boolean(head,cylinder('Head neck opening',(0,0,121),8.2,12))
head_parts=split_shell(head,'02_head',split_y=0)
parts+=head_parts
neck=cylinder('03_neck_sleeve_DRAFT',(0,0,118),9.5,9,gray)
boolean(neck,cylinder('Neck bore',(0,0,118),7,14))
parts.append(neck)

arm_parts={}
for sign,side in [(-1,'left'),(1,'right')]:
    arm=hollow_ellipsoid('Arm',(sign*52,0,76),(13,14.5,33),1.8)
    arm.rotation_euler[1]=-sign*.20
    bpy.context.view_layer.objects.active=arm
    bpy.ops.object.transform_apply(location=False,rotation=True,scale=False)
    clearance=torso_mesh('Arm clearance tool')
    clearance.scale=(1.025,1.025,1)
    boolean(arm,clearance)
    arm_parts[side]=split_shell(arm,'04_'+side+'_arm')
    parts+=arm_parts[side]
    # Two fixed flat-bottom feet. Their interface is still a draft plane.
    foot=sphere('05_'+side+'_foot_DRAFT',(sign*17,-4,11),(19,25,14))
    boolean(foot,cube('Flat sole and top',(0,0,11),(200,200,22)),'INTERSECT')
    parts.append(foot)

details=[]
for sign in [-1,1]:
    details.append(sphere('Eye '+str(sign),(sign*12,-21.56,136),(2.7,1.1,2.7),black,'02_FACE_AND_BUTTON'))
details.append(cylinder('Eye connecting line',(0,-22.79,136),.55,24,black,axis='X',collection='02_FACE_AND_BUTTON'))
button=cylinder('Chest talk button visual',(-17,-29,97),4.5,1.2,gray,axis='Y',collection='02_FACE_AND_BUTTON')
button.rotation_euler=Vector((-.31,-.94,.13)).to_track_quat('Y','Z').to_euler()
details.append(button)

def control(name,pivot,objects,axis,limits):
    obj=bpy.data.objects.new(name,None); collections['04_JOINT_CONTROLS'].objects.link(obj)
    obj.location=pivot; obj.empty_display_type='ARROWS'; obj.empty_display_size=10
    bpy.context.view_layer.update()
    for child in objects:
        matrix=child.matrix_world.copy(); child.parent=obj; child.matrix_world=matrix
    obj['axis']=axis; obj['proposed_range_degrees']=str(limits)
    obj['warning']='Pose illustration only. Horn coupling, supports and collision sweep not validated.'
    return obj

head_control=control('POSE_head_yaw',(0,0,118),head_parts+details[:3],'Z',[-25,25])
left_control=control('POSE_left_shoulder',(-42,8,96),arm_parts['left'],'X',[-35,0])
right_control=control('POSE_right_shoulder',(42,8,96),arm_parts['right'],'X',[-35,0])

# Measured envelopes only: not detailed manufacturer models or mount templates.
hardware=[]
hardware.append(cube('MEASURED_ESP32_64x29x15',(0,-22.5,54),(29,15,64),blue))
hardware.append(cylinder('MEASURED_speaker_D52_depth26',(0,8,53),26,26,green,axis='Y',collection='03_HARDWARE_ENVELOPES'))
for sign,side in [(-1,'left'),(1,'right')]:
    hardware.append(cube('PROVISIONAL_'+side+'_servo_envelope',(sign*27,8,96),(30,11,32),orange))
hardware.append(cube('PROVISIONAL_neck_servo_envelope',(0,-7,102),(32,11,30),orange))
for obj in hardware:
    obj.hide_render=True
    obj['purpose']='Packaging placeholder; connectors, shaft offsets and brackets not represented.'
collections['03_HARDWARE_ENVELOPES'].hide_viewport=True

def mesh_report(obj):
    bm=bmesh.new(); bm.from_mesh(obj.data)
    bad=sum(not e.is_manifold for e in bm.edges)
    volume=bm.calc_volume(signed=True); bm.free()
    pts=[obj.matrix_world @ v.co for v in obj.data.vertices]
    lo=[min(p[i] for p in pts) for i in range(3)]; hi=[max(p[i] for p in pts) for i in range(3)]
    return {'part':obj.name,'nonmanifold_edges':bad,'signed_volume_mm3':round(volume,2),
            'bounds_min_mm':lo,'bounds_max_mm':hi,'dimensions_mm':[round(b-a,3) for a,b in zip(lo,hi)]}

def export_stl(obj):
    mesh=obj.data; mesh.calc_loop_triangles()
    with (OUT/(obj.name+'.stl')).open('wb') as f:
        f.write(b'DRAFT mm - NO FINAL MOUNTS - DO NOT BATCH PRINT'.ljust(80,b' '))
        f.write(struct.pack('<I',len(mesh.loop_triangles)))
        for tri in mesh.loop_triangles:
            v=[obj.matrix_world @ mesh.vertices[i].co for i in tri.vertices]
            normal=(v[1]-v[0]).cross(v[2]-v[0]).normalized()
            f.write(struct.pack('<12fH',*normal,*v[0],*v[1],*v[2],0))

bpy.context.view_layer.update()
reports=[mesh_report(obj) for obj in parts]
from mathutils.bvhtree import BVHTree
def tree(obj):
    bm=bmesh.new(); bm.from_mesh(obj.data); bm.transform(obj.matrix_world)
    result=BVHTree.FromBMesh(bm); bm.free(); return result
shell_trees=[(obj.name,tree(obj)) for obj in parts]
contacts=[]
for obj in hardware:
    t=tree(obj)
    for name,shell_tree in shell_trees:
        if t.overlap(shell_tree): contacts.append({'hardware':obj.name,'shell':name})
envelopes=[mesh_report(obj) for obj in hardware]
overlaps=[]
for i,a in enumerate(envelopes):
    for b in envelopes[i+1:]:
        if all(min(a['bounds_max_mm'][j],b['bounds_max_mm'][j])-max(a['bounds_min_mm'][j],b['bounds_min_mm'][j])>0 for j in range(3)):
            overlaps.append([a['part'],b['part']])
for obj in parts: export_stl(obj)
lo=[min(r['bounds_min_mm'][i] for r in reports) for i in range(3)]
hi=[max(r['bounds_max_mm'][i] for r in reports) for i in range(3)]
report={'status':'EDITABLE PACKAGING DRAFT, NOT ASSEMBLY-READY',
        'assembly_dimensions_mm':[round(b-a,3) for a,b in zip(lo,hi)],'parts':reports,
        'hardware_aabb_overlaps':overlaps,'hardware_shell_surface_contacts':contacts,
        'unresolved':['Physical servo gauge test','Horn and shaft geometry','Fasteners and load-bearing mounts',
          'Shell alignment and fastening','Connector bends and USB access','Microphone/amplifier measured dimensions',
          'Servo supply and power distribution','Full motion collision sweep','Slicer and physical print checks']}
(ROOT/'geometry_report.json').write_text(json.dumps(report,indent=2))

floor=cube('Studio floor',(0,0,-3),(2000,2000,6),floor_mat,'05_STUDIO')
def aim(obj,target): obj.rotation_euler=(Vector(target)-obj.location).to_track_quat('-Z','Y').to_euler()
bpy.ops.object.camera_add(location=(225,-365,205))
camera=move(bpy.context.object,'05_STUDIO'); camera.name='Assembly camera'; camera.data.type='ORTHO'; camera.data.ortho_scale=205
aim(camera,(0,0,75)); scene.camera=camera; camera.data.clip_end=5000
for name,loc,energy,size in [('Key',(-150,-210,320),2500000,230),('Fill',(220,-50,190),1700000,200),('Rim',(20,150,260),2800000,160)]:
    bpy.ops.object.light_add(type='AREA',location=loc); light=move(bpy.context.object,'05_STUDIO')
    light.name=name; light.data.energy=energy; light.data.shape='DISK'; light.data.size=size; aim(light,(0,0,70))
scene.render.engine='CYCLES'; scene.cycles.samples=24
scene.cycles.use_denoising=True
scene.world.color=(.35,.35,.35)
scene.render.resolution_x=1000; scene.render.resolution_y=1100; scene.render.resolution_percentage=100
scene.view_settings.view_transform='AgX'
scene['READ_ME']='150 mm visual and packaging draft. Read README.md before printing. All mechanical interfaces provisional.'
for screen in bpy.data.screens:
    for area in screen.areas:
        if area.type=='VIEW_3D':
            area.spaces.active.region_3d.view_distance=240
            area.spaces.active.region_3d.view_location=(0,0,75)
            area.spaces.active.clip_end=5000
            area.spaces.active.shading.color_type='MATERIAL'
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'Baymax_150mm_DRAFT.blend'))
scene.render.filepath=str(ROOT/'preview_front.png'); bpy.ops.render.render(write_still=True)
camera.location=(210,340,200); aim(camera,(0,0,75))
scene.render.filepath=str(ROOT/'preview_rear.png'); bpy.ops.render.render(write_still=True)
# Cutaway for packaging inspection: remove front torso, keep every envelope visible.
camera.location=(180,-340,190); aim(camera,(0,0,75))
parts[0].hide_render=True
for obj in hardware: obj.hide_render=False
scene.render.filepath=str(ROOT/'preview_packaging.png'); bpy.ops.render.render(write_still=True)
print('BAYMAX_REPORT '+json.dumps(report))
