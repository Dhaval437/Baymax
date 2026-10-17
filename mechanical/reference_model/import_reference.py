"""Import the user's local 3MF faithfully, preserving color parts and transforms."""
import bpy, bmesh, json, zipfile, xml.etree.ElementTree as ET
from pathlib import Path
from mathutils import Vector, Matrix

ROOT=Path(__file__).resolve().parent
bpy.ops.object.select_all(action='SELECT'); bpy.ops.object.delete(use_global=False)
scene=bpy.context.scene
scene.unit_settings.system='METRIC'; scene.unit_settings.scale_length=.001
scene.unit_settings.length_unit='MILLIMETERS'
def material(name,color):
    m=bpy.data.materials.new(name); m.diffuse_color=(*color,1); m.use_nodes=True
    p=m.node_tree.nodes.get('Principled BSDF'); p.inputs['Base Color'].default_value=(*color,1); p.inputs['Roughness'].default_value=.62
    return m
white=material('Original white sculpt',(.84,.86,.87)); black=material('Original black details and plinth',(.012,.018,.024))
def transform(raw):
    a=list(map(float,raw.split())) if raw else [1,0,0,0,1,0,0,0,1,0,0,0]
    return Matrix(((a[0],a[3],a[6],a[9]),(a[1],a[4],a[7],a[10]),(a[2],a[5],a[8],a[11]),(0,0,0,1)))
models=[]
with zipfile.ZipFile(ROOT/'source_Baymax1_color.3mf') as archive:
    main=ET.fromstring(archive.read('3D/3dmodel.model'))
    metadata={m.attrib.get('name'):m.text for m in main.findall('{*}metadata')}
    for component in main.findall('.//{*}component'):
        path=next(v for k,v in component.attrib.items() if k.endswith('}path')).lstrip('/')
        xml=ET.fromstring(archive.read(path))
        source=next(o for o in xml.findall('.//{*}object') if o.attrib['id']==component.attrib['objectid'])
        mat=transform(component.attrib.get('transform'))
        vertices=[mat @ Vector(tuple(float(v.attrib[k]) for k in ('x','y','z'))) for v in source.findall('.//{*}vertex')]
        faces=[tuple(int(f.attrib[k]) for k in ('v1','v2','v3')) for f in source.findall('.//{*}triangle')]
        mesh=bpy.data.meshes.new('Original mesh '+source.attrib['id']); mesh.from_pydata(vertices,[],faces); mesh.update()
        name='Original black parts and base' if source.attrib['id']=='1' else 'Original white body'
        obj=bpy.data.objects.new(name,mesh); scene.collection.objects.link(obj)
        obj.data.materials.append(black if source.attrib['id']=='1' else white)
        for p in mesh.polygons:p.use_smooth=True
        models.append(obj)

allverts=[v.co for o in models for v in o.data.vertices]
lo=Vector(tuple(min(v[i] for v in allverts) for i in range(3)))
hi=Vector(tuple(max(v[i] for v in allverts) for i in range(3)))
offset=Vector(((lo.x+hi.x)/2,(lo.y+hi.y)/2,lo.z)); scale=150/(hi.z-lo.z)
stats=[]
for obj in models:
    for v in obj.data.vertices:v.co=(v.co-offset)*scale
    obj.data.update()
    bm=bmesh.new(); bm.from_mesh(obj.data)
    remaining=set(bm.verts); islands=[]
    while remaining:
        seed=remaining.pop(); stack=[seed]; island=[seed]
        while stack:
            v=stack.pop()
            for edge in v.link_edges:
                nxt=edge.other_vert(v)
                if nxt in remaining: remaining.remove(nxt);stack.append(nxt);island.append(nxt)
        a=[min(v.co[i] for v in island) for i in range(3)]; b=[max(v.co[i] for v in island) for i in range(3)]
        islands.append({'vertices':len(island),'bounds_min_mm':a,'bounds_max_mm':b})
    stats.append({'object':obj.name,'vertices':len(bm.verts),'faces':len(bm.faces),'nonmanifold_edges':sum(not e.is_manifold for e in bm.edges),'connected_islands':sorted(islands,key=lambda i:-i['vertices'])})
    bm.free()
report={'source':'source_Baymax1_color.3mf','designer':metadata.get('Designer'),'title':metadata.get('Title'),'license_metadata':metadata.get('License'),
 'overall_dimensions_mm':list((hi-lo)*scale),'height_includes_original_plinth':True,'uniform_scale_from_source_mesh':scale,
 'status':'Original exterior preserved. Robot joints, hollowing, mounts and hardware fit not implemented.', 'meshes':stats}
(ROOT/'source_inspection.json').write_text(json.dumps(report,indent=2))
scene['STATUS']=report['status']; scene['SOURCE_DESIGNER']=str(metadata.get('Designer'))
scene['HEIGHT']='150 mm overall including original display plinth; all proportions preserved.'

# The sculpt already contains separate connected pieces. Expose those without
# reshaping or cutting the silhouette; touching surfaces still need joint clearance.
bpy.ops.object.select_all(action='DESELECT')
for obj in models: obj.select_set(True)
bpy.context.view_layer.objects.active=models[1]
bpy.ops.object.mode_set(mode='EDIT'); bpy.ops.mesh.select_all(action='SELECT')
bpy.ops.mesh.separate(type='LOOSE'); bpy.ops.object.mode_set(mode='OBJECT')
sculpt=list(bpy.context.selected_objects)
for obj in sculpt:
    low=[min(v.co[i] for v in obj.data.vertices) for i in range(3)]
    high=[max(v.co[i] for v in obj.data.vertices) for i in range(3)]
    mid=[(a+b)/2 for a,b in zip(low,high)]
    is_black=obj.data.materials[0]==black
    if is_black: label='Display plinth' if high[2]<10 else 'Face marking'
    elif low[2]>125: label='Head'
    elif high[2]<60: label='Leg left' if mid[0]<0 else 'Leg right'
    elif high[0]-low[0]>60: label='Torso'
    elif mid[0]<-15: label='Waving arm and hand'
    elif mid[0]>25: label='Lowered arm and hand'
    else: label='Chest badge'
    obj.name='SOURCE - '+label
    obj['STATUS']='Original sculpt segment. Not hollowed or fitted with robot joints.'

def aim(obj,target):obj.rotation_euler=(Vector(target)-obj.location).to_track_quat('-Z','Y').to_euler()
bpy.ops.mesh.primitive_cube_add(size=1,location=(0,0,-3)); floor=bpy.context.object;floor.name='Studio floor';floor.dimensions=(2000,2000,6)
floor.data.materials.append(material('Slate studio',(.115,.16,.2)))
bpy.ops.object.camera_add(location=(210,-370,170));camera=bpy.context.object;camera.name='Reference camera';camera.data.type='ORTHO';camera.data.ortho_scale=185;camera.data.clip_end=5000
aim(camera,(0,0,76));scene.camera=camera
for name,loc,power,size in [('Key',(-150,-210,320),2500000,230),('Fill',(220,-50,190),1700000,200),('Rim',(20,150,260),2800000,160)]:
    bpy.ops.object.light_add(type='AREA',location=loc);light=bpy.context.object;light.name=name;light.data.energy=power;light.data.shape='DISK';light.data.size=size;aim(light,(0,0,70))
scene.render.engine='CYCLES';scene.cycles.samples=12;scene.cycles.use_denoising=False
scene.world.color=(.35,.35,.35);scene.view_settings.view_transform='AgX'
scene.render.resolution_x=650;scene.render.resolution_y=800;scene.render.resolution_percentage=100
for screen in bpy.data.screens:
    for area in screen.areas:
        if area.type=='VIEW_3D':
            v=area.spaces.active;v.clip_end=5000;v.shading.color_type='MATERIAL'
            v.region_3d.view_distance=230;v.region_3d.view_location=(0,0,75)
            v.region_3d.view_rotation=camera.rotation_euler.to_quaternion()
bpy.ops.object.select_all(action='DESELECT')
models[1].select_set(True);bpy.context.view_layer.objects.active=models[1]
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'Baymax_ORIGINAL_150mm_WORKING.blend'))
scene.render.filepath=str(ROOT/'original_front.png');bpy.ops.render.render(write_still=True)
camera.location=(0,370,125);aim(camera,(0,0,76));scene.render.filepath=str(ROOT/'original_reverse.png');bpy.ops.render.render(write_still=True)
print('SOURCE_INSPECTION '+json.dumps(report))
