import bpy
from pathlib import Path
from mathutils import Vector
root=Path(__file__).resolve().parent/'articulated_v3'
bpy.ops.wm.open_mainfile(filepath=str(root/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
s=bpy.context.scene
s.render.engine='BLENDER_WORKBENCH'
s.display.shading.light='STUDIO';s.display.shading.studiolight_rotate_z=.35
s.display.shading.color_type='MATERIAL';s.display.shading.show_shadows=True
s.display.shading.show_cavity=True;s.display.shading.cavity_type='BOTH'
s.display.shading.background_type='WORLD';s.world.color=(.12,.14,.17)
s.render.resolution_x=800;s.render.resolution_y=900;s.render.resolution_percentage=100
s.render.image_settings.file_format='PNG';s.render.film_transparent=False
s.camera.location=(225,-400,205)
s.camera.rotation_euler=(Vector((4.82,0,90))-s.camera.location).to_track_quat('-Z','Y').to_euler()
s.camera.data.ortho_scale=225
s.render.filepath=str(root/'assembly_preview.png');bpy.ops.render.render(write_still=True)
# Rear halves separated to expose the internal fastening structure.
for o in list(bpy.data.objects):
 if o.name.endswith('_rear_DRAFT'):o.location.y+=65
 elif o.name=='02_base_bottom_DRAFT':o.location.z-=20
s.camera.location=(250,410,230)
s.camera.rotation_euler=(Vector((4.82,25,85))-s.camera.location).to_track_quat('-Z','Y').to_euler()
s.camera.data.ortho_scale=265
s.render.filepath=str(root/'service_panels_exploded.png');bpy.ops.render.render(write_still=True)

