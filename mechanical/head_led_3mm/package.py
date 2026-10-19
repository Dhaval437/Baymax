"""One-plate Bambu project, using validated meshes; no print job transmission."""
import json,zipfile,struct,xml.etree.ElementTree as E
from pathlib import Path
R=Path(__file__).resolve().parent
NS='http://schemas.microsoft.com/3dmanufacturing/core/2015/02';E.register_namespace('',NS)
tag=lambda n:'{'+NS+'}'+n
model=E.Element(tag('model'),{'unit':'millimeter','xmlns:BambuStudio':'http://schemas.bambulab.com/package/2021'})
for k,v in [('Application','BambuStudio-02.08.02.61'),('BambuStudio:3mfVersion','1'),('Title','Baymax 3mm LED head — fit prototype')]:E.SubElement(model,tag('metadata'),{'name':k}).text=v
res=E.SubElement(model,tag('resources'));build=E.SubElement(model,tag('build'));config=E.Element('config');plate=E.Element('plate')
for k,v in [('plater_id','1'),('plater_name','LED head - all assembly parts'),('locked','false')]:E.SubElement(plate,'metadata',{'key':k,'value':v})
layout=[];x=40.;y=45.
for idx,p in enumerate(sorted((R/'STL').glob('*.stl')),1):
 raw=p.read_bytes();n=struct.unpack_from('<I',raw,80)[0];verts=[];faces=[];lookup={}
 assert len(raw)==84+50*n
 for i in range(n):
  row=struct.unpack_from('<12fH',raw,84+50*i);f=[]
  for j in [3,6,9]:
   v=tuple(row[j:j+3])
   if v not in lookup:lookup[v]=len(verts);verts.append(v)
   f.append(lookup[v])
  faces.append(f)
 lo=[min(v[i] for v in verts) for i in range(3)];hi=[max(v[i] for v in verts) for i in range(3)]
 w,h=hi[0]-lo[0],hi[1]-lo[1]
 if x+w>210:x=40;y+=45
 obj=E.SubElement(res,tag('object'),{'id':str(idx),'type':'model','name':p.stem});m=E.SubElement(obj,tag('mesh'));vs=E.SubElement(m,tag('vertices'));ts=E.SubElement(m,tag('triangles'))
 for v in verts:E.SubElement(vs,tag('vertex'),dict(zip(['x','y','z'],[format(v[i]-lo[i],'.9g') for i in range(3)])))
 for f in faces:E.SubElement(ts,tag('triangle'),dict(zip(['v1','v2','v3'],map(str,f))))
 E.SubElement(build,tag('item'),{'objectid':str(idx),'transform':f'1 0 0 0 1 0 0 0 1 {x} {y} 0','printable':'1'})
 ob=E.SubElement(config,'object',{'id':str(idx)})
 for k,v in [('name',p.stem),('extruder','1')]:E.SubElement(ob,'metadata',{'key':k,'value':v})
 # Small keepers print flat, solid, with no supports trapped in the opening.
 if 'retainer' in p.stem:
  for k,v in [('enable_support','0'),('sparse_infill_density','100%')]:E.SubElement(ob,'metadata',{'key':k,'value':v})
 part=E.SubElement(ob,'part',{'id':str(idx),'subtype':'normal_part'});E.SubElement(part,'metadata',{'key':'name','value':p.stem})
 ins=E.SubElement(plate,'model_instance')
 for k,v in [('object_id',idx),('instance_id',0),('identify_id',idx)]:E.SubElement(ins,'metadata',{'key':k,'value':str(v)})
 layout.append({'part':p.stem,'x':x,'y':y,'w':w,'h':h,'z':hi[2]-lo[2]});x+=w+12
config.append(plate)
cfg=json.loads((R.parent/'production_180/settings/native_project.json').read_text())
cfg.update({'print_settings_id':'Baymax LED head prototype P1S 0.12','layer_height':'0.12','initial_layer_print_height':'0.2','enable_support':'1','support_type':'tree(auto)','support_on_build_plate_only':'0','support_threshold_angle':'30','support_top_z_distance':'0.16','support_bottom_z_distance':'0.16','support_interface_top_layers':'3','wall_loops':'3','top_shell_layers':'5','bottom_shell_layers':'5','sparse_infill_density':'20%','brim_type':'outer_only','brim_width':'3','brim_object_gap':'0.15','curr_bed_type':'Textured PEI Plate','filament_colour':['#FFFFFF','#FFFFFF'],'print_sequence':'by layer'})
with zipfile.ZipFile(R.parent/'production_180/PRINT_PACKAGE_180MM/Baymax_180mm_P1S_TWO_PLATES.3mf') as z:
 entries={n:z.read(n) for n in ['[Content_Types].xml','_rels/.rels']}
entries.update({'3D/3dmodel.model':E.tostring(model,encoding='utf-8',xml_declaration=True),'Metadata/model_settings.config':E.tostring(config,encoding='utf-8',xml_declaration=True),'Metadata/project_settings.config':json.dumps(cfg,indent=2).encode()})
with zipfile.ZipFile(R/'Baymax_LED_head_3mm_ONE_PLATE.3mf','w',zipfile.ZIP_DEFLATED) as z:
 for n,d in entries.items():z.writestr(n,d)
(R/'plate_layout.json').write_text(json.dumps(layout,indent=2))
assert len(layout)==7
assert all(p['x']>=10 and p['x']+p['w']<246 and p['y']>=10 and p['y']+p['h']<246 for p in layout)
print('Packaged seven parts on one plate; geometry/config project, not sliced G-code.')
