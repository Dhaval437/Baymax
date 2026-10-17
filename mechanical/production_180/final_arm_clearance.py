"""Add a small clearance allowance at the fixed shoulder/arm interface."""
import bpy,math
from pathlib import Path
from mathutils import Vector,Matrix
R=Path(__file__).resolve().parent/'articulated_v3'
bpy.ops.wm.open_mainfile(filepath=str(R/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
front=bpy.data.objects['04_torso_front_DRAFT']; pivot=Vector((4.820418357849121,4.2,128))
source=front.copy();source.data=front.data.copy();bpy.context.scene.collection.objects.link(source)
mat=source.matrix_world.copy()
for v in source.data.vertices:v.co=mat@v.co
source.matrix_world=Matrix.Identity(4)
lo=Vector(tuple(min(v.co[i] for v in source.data.vertices) for i in range(3)))
hi=Vector(tuple(max(v.co[i] for v in source.data.vertices) for i in range(3)));mid=(lo+hi)/2
for v in source.data.vertices:v.co=mid+Vector(tuple((v.co[i]-mid[i])*(1+.3/(hi[i]-lo[i])) for i in range(3)))
source.data.update()
arms=[o for o in bpy.data.objects if o.name.startswith('06_') and o.name.endswith('_DRAFT')]
for angle in range(31):
 source.matrix_world=Matrix.Translation(pivot)@Matrix.Rotation(math.radians(angle),4,'X')@Matrix.Translation(-pivot)
 bpy.context.view_layer.update()
 for arm in arms:
  mod=arm.modifiers.new('Shoulder running clearance','BOOLEAN');mod.operation='DIFFERENCE';mod.solver='MANIFOLD';mod.object=source
  bpy.context.view_layer.objects.active=arm;bpy.ops.object.modifier_apply(modifier=mod.name)
bpy.data.objects.remove(source,do_unlink=True)
bpy.ops.wm.save_as_mainfile(filepath=str(R/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
