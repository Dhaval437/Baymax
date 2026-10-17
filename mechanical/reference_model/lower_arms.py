"""Create neutral arms using a mirrored copy of the sculpt's original lowered arm.
The original waving source remains in a hidden reference collection.
"""
import bpy, bmesh, json
from pathlib import Path
from mathutils import Vector

ROOT=Path(__file__).resolve().parent
bpy.ops.wm.open_mainfile(filepath=str(ROOT/'Baymax_ORIGINAL_150mm_WORKING.blend'))
scene=bpy.context.scene
raised=bpy.data.objects['SOURCE - Waving arm and hand']
lowered=bpy.data.objects['SOURCE - Lowered arm and hand']
base=bpy.data.objects['SOURCE - Display plinth']
basepoints=[base.matrix_world @ v.co for v in base.data.vertices]
center_x=(min(v.x for v in basepoints)+max(v.x for v in basepoints))/2
archive=bpy.data.collections.new('REFERENCE ONLY - original raised arm')
scene.collection.children.link(archive)
for col in list(raised.users_collection):col.objects.unlink(raised)
archive.objects.link(raised);archive.hide_render=True;archive.hide_viewport=True
raised.hide_render=True
neutral=lowered.copy();neutral.data=lowered.data.copy()
scene.collection.objects.link(neutral)
neutral.name='NEUTRAL - Left arm and hand'
lowered.name='NEUTRAL - Right arm and hand'
for v in neutral.data.vertices:
    world=neutral.matrix_world @ v.co
    world.x=2*center_x-world.x
    v.co=neutral.matrix_world.inverted() @ world
bm=bmesh.new();bm.from_mesh(neutral.data)
bmesh.ops.reverse_faces(bm,faces=list(bm.faces))
bmesh.ops.recalc_face_normals(bm,faces=list(bm.faces))
bm.to_mesh(neutral.data);bm.free();neutral.data.update()

report={'status':'Neutral exterior; both arms down. Servo mounting and motion clearance pending.',
        'method':'Mirror the original lowered arm and hand across the display-base symmetry plane. Preserve original sculpt topology.',
        'symmetry_plane_x_mm':center_x,'arms':[]}
for obj in (neutral,lowered):
    bm=bmesh.new();bm.from_mesh(obj.data)
    report['arms'].append({'name':obj.name,'vertices':len(bm.verts),'nonmanifold_edges':sum(not e.is_manifold for e in bm.edges),'volume_mm3':bm.calc_volume(signed=True)})
    bm.free()
    obj['STATUS']='Neutral solid sculpt segment. Independent object; no servo mount yet.'
visible=[o for o in scene.objects if o.type=='MESH' and o!=raised and o.name!='Studio floor']
points=[o.matrix_world @ v.co for o in visible for v in o.data.vertices]
report['overall_dimensions_mm']=[max(p[i] for p in points)-min(p[i] for p in points) for i in range(3)]
assert abs(report['overall_dimensions_mm'][2]-150)<.001
assert all(a['nonmanifold_edges']==0 and a['volume_mm3']>0 for a in report['arms'])
(ROOT/'neutral_arms_report.json').write_text(json.dumps(report,indent=2))
scene['STATUS']=report['status']
scene.cycles.samples=48;scene.cycles.use_denoising=False
camera=scene.camera
def aim(target):camera.rotation_euler=(Vector(target)-camera.location).to_track_quat('-Z','Y').to_euler()
camera.location=(195,-380,165);aim((center_x,0,76))
for screen in bpy.data.screens:
    for area in screen.areas:
        if area.type=='VIEW_3D':
            area.spaces.active.region_3d.view_location=(center_x,0,75)
            area.spaces.active.region_3d.view_rotation=camera.rotation_euler.to_quaternion()
bpy.ops.object.select_all(action='DESELECT')
neutral.select_set(True);lowered.select_set(True);bpy.context.view_layer.objects.active=neutral
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'Baymax_BOTH_ARMS_DOWN_150mm.blend'))
scene.render.filepath=str(ROOT/'both_arms_down.png');bpy.ops.render.render(write_still=True)
camera.location=(center_x,-400,92);aim((center_x,0,76))
scene.render.filepath=str(ROOT/'both_arms_down_front.png');bpy.ops.render.render(write_still=True)
print(json.dumps(report))
