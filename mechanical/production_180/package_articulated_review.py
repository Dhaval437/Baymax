"""Build review projects; no print release is implied by successful packaging."""
import json,zipfile,sys
from pathlib import Path
R=Path(__file__).resolve().parent
scope={'__file__':str(R/'package_plates.py')}
exec((R/'package_plates.py').read_text().split('fit_files=')[0],scope)
src=R/'articulated_v3/review_stl';out=R/'articulated_v3/BAMBU_REVIEW';out.mkdir(exist_ok=True)
groups=[('01_BASE',['01_','02_']),('02_TORSO',['04_']),('03_ARMS',['06_']),('04_HEAD_FEET',['03_','05_']),('05_SMALL_PARTS',['07_','08_','09_','10_','11_','12_','13_','14_','15_'])]
all_layout=[]
for title,prefixes in groups:
 if len(sys.argv)>1 and title not in sys.argv[1:]:continue
 files=[p for p in sorted(src.glob('*.stl')) if any(p.name.startswith(n) for n in prefixes)]
 path=out/(title+'_REVIEW.3mf')
 layout=scope['package'](files,path,True)
 with zipfile.ZipFile(path) as z:entries={n:z.read(n) for n in z.namelist()}
 cfg=json.loads((R/'settings/native_project.json').read_text())
 cfg.update({'print_settings_id':'Baymax 180 - REVIEW - P1S 0.4 PLA','enable_support':'1','support_type':'tree(auto)','support_style':'default','support_on_build_plate_only':'0','support_threshold_angle':'35','support_top_z_distance':'0.2','support_bottom_z_distance':'0.2','support_interface_top_layers':'3','wall_loops':'3','top_shell_layers':'5','bottom_shell_layers':'5','sparse_infill_density':'15%','brim_type':'outer_only','brim_width':'4','brim_object_gap':'0.15','curr_bed_type':'Textured PEI Plate'})
 entries['Metadata/project_settings.config']=json.dumps(cfg,indent=2).encode()
 # Explicit Bambu metadata lets Studio recognize the accompanying configuration.
 import xml.etree.ElementTree as E
 ns=scope['NS']; model=E.fromstring(entries['3D/3dmodel.model'])
 E.SubElement(model,'{'+ns+'}metadata',{'name':'Application'}).text='BambuStudio-02.08.02.61'
 E.SubElement(model,'{'+ns+'}metadata',{'name':'BambuStudio:3mfVersion'}).text='1'
 model.set('xmlns:BambuStudio','http://schemas.bambulab.com/package/2021')
 entries['3D/3dmodel.model']=E.tostring(model,encoding='utf-8',xml_declaration=True)
 with zipfile.ZipFile(path,'w',zipfile.ZIP_DEFLATED) as z:
  for n,data in entries.items():z.writestr(n,data)
 all_layout.append({'file':path.name,'parts':layout})
(out/'plate_layouts.json').write_text(json.dumps(all_layout,indent=2))
print(json.dumps(all_layout),flush=True)
