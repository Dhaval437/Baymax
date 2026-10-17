"""Standard 3MF geometry plus Bambu project metadata; no printer transmission.
Only fit-test project is released. Development plates remain explicitly on HOLD.
"""
import json,zipfile,struct,xml.etree.ElementTree as E
from pathlib import Path
ROOT=Path(__file__).resolve().parent
NS='http://schemas.microsoft.com/3dmanufacturing/core/2015/02'
E.register_namespace('',NS)
def mesh(path):
    data=path.read_bytes();count=struct.unpack_from('<I',data,80)[0]
    if len(data)!=84+50*count:
        vertices=[];faces=[];lookup={};face=[]
        for line in data.decode('ascii').splitlines():
            words=line.strip().split()
            if words and words[0]=='vertex':
                xyz=tuple(map(float,words[1:4]))
                if xyz not in lookup:lookup[xyz]=len(vertices);vertices.append(xyz)
                face.append(lookup[xyz])
                if len(face)==3:faces.append(face);face=[]
        if not faces or face:raise ValueError('Invalid ASCII STL')
        return vertices,faces
    vertices=[];faces=[];lookup={}
    for i in range(count):
        row=struct.unpack_from('<12fH',data,84+50*i);face=[]
        for j in [3,6,9]:
            xyz=tuple(row[j:j+3])
            if xyz not in lookup:lookup[xyz]=len(vertices);vertices.append(xyz)
            face.append(lookup[xyz])
        faces.append(face)
    return vertices,faces
def settings():
    with zipfile.ZipFile(ROOT.parent/'reference_model/source_Baymax1_color.3mf') as z:d=json.loads(z.read('Metadata/project_settings.config'))
    omit={'name','type','from','setting_id','instantiation','inherits','include','description'}
    for name in ['p1s_machine.json','fit_process.json','pla_filament.json']:
        for k,v in json.loads((ROOT/'settings'/name).read_text()).items():
            if k not in omit:d[k]=v
    d.update({'printer_settings_id':'Bambu Lab P1S 0.4 nozzle','print_settings_id':'Baymax fit tests - P1S 0.4 - 0.20 PLA',
      'filament_settings_id':['Generic PLA @BBL P1P'],'filament_colour':['#FFFFFF'],'filament_type':['PLA'],
      'curr_bed_type':'Textured PEI Plate','layer_height':'0.2','initial_layer_print_height':'0.2','wall_loops':'3',
      'enable_support':'0','brim_type':'no_brim','sparse_infill_density':'20%'})
    return d
def package(files,destination,development=False):
    model=E.Element('{'+NS+'}model',{'unit':'millimeter'})
    E.SubElement(model,'{'+NS+'}metadata',{'name':'Title'}).text=destination.stem
    E.SubElement(model,'{'+NS+'}metadata',{'name':'Description'}).text='DEVELOPMENT ONLY - NOT RELEASED FOR FULL PRINT' if development else 'Small physical fit tests. Verify nozzle and filament before slicing.'
    resources=E.SubElement(model,'{'+NS+'}resources');build=E.SubElement(model,'{'+NS+'}build')
    config=E.Element('config');plate=E.Element('plate')
    E.SubElement(plate,'metadata',{'key':'plater_id','value':'1'})
    E.SubElement(plate,'metadata',{'key':'plater_name','value':destination.stem})
    layout=[];x=22.;y=30.;row_height=0
    for idx,path in enumerate(files,1):
        vertices,faces=mesh(path)
        lo=[min(v[i] for v in vertices) for i in range(3)];hi=[max(v[i] for v in vertices) for i in range(3)]
        w,h=hi[0]-lo[0],hi[1]-lo[1]
        if x+w>236:x=22.;y+=row_height+10;row_height=0
        if y+h>236:raise ValueError('Plate overflow '+path.name)
        tx,ty,tz=x-lo[0],y-lo[1],-lo[2]
        obj=E.SubElement(resources,'{'+NS+'}object',{'id':str(idx),'type':'model','name':path.stem})
        m=E.SubElement(obj,'{'+NS+'}mesh');vs=E.SubElement(m,'{'+NS+'}vertices');ts=E.SubElement(m,'{'+NS+'}triangles')
        for v in vertices:E.SubElement(vs,'{'+NS+'}vertex',dict(zip(['x','y','z'],[format(a,'.8g') for a in v])))
        for f in faces:E.SubElement(ts,'{'+NS+'}triangle',dict(zip(['v1','v2','v3'],map(str,f))))
        E.SubElement(build,'{'+NS+'}item',{'objectid':str(idx),'transform':f'1 0 0 0 1 0 0 0 1 {tx} {ty} {tz}'})
        ob=E.SubElement(config,'object',{'id':str(idx)})
        E.SubElement(ob,'metadata',{'key':'name','value':path.stem});E.SubElement(ob,'metadata',{'key':'extruder','value':'1'})
        part=E.SubElement(ob,'part',{'id':str(idx),'subtype':'normal_part'})
        E.SubElement(part,'metadata',{'key':'name','value':path.stem})
        inst=E.SubElement(plate,'model_instance')
        for key,value in [('object_id',idx),('instance_id',0),('identify_id',idx)]:E.SubElement(inst,'metadata',{'key':key,'value':str(value)})
        layout.append({'name':path.stem,'x_mm':x,'y_mm':y,'width_mm':w,'depth_mm':h,'height_mm':hi[2]-lo[2]})
        x+=w+10;row_height=max(row_height,h)
    config.append(plate)
    d=settings()
    if development:d['print_settings_id']='DEVELOPMENT - support and orientation review required'
    contenttypes='<?xml version="1.0"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/><Default Extension="config" ContentType="application/octet-stream"/></Types>'
    rels='<?xml version="1.0"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/></Relationships>'
    with zipfile.ZipFile(destination,'w',zipfile.ZIP_DEFLATED) as z:
        z.writestr('[Content_Types].xml',contenttypes);z.writestr('_rels/.rels',rels)
        z.writestr('3D/3dmodel.model',E.tostring(model,encoding='utf-8',xml_declaration=True))
        z.writestr('Metadata/model_settings.config',E.tostring(config,encoding='utf-8',xml_declaration=True))
        z.writestr('Metadata/project_settings.config',json.dumps(d,indent=2))
    with zipfile.ZipFile(destination) as z:
        assert z.testzip() is None
        parsed=E.fromstring(z.read('3D/3dmodel.model'))
        assert len(parsed.findall('.//{*}object'))==len(files)
    return layout
fit_files=sorted((ROOT.parent/'servo_fit_gauge').glob('*.stl'))+sorted((ROOT/'fit_tests').glob('*.stl'))
layout=package(fit_files,ROOT/'01_FIT_TESTS_P1S.3mf')
(ROOT/'fit_plate_layout.json').write_text(json.dumps(layout,indent=2))
hold=ROOT/'HOLD_NOT_FOR_PRINT';hold.mkdir(exist_ok=True)
report=json.loads((ROOT/'mechanical_report.json').read_text())
valid={p['name'] for p in report['parts'] if p.get('nonmanifold_edges')==0 and p.get('volume_mm3',0)>0}
for prefix,title in [('01_','02_BASE_BOX'),('02_','03_BASE_COVER'),('03_','04_FEET'),('04_','05_TORSO'),('05_','06_HEAD'),('06_','07_ARMS')]:
    files=[p for p in sorted((ROOT/'draft_stl').glob(prefix+'*.stl')) if p.stem in valid]
    if files:package(files,hold/(title+'_DEVELOPMENT.3mf'),True)
print(json.dumps({'fit_test_objects':len(fit_files),'fit_project':'01_FIT_TESTS_P1S.3mf','validation':'ZIP, XML and geometric plate bounds checked. Bambu slicing not yet verified.'}))
