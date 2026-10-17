# Rebuild from the approved exterior rather than retaining accumulated tiny cuts.
print('REBUILD HEAD',flush=True)
for o in list(parts):
 if o.name.startswith(('05_','07_head')):
  parts.remove(o);bpy.data.objects.remove(o,do_unlink=True)
head_outer=original('SOURCE - Head')
face_parts=[o for o in parts if o.name.startswith('12_Face')]
for o in face_parts:
 union(head_outer,copy(o,'Raised facial detail'))
 parts.remove(o) # Cosmetic render overlays; the printed head includes these surfaces.
 o.name='PAINT GUIDE - '+o.name.replace('_DRAFT','')
head_shell=copy(head_outer,'05_head_front_DRAFT')
bpy.ops.mesh.primitive_uv_sphere_add(segments=64,ring_count=40,location=(.7,-1.2,171))
inside=move(bpy.context.object);inside.scale=(10.5,10,6.6)
bpy.ops.object.transform_apply(location=False,rotation=False,scale=True)
cut(head_shell,inside)
cut(head_shell,cyl('Head output shaft clearance',(3,-1.2,163),4.5,15))
head_f=head_shell;head_r=copy(head_shell,'05_head_rear_DRAFT')
split_tool(head_f,-.15,True);split_tool(head_r,.15,False)
# Two glued halves with locating pins; motor servicing remains possible through
# the removable roof plug, avoiding crossing fasteners in this small head.
for x in [-11.5,12.5]:
 peg=cyl('Head locating peg',(x,.15,171),1.6,2.4,'Y')
 cut(peg,copy(head_outer,'Peg outer limit'),'INTERSECT');union(head_f,peg)
 cut(head_r,cyl('Head locating socket',(x,.4,171),1.85,2.0,'Y'))
# Stock single horn, shortened at its tip if required, stays inside a removable
# clamping sandwich. The servo height is set by loose cradle shims at assembly.
carrier=cyl('07_head_carrier_DRAFT',(3,-1.2,169),8,2)
cut(carrier,copy(head_outer,'Carrier outer limit'),'INTERSECT')
cut(carrier,cube('Head short horn relief',(3,2.3,167.75),(7.5,14,1.5)))
cut(carrier,cyl('Stock horn retaining screw',(3,-1.2,169),2.8,8))
head_clamp=cyl('07_head_horn_clamp_DRAFT',(3,-1.2,166.25),8,1.5)
cut(head_clamp,copy(head_outer,'Clamp outer limit'),'INTERSECT')
cut(head_clamp,cyl('Servo output turret opening',(3,-1.2,166.25),3.5,8))
for x in [-1,7]:
 cut(carrier,cyl('Carrier M2.5 clearance',(x,-4,169),1.45,8))
 cut(head_clamp,cyl('Clamp M2.5 clearance',(x,-4,166.25),1.45,8))
 boss=cyl('Head attachment column',(x,-4,174),3,8.4)
 cut(boss,copy(head_outer,'Column outer limit'),'INTERSECT');union(head_f,boss)
 cut(head_f,cyl('Head attachment pilot',(x,-4,173),1.025,7))
for h in [head_f,head_r]:
 cut(h,cyl('Carrier seat clearance',(3,-1.2,169),8.2,2.3))
for h in [head_f,head_r]:cut(h,cyl('Servo screw roof access',(3,-1.2,179),2.5,24))
parts.extend([head_f,head_r,carrier,head_clamp])
bpy.data.objects.remove(head_outer,do_unlink=True)
