# Exact mating-envelope cuts remove residuals left by scaled tolerance copies.
cut(lid,copy(button_bracket,'Exact bracket footprint'))
for h in [head_f,head_r]:cut(h,copy(head_clamp,'Exact clamp footprint'))
# A small rounded rear neck cover encloses the otherwise exposed mounting ear.
cover=cube('Rear neck tab cover',(3,19.5,155.8),(18,6,6))
bev=cover.modifiers.new('Rounded cover','BEVEL');bev.width=1.5;bev.segments=5
bpy.context.view_layer.objects.active=cover;bpy.ops.object.modifier_apply(modifier=bev.name)
union(rear,cover)
for target in [front,rear]:
 cut(target,cube('Neck mounting wing pocket',(3,4,155.8),(13.1,33,3.0)))
for target in [front,rear,head_f,head_r]:
 cut(target,cyl('Neck output housing clearance',(3,-1.2,161.9),6.5,6.5))
# Servo wings: their case dimensions do not include the mounting tabs.
for sign in [-1,1]:
 for target in [front,rear]:
  cut(target,cube('Shoulder mounting-tab clearance',(CX+sign*21,-1,128),(4,34.4,13.2)))
 for target in [o for o in parts if o.name.startswith('06_'+('Left' if sign<0 else 'Right'))]:
  cut(target,cyl('Round servo output housing',(CX+sign*27.25,4.2,128),6.5,7.5,'X'))
 clamp=bpy.data.objects['07_'+('Left' if sign<0 else 'Right')+'_horn_clamp_DRAFT']
 cut(clamp,cyl('Horn clamp turret clearance',(CX+sign*30,4.2,128),6.5,6,'X'))
# Removable access plugs hide the retaining-screw passages.
for side,sign in [('Left',-1),('Right',1)]:
 plug=cyl('13_'+side+'_arm_access_plug_DRAFT',(CX+sign*42,4.2,128),3.35,6,'X')
 cut(plug,original('NEUTRAL - '+side+' arm and hand'),'INTERSECT');parts.append(plug)
plug=cyl('14_head_access_plug_DRAFT',(3,-1.2,177.5),2.35,5)
cut(plug,original('SOURCE - Head'),'INTERSECT');parts.append(plug)
# Loose shims permit axial adjustment without changing the outside shell.
for i,h in enumerate([.6,1.0,2.0],1):
 shim=cube('15_servo_shim_'+str(i)+'_DRAFT',(CX+65+i*16,0,h/2),(12,18,h))
 shim.hide_render=True;parts.append(shim)
# Under-foot beams give the base screws a real load-bearing seat below the
# sculpted foot sockets, leaving the electronics volume accessible beneath.
for leg in [o for o in parts if o.name.startswith('03_')]:
 points=[leg.matrix_world@v.co for v in leg.data.vertices]
 fx=(min(v.x for v in points)+max(v.x for v in points))/2
 beam=cube('Foot support beam',(fx,0,29.5),(14,85,2.4))
 pad=cyl('Foot bearing pad',(fx,9,32.5),4.5,6)
 cut(pad,copy(leg,'Actual foot bearing surface'))
 union(beam,pad)
 cut(beam,cyl('Foot base screw clearance',(fx,9,31),1.7,12))
 cut(beam,cyl('Foot wiring route',(fx,-2,31),4.3,12))
 union(base,beam)
