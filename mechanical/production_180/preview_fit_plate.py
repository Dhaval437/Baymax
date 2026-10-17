import bpy,zipfile,xml.etree.ElementTree as E
from pathlib import Path
ROOT=Path(__file__).resolve().parent
bpy.ops.object.select_all(action='SELECT');bpy.ops.object.delete(use_global=False)
scene=bpy.context.scene
def mat(name,color):
 m=bpy.data.materials.new(name);m.diffuse_color=(*color,1);m.use_nodes=True
 m.node_tree.nodes.get('Principled BSDF').inputs['Base Color'].default_value=(*color,1)
 return m
blue=mat('Fit pieces',(.045,.30,.48));white=mat('Plate',(.75,.78,.80));black=mat('Labels',(.01,.015,.02))
with zipfile.ZipFile(ROOT/'01_FIT_TESTS_P1S.3mf') as z:root=E.fromstring(z.read('3D/3dmodel.model'))
objects={o.attrib['id']:o for o in root.findall('.//{*}object')}
for i,item in enumerate(root.findall('.//{*}item'),1):
 o=objects[item.attrib['objectid']];t=list(map(float,item.attrib['transform'].split()))[-3:]
 verts=[tuple(float(v.attrib[k])+t[j] for j,k in enumerate(['x','y','z'])) for v in o.findall('.//{*}vertex')]
 faces=[tuple(int(f.attrib[k]) for k in ['v1','v2','v3']) for f in o.findall('.//{*}triangle')]
 mesh=bpy.data.meshes.new(o.attrib['name']);mesh.from_pydata(verts,[],faces);mesh.update()
 obj=bpy.data.objects.new(o.attrib['name'],mesh);scene.collection.objects.link(obj);mesh.materials.append(blue)
 x=min(v[0] for v in verts);y=min(v[1] for v in verts)
 bpy.ops.object.text_add(location=(x,y-5,1));label=bpy.context.object;label.data.body=str(i);label.data.size=3.5;label.data.materials.append(black)
bpy.ops.mesh.primitive_cube_add(size=1,location=(128,128,-1));plate=bpy.context.object;plate.dimensions=(256,256,2);plate.data.materials.append(white)
bpy.ops.object.camera_add(location=(128,128,350));scene.camera=bpy.context.object;scene.camera.data.type='ORTHO';scene.camera.data.ortho_scale=275;scene.camera.data.clip_end=1000
bpy.ops.object.light_add(type='AREA',location=(70,70,250));bpy.context.object.data.energy=3500000;bpy.context.object.data.size=250
scene.world.color=(.5,.5,.5);scene.render.engine='CYCLES';scene.cycles.samples=12;scene.cycles.use_denoising=False
scene.render.resolution_x=850;scene.render.resolution_y=850;scene.render.resolution_percentage=100
scene.render.filepath=str(ROOT/'fit_plate_preview.png');bpy.ops.render.render(write_still=True)
