# Executed within the articulated builder; dimensions are millimetres.
def enlarge(o,allowance):
 bpy.context.view_layer.update();matrix=o.matrix_world.copy()
 for v in o.data.vertices:v.co=matrix@v.co
 o.matrix_world=Matrix.Identity(4)
 lo=Vector(tuple(min(v.co[i] for v in o.data.vertices) for i in range(3)))
 hi=Vector(tuple(max(v.co[i] for v in o.data.vertices) for i in range(3)))
 mid=(lo+hi)/2
 for v in o.data.vertices:
  v.co=mid+Vector(tuple((v.co[i]-mid[i])*(1+2*allowance/(hi[i]-lo[i])) for i in range(3)))
 o.data.update();return o
print('RELIEVE MOVING JOINTS',flush=True)
for side,sign in [('Left',-1),('Right',1)]:
 arms=[bpy.data.objects['06_'+side+'_arm_and_hand_'+suffix+'_DRAFT'] for suffix in ['front','rear']]
 envelope=enlarge(original('SOURCE - Torso'),.65)
 pivot=Vector((CX,4.2,128))
 for angle in range(0,31,5):
  tool=copy(envelope,'Inverse body sweep')
  tool.matrix_world=Matrix.Translation(pivot)@Matrix.Rotation(math.radians(angle),4,'X')@Matrix.Translation(-pivot)@tool.matrix_world
  cut(tool,cyl('Preserve coaxial hub',(CX+sign*30,4.2,128),9.15,8,'X'))
  for arm in arms:cut(arm,copy(tool,'Inner arm relief'))
  bpy.data.objects.remove(tool,do_unlink=True)
 bpy.data.objects.remove(envelope,do_unlink=True)
 clamp=bpy.data.objects['07_'+side+'_horn_clamp_DRAFT']
 for arm in arms:cut(arm,enlarge(copy(clamp,'Horn clamp recess'),.2))
 for angle in range(0,-31,-5):
  tool=enlarge(copy(clamp,'Clamp swept clearance'),.45)
  tool.matrix_world=Matrix.Translation(pivot)@Matrix.Rotation(math.radians(angle),4,'X')@Matrix.Translation(-pivot)@tool.matrix_world
  for target in [front,rear]:cut(target,copy(tool,'Clamp body clearance'))
  bpy.data.objects.remove(tool,do_unlink=True)
 for target in [front,rear]+arms:
  cut(target,cube('Case clearance',(CX+sign*13,-1,128.3),(23.3,22.9,12.5)))

# A silhouette-matched neck seat avoids exposing a large circular hole.
head_envelope=enlarge(original('SOURCE - Head'),.45)
pivot=Vector((3,-1.2,166))
for angle in range(-20,21,5):
 tool=copy(head_envelope,'Head rotation clearance')
 tool.matrix_world=Matrix.Translation(pivot)@Matrix.Rotation(math.radians(angle),4,'Z')@Matrix.Translation(-pivot)@tool.matrix_world
 for target in [front,rear]:cut(target,copy(tool,'Neck seat relief'))
 bpy.data.objects.remove(tool,do_unlink=True)
bpy.data.objects.remove(head_envelope,do_unlink=True)
for h in [head_f,head_r]:cut(h,enlarge(copy(head_clamp,'Head clamp recess'),.15))
cut(rear,copy(front,'Front panel clearance'))
face=[o for o in parts if o.name.startswith('12_Face')]
if face:
 face_insert=face[0]
 for o in face[1:]:parts.remove(o);union(face_insert,o)
 for h in [head_f,head_r]:cut(h,enlarge(copy(face_insert,'Face insert pocket'),.12))
badge=next(o for o in parts if o.name.startswith('12_Chest'))
cut(front,enlarge(copy(badge,'Badge pocket'),.12))
cut(lid,enlarge(copy(button_bracket,'Bracket foot clearance'),.15))
cut(button_bracket,cube('Board corner clearance',(CX,-15,15.65),(64.6,29.6,20)))
# Clear the component seats with their installation allowance.
cut(front,cube('Neck case tolerance',(3,4,149),(13.0,22.9,22.8)))
cut(rear,cyl('Speaker installation tolerance',(CX,3.5,92),26.3,26.5,'Y'))
for leg in [o for o in parts if o.name.startswith('03_')]:
 cut(leg,cyl('Speaker leg clearance',(CX,3.5,92),26.5,27,'Y'))
# The final arm sweep also includes fixed shoulder caps and the sculpted legs.
for side in ['Left','Right']:
 arms=[o for o in parts if o.name.startswith('06_'+side)]
 pivot=Vector((CX,4.2,128))
 for fixed in [front,rear]+[o for o in parts if o.name.startswith('03_')]:
  tool_source=copy(fixed,'Final stationary envelope')
  for angle in range(0,31,5):
   tool=copy(tool_source,'Joint residual clearance')
   tool.matrix_world=Matrix.Translation(pivot)@Matrix.Rotation(math.radians(angle),4,'X')@Matrix.Translation(-pivot)@tool.matrix_world
   for arm in arms:cut(arm,copy(tool,'Residual trim'))
   bpy.data.objects.remove(tool,do_unlink=True)
  bpy.data.objects.remove(tool_source,do_unlink=True)
