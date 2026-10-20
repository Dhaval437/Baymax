"""Generate the requested round 5 mm male/female fit prototype in millimetres."""
import math, struct, json
from pathlib import Path
from collections import Counter

OUT = Path(__file__).resolve().parent
N = 128
# Axial section: socket floor, socket mouth, body, male tip. No servo spline.
profile = [(0,3),(2.5,3),(2.5,0),(4,0),(4,5),(2.5,5),(2.5,8),(0,8)]
vertices, rings, faces = [], [], []
for radius,z in profile:
    ring = []
    for i in range(N if radius else 1):
        angle = 2*math.pi*i/N
        ring.append(len(vertices))
        vertices.append((radius*math.cos(angle),radius*math.sin(angle),z))
    rings.append(ring)
for a,b in zip(rings,rings[1:]):
    for i in range(N):
        j=(i+1)%N
        if len(a)==1: faces.append((a[0],b[j],b[i]))
        elif len(b)==1: faces.append((a[i],a[j],b[0]))
        else: faces.extend([(a[i],a[j],b[j]),(a[i],b[j],b[i])])

def cross(a,b): return (a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0])
def sub(a,b): return tuple(x-y for x,y in zip(a,b))
edges=Counter(tuple(sorted((f[i],f[(i+1)%3]))) for f in faces for i in range(3))
assert all(count==2 for count in edges.values()), 'Mesh must be closed'
assert len(vertices)-len(edges)+len(faces)==2
volume=sum(sum(x*y for x,y in zip(vertices[a],cross(vertices[b],vertices[c])))/6 for a,b,c in faces)
assert volume>0 and abs(volume-80*math.pi)<0.3

def write_stl(name, offsets):
    with (OUT/name).open('wb') as f:
        f.write(b'Baymax ROUND FIT PROTOTYPE mm: body5 maleD5x3 femaleD5depth3'.ljust(80,b' '))
        f.write(struct.pack('<I',len(faces)*len(offsets)))
        for dx in offsets:
            for face in faces:
                a,b,c=[(vertices[i][0]+dx,vertices[i][1],vertices[i][2]) for i in face]
                n=cross(sub(b,a),sub(c,a)); length=math.sqrt(sum(x*x for x in n))
                assert length>0
                n=tuple(x/length for x in n)
                f.write(struct.pack('<12fH',*n,*a,*b,*c,0))
write_stl('Baymax_arm_extension_5mm_5mm_single.stl',[0])
write_stl('Baymax_arm_extension_5mm_5mm_pair.stl',[-10,10])
report={'units':'mm','body_diameter':8,'body_length':5,'male_diameter':5,'male_projection':3,
        'female_diameter':5,'female_depth':3,'overall_length':8,'copies_in_pair':2,
        'nominal_axial_extension_when_fully_seated':5,
        'triangles_each':len(faces),'nonmanifold_edges':0,'volume_each_mm3':round(volume,3),
        'male_projection_is_assumed':True,'physical_fit_tested':False,'spline_teeth':False,
        'status':'Round fit prototype only; not a validated torque-transmitting SG90 spline coupling.'}
(OUT/'dimensions_and_mesh_check.json').write_text(json.dumps(report,indent=2))
print(json.dumps(report))

