"""Level the original head using the two eyes as a reference; retain 150 mm height."""
import bpy, math, json
from pathlib import Path
from mathutils import Vector, Matrix
ROOT=Path(__file__).resolve().parent
bpy.ops.wm.open_mainfile(filepath=str(ROOT/'Baymax_BOTH_ARMS_DOWN_150mm.blend'))
scene=bpy.context.scene
head=bpy.data.objects['SOURCE - Head']
face=[o for o in scene.objects if o.name.startswith('SOURCE - Face marking')]
def bounds(obj):
    pts=[obj.matrix_world @ v.co for v in obj.data.vertices]
    return Vector(tuple(min(p[i] for p in pts) for i in range(3))),Vector(tuple(max(p[i] for p in pts) for i in range(3)))
def center(obj):
    a,b=bounds(obj);return (a+b)/2
# The connecting stroke has the most vertices; the two smaller islands are eyes.
eyes=sorted(sorted(face,key=lambda o:len(o.data.vertices))[:2],key=lambda o:center(o).x)
delta=center(eyes[1])-center(eyes[0])
angle=math.atan2(delta.z,delta.x)
pivot=center(head)
rotation=Matrix.Rotation(angle,4,'Y')
transform=Matrix.Translation(pivot) @ rotation @ Matrix.Translation(-pivot)
for obj in [head]+face: obj.matrix_world=transform @ obj.matrix_world
bpy.context.view_layer.update()
# Keep the previously agreed maximum overall height without scaling the sculpt.
shift=150-max(bounds(o)[1].z for o in [head]+face)
for obj in [head]+face: obj.location.z+=shift
bpy.context.view_layer.update()
after=center(eyes[1])-center(eyes[0])
report={'correction_degrees':math.degrees(angle),'eye_line_remaining_degrees':math.degrees(math.atan2(after.z,after.x)),
 'head_top_mm':bounds(head)[1].z,'vertical_adjustment_mm':shift,
 'note':'Head and face transformed rigidly together. Neck interface remains provisional.'}
(ROOT/'straight_head_report.json').write_text(json.dumps(report,indent=2))
scene['HEAD_POSE']='Head tilt corrected; eye line level. Shoulder and neck mounts pending.'
camera=scene.camera
camera.location=(4.820418,-400,92)
camera.rotation_euler=(Vector((4.820418,0,76))-camera.location).to_track_quat('-Z','Y').to_euler()
scene.cycles.samples=48;scene.cycles.use_denoising=False
bpy.ops.object.select_all(action='DESELECT');head.select_set(True);bpy.context.view_layer.objects.active=head
for screen in bpy.data.screens:
    for area in screen.areas:
        if area.type=='VIEW_3D':area.spaces.active.region_3d.view_rotation=camera.rotation_euler.to_quaternion()
bpy.ops.wm.save_as_mainfile(filepath=str(ROOT/'Baymax_ARMS_DOWN_STRAIGHT_HEAD_150mm.blend'))
scene.render.filepath=str(ROOT/'straight_head_front.png');bpy.ops.render.render(write_still=True)
print(json.dumps(report))
