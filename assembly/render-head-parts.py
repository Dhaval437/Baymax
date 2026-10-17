from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection

root = Path(__file__).resolve().parents[1]
folder = root / 'mechanical/production_180/articulated_v3/review_stl'
items = [
 ('05_head_front_DRAFT.stl', 'A. Head front — inside view', 30, 80),
 ('05_head_rear_DRAFT.stl', 'B. Head rear — inside view', 30, -80),
 ('07_head_carrier_DRAFT.stl', 'C. Head carrier — underside / horn recess', -45, 65),
 ('07_head_horn_clamp_DRAFT.stl', 'D. Head horn clamp', 55, -65),
 ('14_head_access_plug_DRAFT.stl', 'E. Removable roof access plug', 30, -65),
 ('04_torso_front_DRAFT.stl', 'F. Torso front — internal servo cradle', 20, 80),
]
fig = plt.figure(figsize=(15,10), facecolor='white')
for i, (name, title, elev, azim) in enumerate(items):
    raw = (folder/name).read_bytes()
    dtype = np.dtype([('normal','<f4',3), ('vertices','<f4',(3,3)), ('attribute','<u2')])
    triangles = np.frombuffer(raw, dtype=dtype, offset=84)['vertices'].astype(float)
    ax = fig.add_subplot(2,3,i+1,projection='3d')
    normals = np.cross(triangles[:,1]-triangles[:,0], triangles[:,2]-triangles[:,0])
    normals /= np.maximum(np.linalg.norm(normals,axis=1)[:,None],1e-12)
    shade = 0.65 + 0.3*np.maximum(0,normals@np.array([.3,.4,.86]))
    base = np.array([.55,.74,.9]) if i in (2,3) else np.array([.82,.84,.88])
    colors = shade[:,None]*base
    ax.add_collection3d(Poly3DCollection(triangles,facecolors=colors,edgecolors='none',rasterized=True))
    verts=triangles.reshape(-1,3); lo=verts.min(0); hi=verts.max(0); centre=(lo+hi)/2
    radius=max(hi-lo)*.55
    ax.set_xlim(centre[0]-radius,centre[0]+radius); ax.set_ylim(centre[1]-radius,centre[1]+radius); ax.set_zlim(centre[2]-radius,centre[2]+radius)
    ax.set_box_aspect((1,1,1)); ax.view_init(elev=elev,azim=azim); ax.set_axis_off()
    ax.set_title(title,fontsize=14,pad=0)
fig.suptitle('Actual CAD parts from your 180 mm Baymax print design', fontsize=22)
fig.text(.5,.02,'Each panel uses its own scale. Colours are for identification only.',ha='center',fontsize=12)
fig.subplots_adjust(top=.91,bottom=.05,wspace=.02,hspace=.03)
fig.savefig(root/'assembly/head-parts-cad-reference.png',dpi=160)
