"""Bounded repair of sub-nozzle Boolean slivers; preserve designed features."""
import bpy,bmesh,json
from pathlib import Path
R=Path(__file__).resolve().parent/'articulated_v3'
bpy.ops.wm.open_mainfile(filepath=str(R/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
report=[]
for o in bpy.data.collections['MECHANICAL DEVELOPMENT - NOT FULL PRINT RELEASE'].objects:
 if o.type!='MESH' or not o.name.endswith('_DRAFT'):continue
 bm=bmesh.new();bm.from_mesh(o.data)
 bad=[e for e in bm.edges if not e.is_manifold];before=len(bad)
 if bad:
  verts=list({v for e in bad for v in e.verts})
  bmesh.ops.remove_doubles(bm,verts=verts,dist=.012)
  bmesh.ops.dissolve_degenerate(bm,edges=list(bm.edges),dist=.0005)
  boundary=[e for e in bm.edges if e.is_boundary]
  if boundary and len(boundary)<=12 and max(e.calc_length() for e in boundary)<.25:
   bmesh.ops.holes_fill(bm,edges=boundary,sides=12)
  bmesh.ops.recalc_face_normals(bm,faces=list(bm.faces))
 islands=[];seen=set()
 for v in bm.verts:
  if v in seen:continue
  group={v};todo=[v];seen.add(v)
  while todo:
   a=todo.pop()
   for e in a.link_edges:
    b=e.other_vert(a)
    if b not in seen:seen.add(b);group.add(b);todo.append(b)
  points=[o.matrix_world@v.co for v in group]
  islands.append({'verts':len(group),'min':[min(p[i] for p in points) for i in range(3)],'max':[max(p[i] for p in points) for i in range(3)]})
 record={'part':o.name,'bad_before':before,'bad_after':sum(not e.is_manifold for e in bm.edges),'islands':islands}
 report.append(record);bm.to_mesh(o.data);bm.free()
(R/'mesh_repair_report.json').write_text(json.dumps(report,indent=2))
print(json.dumps([r for r in report if r['bad_before'] or len(r['islands'])>1]),flush=True)
if any(r['bad_after'] for r in report):raise ValueError('Mesh repair incomplete; original blend preserved')
bpy.ops.wm.save_as_mainfile(filepath=str(R/'Baymax_180_ARTICULATED_PROTOTYPE.blend'))
