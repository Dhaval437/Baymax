"""Flatten installed Bambu profiles for a local, reproducible P1S fit-test project."""
import json
from pathlib import Path
root=Path(__file__).resolve().parent
profiles=Path(r'D:\bambulab studio\Bambu Studio\resources\profiles\BBL')
byname={p.stem:p for p in profiles.rglob('*.json')}
def read(name,seen=()):
    if name in seen:raise ValueError('Profile inheritance cycle')
    d=json.loads(byname[name].read_text(encoding='utf-8'))
    out={}
    parent=d.get('inherits')
    if parent:out.update(read(parent,seen+(name,)))
    for inc in d.get('include',[]):out.update(read(inc,seen+(name,)))
    out.update(d)
    out.pop('inherits',None);out.pop('include',None)
    return out
settings=root/'settings';settings.mkdir(exist_ok=True)
for name,file in [('Bambu Lab P1S 0.4 nozzle','p1s_machine.json'),('0.20mm Standard @BBL X1C','fit_process.json'),('Generic PLA @BBL P1P','pla_filament.json')]:
    d=read(name)
    if file=='fit_process.json':
        d.update({'name':'Baymax fit tests - P1S 0.4 - 0.20 PLA','wall_loops':'3','sparse_infill_density':'20%','enable_support':'0','brim_type':'no_brim'})
    (settings/file).write_text(json.dumps(d,indent=2))
print('Saved flattened installed profiles; assumes P1S 0.4 mm nozzle and PLA.')
