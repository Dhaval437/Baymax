"""Non-printing component reservations for the revised compact base layout."""
import bpy,json
from pathlib import Path
from mathutils import Vector
root=Path(__file__).resolve().parent
layout=json.loads((root/'base_layout_decision.json').read_text())
bpy.ops.wm.open_mainfile(filepath=str(root/'Baymax_180_MECHANICAL_DEVELOPMENT.blend'))
col=bpy.data.collections.new('ELECTRONICS RESERVATIONS - NOT PRINT PARTS')
bpy.context.scene.collection.children.link(col)
cx=4.820418357849121
reports=[]
for index,item in enumerate(layout['candidate_reservations']):
    centre=Vector(item['centre_mm']);centre.x+=cx;centre.z+=2.4
    bpy.ops.object.select_all(action='DESELECT')
    bpy.ops.mesh.primitive_cube_add(size=1,location=centre)
    obj=bpy.context.object;obj.name='RESERVATION - '+item['part'];obj.dimensions=item['size_mm']
    bpy.ops.object.transform_apply(location=False,rotation=False,scale=True)
    for c in list(obj.users_collection):c.objects.unlink(obj)
    col.objects.link(obj)
    obj.display_type='WIRE';obj.show_in_front=True;obj.hide_render=True
    obj['NON_PRINTING']='Envelope only; plugs, supports and mounting still unverified'
    d=item['size_mm'];p=item['centre_mm']
    fit=(abs(p[0])+d[0]/2<47 and abs(p[1])+d[1]/2<39.5 and p[2]-d[2]/2>=0 and p[2]+d[2]/2<layout['base_internal_height_mm'])
    reports.append({'part':item['part'],'inside_empty_cavity_envelope':fit})
assert all(r['inside_empty_cavity_envelope'] for r in reports)
for i,a in enumerate(layout['candidate_reservations']):
    for b in layout['candidate_reservations'][i+1:]:
        overlap=all(abs(a['centre_mm'][k]-b['centre_mm'][k])<(a['size_mm'][k]+b['size_mm'][k])/2 for k in range(3))
        assert not overlap,(a['part'],b['part'])
bpy.context.scene['LAYOUT_STATUS']='Candidate wireframe electronics envelopes. Mounts and connector checks incomplete.'
(root/'base_layout_envelope_check.json').write_text(json.dumps({'checks':reports,'mutual_envelope_overlap':False,'limits':'Rectangular reservations only. Does not verify collisions with existing mounts, plugs, foot fixings or wiring.'},indent=2))
bpy.ops.wm.save_as_mainfile(filepath=str(root/'Baymax_180_BASE_LAYOUT_CANDIDATE.blend'))
print('SAVED candidate electronics layout; empty-cavity envelope checks passed')
