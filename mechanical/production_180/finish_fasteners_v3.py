"""Final fastener seats, applied to the current articulated working copy."""
from pathlib import Path
root=Path(__file__).resolve().parent
prefix=(root/'build_articulated_v3.py').read_text().split("for side,sign in [('Left',-1),('Right',1)]:")[0]
prefix=prefix.replace('panel_fasteners_v2/Baymax_180_SERVICE_PANELS_V2.blend','articulated_v3/Baymax_180_ARTICULATED_PROTOTYPE.blend')
exec(prefix)
lid=bpy.data.objects['02_base_bottom_DRAFT']
bpy.data.objects.remove(lid,do_unlink=True)
with bpy.data.libraries.load(str(ROOT/'panel_fasteners_v2/Baymax_180_SERVICE_PANELS_V2.blend'),link=False) as (src,dst):
 dst.objects=['02_base_bottom_DRAFT']
lid=dst.objects[0];COL.objects.link(lid)
cut(lid,cube('Old board rail removal',(CX,0,11.5),(76,40,18.2)))
for y in [-29.5,-.5]:
 rail=cube('ESP32 board rail',(CX,y,3.85),(68,3,3.1))
 for x in [CX-24,CX+24]:cut(rail,cube('Strap slot',(x,y,4.2),(3,7,1.2)))
 union(lid,rail)
for x in [CX-22,CX+22]:
 rail=cube('Distribution rail',(x,19,3.85),(3,32,3.1))
 cut(rail,cube('Strap slot',(x,19,4.2),(7,3,1.2)));union(lid,rail)
for y in [6,24]:union(lid,cube('Audio board rail',(CX+35,y,3.85),(20,2,3.1)))
for x in [CX-8,CX+8]:
 cut(lid,cube('Button foot seat',(x,-29,5.7),(7.8,13,6.7)))
 cut(lid,cyl('Button M2 clearance',(x,-27,2),1.1,8))
def cone(p,r1,r2,h):
 bpy.ops.mesh.primitive_cone_add(vertices=48,radius1=r1,radius2=r2,depth=h,location=p)
 return move(bpy.context.object)
for x in [CX-43,CX+43]:
 for y in [-35,35]:
  union(lid,cyl('Fill old head counterbore',(x,y,.85),3.2,1.7))
  cut(lid,cyl('M3 clearance',(x,y,2),1.7,8))
  cut(lid,cone((x,y,.65),3.0,1.7,1.3))
for x in [CX-8,CX+8]:cut(lid,cone((x,-27,.6),2.1,1.1,1.2))
bpy.ops.wm.save_as_mainfile(filepath=str(OUT/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
