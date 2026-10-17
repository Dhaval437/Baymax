from pathlib import Path
root=Path(__file__).resolve().parent
prefix=(root/'build_articulated_v3.py').read_text().split("for side,sign in [('Left',-1),('Right',1)]:")[0]
exec(prefix.replace('panel_fasteners_v2/Baymax_180_SERVICE_PANELS_V2.blend','articulated_v3/Baymax_180_ARTICULATED_PROTOTYPE.blend'))
tools=[cube('Case',(3,4,147.5),(12.5,22.4,22.8)),cube('Tabs',(3,4,155.8),(12.5,32.4,2.4)),cyl('Turret',(3,-1.2,161.9),6.25,6.02),cyl('Spline',(3,-1.2,166.9),2.5,4.02)]
for t in tools:
 for name in ['04_torso_front_DRAFT','04_torso_rear_DRAFT','05_head_front_DRAFT','05_head_rear_DRAFT']:
  hit=copy(t,'Hit');cut(hit,copy(bpy.data.objects[name],'Target'),'INTERSECT')
  if len(hit.data.vertices):
   ps=[hit.matrix_world@v.co for v in hit.data.vertices];bm=bmesh.new();bm.from_mesh(hit.data)
   print(t.name,name,'volume',bm.calc_volume(signed=True),'bounds',[[round(f(p[i] for p in ps),3) for i in range(3)] for f in [min,max]],flush=True);bm.free()

