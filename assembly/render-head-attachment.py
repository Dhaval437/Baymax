from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
from mpl_toolkits.mplot3d import proj3d

root=Path(__file__).resolve().parent
def mesh(name):
 raw=(root/'head-cad'/(name+'_DRAFT.stl')).read_bytes()
 return np.frombuffer(raw,dtype=np.dtype([('n','<f4',3),('v','<f4',(3,3)),('a','<u2')]),offset=84)['v'].astype(float)
def draw(ax,t,color,shift=(0,0,0)):
 t=t+np.array(shift);n=np.cross(t[:,1]-t[:,0],t[:,2]-t[:,0]);n/=np.maximum(np.linalg.norm(n,axis=1)[:,None],1e-9)
 light=np.array([.2,.55,.8]);shade=.62+.38*np.abs(n@light)
 from matplotlib.colors import to_rgb
 colors=shade[:,None]*np.array(to_rgb(color))
 ax.add_collection3d(Poly3DCollection(t,facecolors=colors,edgecolors='none',rasterized=True))
def box(c,d):
 v=np.array([[a,b,z] for z in [-1,1] for b in [-1,1] for a in [-1,1]])*np.array(d)/2+np.array(c)
 return v[np.array([[0,1,3],[0,3,2],[4,6,7],[4,7,5],[0,4,5],[0,5,1],[2,3,7],[2,7,6],[0,2,6],[0,6,4],[1,5,7],[1,7,3]])]
def cylinder(c,r,h):
 a=np.linspace(0,2*np.pi,49);lo=np.array([c[0]+r*np.cos(a),c[1]+r*np.sin(a),np.full(len(a),c[2]-h/2)]).T;hi=lo+[0,0,h];out=[]
 for j in range(48):out.extend([[lo[j],lo[j+1],hi[j]],[hi[j],lo[j+1],hi[j+1]],[[c[0],c[1],c[2]-h/2],lo[j+1],lo[j]],[[c[0],c[1],c[2]+h/2],hi[j],hi[j+1]]])
 return np.array(out)
def setup(ax,lo,hi,elev,azim):
 for fn,a,b in zip([ax.set_xlim,ax.set_ylim,ax.set_zlim],lo,hi):fn(a,b)
 ax.set_box_aspect(np.array(hi)-np.array(lo));ax.view_init(elev=elev,azim=azim);ax.set_proj_type('ortho');ax.set_axis_off()
front=mesh('05_head_front');carrier=mesh('07_head_carrier');clamp=mesh('07_head_horn_clamp')
fig=plt.figure(figsize=(16,12),facecolor='#f7f9fc')
fig.text(.04,.96,'HEAD TO SERVO — YOUR ACTUAL PRINTED-PART DESIGN',fontsize=23,weight='bold',color='#16324c')
fig.text(.04,.925,'Printed parts rendered directly from the assembly CAD. Exploded gaps enlarged for visibility.',fontsize=13)
ax=fig.add_axes([.01,.13,.58,.76],projection='3d')
draw(ax,front,'#dae1ea',(0,0,45));draw(ax,carrier,'#23a7b8',(0,0,30));draw(ax,clamp,'#7664ce',(0,0,13))
# Supplier-dependent hardware shown only as explicitly labelled reference shapes.
draw(ax,cylinder((3,-1.2,188.2),3,1.4),'#f6ae45')
draw(ax,box((3,2.3,188.2),(4,7,1.4)),'#f6ae45')
draw(ax,cylinder((3,-1.2,186.5),2.2,2),'#f6ae45')
draw(ax,box((3,4,147.5),(12.5,22.4,22.8)),'#3d8cd5')
draw(ax,box((3,4,155.8),(12.5,32.4,2.4)),'#3d8cd5')
draw(ax,cylinder((3,-1.2,161.9),6.25,6.02),'#3d8cd5')
draw(ax,cylinder((3,-1.2,166.9),2.5,4.02),'#e5e9ef')
ax.plot([3,3],[-1.2,-1.2],[168,227],linestyle='--',color='#738092',lw=1)
setup(ax,[-20,-20,132],[22,24,230],18,65)
def label(point,text,xy,color):
 x,y,z=proj3d.proj_transform(*point,ax.get_proj())
 ax.annotate(text,xy=(x,y),xycoords='data',xytext=xy,textcoords='axes fraction',fontsize=12,ha='left',va='center',color=color,weight='bold',arrowprops=dict(arrowstyle='-',color=color,lw=1.2),bbox=dict(facecolor='#f7f9fc',edgecolor='none',pad=3))
label((9,-4,216),'1  HEAD FRONT\nInside faces you',(.04,.91),'#16324c')
label((8,-1,199),'2  CARRIER\nRecess faces DOWN',(.04,.68),'#087c8c')
label((3,4,188),'3  ORIGINAL HORN*\nSingle arm points BACK',(.04,.53),'#9b5b06')
label((8,-1,179.3),'4  PRINTED CLAMP\nBelow the horn',(.04,.39),'#6350b5')
label((7,4,146),'5  SG90 SERVO*\nShaft points UP',(.04,.16),'#1b5994')
# Larger real close-ups show the actual recess and screw passages.
for rect,data,col,title,elev in [([.59,.62,.19,.23],carrier,'#23a7b8','Carrier: UNDERSIDE',-55),([.79,.62,.19,.23],clamp,'#7664ce','Clamp: TOP',55)]:
 detail=fig.add_axes(rect,projection='3d');draw(detail,data,col)
 v=data.reshape(-1,3);c=(v.min(0)+v.max(0))/2
 setup(detail,c-[9,9,4],c+[9,9,4],elev,65)
 detail.set_title(title,fontsize=13,weight='bold',color=col)
fig.text(.60,.605,'Two small holes = fixing screws.\nLarge centre hole = shaft / service access.',fontsize=12,color='#334155')
fig.text(.60,.54,'HOW TO FASTEN IT',fontsize=17,weight='bold',color='#16324c')
steps=[
 'A. Sandwich the original horn between\n    the carrier and clamp.',
 'B. From BELOW, pass two M2.5 × 10 mm\n    screws through clamp + carrier into\n    the head-front columns. Hand-tighten.',
 'C. Centre the unloaded servo electrically.\n    Disconnect power. Fit the head straight.',
 'D. Fit the servo’s OWN centre screw\n    through the roof access hole.\n    Keep the roof plug removable.'
]
y=.505
for s in steps:
 fig.text(.60,y,s,fontsize=13,va='top',linespacing=1.5,color='#26384d');y-=.09 if s.startswith('A') else .105
fig.text(.04,.085,'FIRST: dry-fit only. Leave the rear head unglued until a small movement test passes.',fontsize=15,weight='bold',color='#b34019')
fig.text(.04,.048,'* Servo and horn are reference shapes, NOT scanned hardware. Photo needed to confirm your actual horn fit.',fontsize=12,color='#334155')
fig.text(.04,.022,'Do not force the shaft or glue the moving joint. No servo movement or centering has been performed for this guide.',fontsize=11,color='#334155')
fig.savefig(root/'head-attachment-cad.png',dpi=160,facecolor=fig.get_facecolor())
