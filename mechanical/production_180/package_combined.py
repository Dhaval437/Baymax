"""One Bambu project, compact two-plate arrangement, pending Studio verification."""
import json,zipfile,xml.etree.ElementTree as E
from pathlib import Path
R=Path(__file__).resolve().parent
scope={'__file__':str(R/'package_plates.py')}
exec((R/'package_plates.py').read_text().split('fit_files=')[0],scope)
NS=scope['NS']; tag=lambda n:'{'+NS+'}'+n
src=R/'articulated_v3/review_stl'; out=R/'PRINT_PACKAGE_180MM';out.mkdir(exist_ok=True)
records=json.loads((R/'articulated_v3/export_wall_report.json').read_text())
groups=[[p for p in records if p['part'].startswith(('01_','02_','07_','08_','09_','10_','11_','12_','13_','14_','15_'))],
        [p for p in records if p['part'].startswith(('03_','04_','05_','06_'))]]
def pack(items):
 free=[(20.,30.,224.,214.)];placed=[]
 for p in sorted(items,key=lambda p:max(p['oriented_dimensions_mm'][:2]),reverse=True):
  w,h=p['oriented_dimensions_mm'][:2];w+=12;h+=12
  candidates=[]
  for i,(x,y,fw,fh) in enumerate(free):
   for rot,(a,b) in enumerate([(w,h),(h,w)]):
    if a<=fw and b<=fh:candidates.append((min(fw-a,fh-b),max(fw-a,fh-b),y,x,i,rot,a,b))
  if not candidates:raise ValueError('Cannot pack '+p['part'])
  _,_,y,x,i,rot,w,h=min(candidates);used=(x,y,w,h);new=[]
  for fx,fy,fw,fh in free:
   if x>=fx+fw or x+w<=fx or y>=fy+fh or y+h<=fy:new.append((fx,fy,fw,fh));continue
   if x>fx:new.append((fx,fy,x-fx,fh))
   if x+w<fx+fw:new.append((x+w,fy,fx+fw-x-w,fh))
   if y>fy:new.append((fx,fy,fw,y-fy))
   if y+h<fy+fh:new.append((fx,y+h,fw,fy+fh-y-h))
  free=[a for j,a in enumerate(new) if not any(j!=k and a[0]>=b[0] and a[1]>=b[1] and a[0]+a[2]<=b[0]+b[2] and a[1]+a[3]<=b[1]+b[3] and (a!=b or j>k) for k,b in enumerate(new))]
  placed.append((p,x+6,y+6,rot,w-12,h-12))
 return placed
layouts=[pack(g) for g in groups]
model=E.Element(tag('model'),{'unit':'millimeter','xmlns:BambuStudio':'http://schemas.bambulab.com/package/2021'})
for k,v in [('Application','BambuStudio-02.08.02.61'),('BambuStudio:3mfVersion','1'),('Title','Baymax 180 mm — two print plates')]:E.SubElement(model,tag('metadata'),{'name':k}).text=v
resources=E.SubElement(model,tag('resources'));build=E.SubElement(model,tag('build'));config=E.Element('config');layout_report=[]
idx=0
for plate_index,layout in enumerate(layouts,1):
 plate=E.Element('plate')
 for k,v in [('plater_id',str(plate_index)),('plater_name',['Base and fittings','Baymax body'][plate_index-1]),('locked','false')]:E.SubElement(plate,'metadata',{'key':k,'value':v})
 for p,x,y,rot,w,h in layout:
  idx+=1;name=p['part'].replace('_DRAFT','');vertices,faces=scope['mesh'](src/(p['part']+'.stl'))
  if rot:vertices=[(-v[1],v[0],v[2]) for v in vertices]
  low=[min(v[i] for v in vertices) for i in range(3)]
  vertices=[tuple(v[i]-low[i] for i in range(3)) for v in vertices]
  obj=E.SubElement(resources,tag('object'),{'id':str(idx),'type':'model','name':name});m=E.SubElement(obj,tag('mesh'));vs=E.SubElement(m,tag('vertices'));ts=E.SubElement(m,tag('triangles'))
  for v in vertices:E.SubElement(vs,tag('vertex'),dict(zip(['x','y','z'],[format(a,'.8g') for a in v])))
  for f in faces:E.SubElement(ts,tag('triangle'),dict(zip(['v1','v2','v3'],map(str,f))))
  E.SubElement(build,tag('item'),{'objectid':str(idx),'transform':f'1 0 0 0 1 0 0 0 1 {x+(plate_index-1)*307.2} {y} 0','printable':'1'})
  ob=E.SubElement(config,'object',{'id':str(idx)})
  for k,v in [('name',name),('extruder','1')]:E.SubElement(ob,'metadata',{'key':k,'value':v})
  part=E.SubElement(ob,'part',{'id':str(idx),'subtype':'normal_part'});E.SubElement(part,'metadata',{'key':'name','value':name})
  inst=E.SubElement(plate,'model_instance')
  for k,v in [('object_id',idx),('instance_id',0),('identify_id',idx)]:E.SubElement(inst,'metadata',{'key':k,'value':str(v)})
  layout_report.append({'part':name,'plate':plate_index,'x':x,'y':y,'width':w,'depth':h,'rotated':bool(rot)})
 config.append(plate)
cfg=json.loads((R/'settings/native_project.json').read_text())
cfg.update({'print_settings_id':'Baymax 180 P1S PLA 0.20','enable_support':'1','support_type':'tree(auto)','support_on_build_plate_only':'0','support_threshold_angle':'35','support_top_z_distance':'0.2','support_bottom_z_distance':'0.2','support_interface_top_layers':'3','wall_loops':'3','top_shell_layers':'5','bottom_shell_layers':'5','sparse_infill_density':'15%','brim_type':'outer_only','brim_width':'4','brim_object_gap':'0.15','curr_bed_type':'Textured PEI Plate','filament_colour':['#FFFFFF','#FFFFFF'],'print_sequence':'by layer'})
with zipfile.ZipFile(R/'articulated_v3/BAMBU_REVIEW/01_BASE_REVIEW.3mf') as z:entries={n:z.read(n) for n in ['[Content_Types].xml','_rels/.rels']}
entries.update({'3D/3dmodel.model':E.tostring(model,encoding='utf-8',xml_declaration=True),'Metadata/model_settings.config':E.tostring(config,encoding='utf-8',xml_declaration=True),'Metadata/project_settings.config':json.dumps(cfg,indent=2).encode()})
with zipfile.ZipFile(out/'Baymax_180mm_P1S_TWO_PLATES.3mf','w',zipfile.ZIP_DEFLATED) as z:
 for n,d in entries.items():z.writestr(n,d)
(out/'plate_layout.json').write_text(json.dumps(layout_report,indent=2))
print('Combined project:',len(layout_report),'parts on',len(layouts),'plates')
