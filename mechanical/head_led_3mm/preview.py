from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
from matplotlib.colors import to_rgb
OUT=Path(__file__).resolve().parent
def mesh(name):
 p=OUT/'assembly_meshes'/(name+'.stl');r=p.read_bytes()
 return np.frombuffer(r,dtype=np.dtype([('n','<f4',3),('v','<f4',(3,3)),('a','<u2')]),offset=84)['v'].astype(float)
def draw(ax,t,color,shift=(0,0,0),alpha=1):
 t=t+np.array(shift);n=np.cross(t[:,1]-t[:,0],t[:,2]-t[:,0]);n/=np.maximum(np.linalg.norm(n,axis=1)[:,None],1e-9)
 c=(.60+.36*np.abs(n@np.array([.3,-.5,.8])))[:,None]*np.array(to_rgb(color))
 if not hasattr(ax,'cad_triangles'):ax.cad_triangles=[];ax.cad_colors=[]
 ax.cad_triangles.append(t);ax.cad_colors.append(c)
def setup(ax,lo,hi,elev,azim):
 ax.add_collection3d(Poly3DCollection(np.concatenate(ax.cad_triangles),facecolors=np.concatenate(ax.cad_colors),edgecolors='none'))
 for fn,a,b in zip([ax.set_xlim,ax.set_ylim,ax.set_zlim],lo,hi):fn(a,b)
 ax.set_box_aspect(np.array(hi)-np.array(lo));ax.set_proj_type('ortho');ax.view_init(elev,azim);ax.set_axis_off()
front=mesh('01_LED_head_front');rear=mesh('02_LED_head_rear')
leds=[mesh('REFERENCE Right LED lens'),mesh('REFERENCE Left LED lens')]
forks=[mesh('03_Right_LED_retainer'),mesh('03_Left_LED_retainer')]
fig=plt.figure(figsize=(15,9),facecolor='#f7f9fc')
fig.text(.04,.95,'BAYMAX • TWO 3 mm BLUE LED EYES',fontsize=24,weight='bold',color='#16324c')
fig.text(.04,.91,'Actual redesigned CAD • original motor mounting datums retained • removable rear cover',fontsize=13)
ax=fig.add_axes([.01,.49,.31,.37],projection='3d')
draw(ax,front,'#eceff2');draw(ax,rear,'#dde3e9')
for t in leds:draw(ax,t,'#168cff')
setup(ax,[-15,-17,160],[16,14,181],12,-90);ax.set_title('1  Front / blue eyes',fontsize=15,weight='bold')
ax=fig.add_axes([.34,.49,.31,.37],projection='3d')
draw(ax,front,'#dce2e7')
for t in leds:draw(ax,t,'#168cff')
for t in forks:draw(ax,t,'#e69f42')
setup(ax,[-15,-17,160],[16,6,181],24,75);ax.set_title('2  Inside / sliding LED retainers',fontsize=15,weight='bold')
ax=fig.add_axes([.67,.49,.31,.37],projection='3d')
draw(ax,rear,'#dce2e7')
setup(ax,[-15,-2,160],[16,15,181],20,-65);ax.set_title('3  Rear cover / two M2 screws',fontsize=15,weight='bold')
names=['01_LED_head_front','02_LED_head_rear','03_Right_LED_retainer','03_Left_LED_retainer','05_Original_head_carrier','06_Original_horn_clamp','07_Original_roof_plug']
labels=['Head front','Rear cover','Right keeper','Left keeper','Motor carrier\n(reuse existing)','Horn clamp\n(reuse existing)','Roof plug\n(reuse existing)']
for i,(name,label) in enumerate(zip(names,labels)):
 ax=fig.add_axes([.015+i*.14,.16,.135,.23],projection='3d');t=mesh(name)
 draw(ax,t,'#e69f42' if i in [2,3] else '#7aafc6' if i>=4 else '#dde3e9')
 v=t.reshape(-1,3);lo=v.min(0);hi=v.max(0);c=(lo+hi)/2;r=max(hi-lo)*.55
 setup(ax,c-r,c+r,28,65);ax.set_title(label,fontsize=11,pad=0)
fig.text(.04,.43,'ALL SEVEN PRINTED PARTS INCLUDED',fontsize=16,weight='bold',color='#16324c')
fig.text(.04,.105,'Add: 2 blue LEDs • 2 × 220 Ω resistors • 2 × M2 × 8 mm screws • thin flexible wire + heat-shrink',fontsize=12)
fig.text(.04,.065,'Power off to assemble. Do not glue the rear cover. Paint a thin black line between the eyes.',fontsize=12)
fig.text(.04,.025,'LED body/flange dimensions are nominal; physical fit is untested. Views use different scales. No printer or robot was activated.',fontsize=10,color='#536575')
fig.savefig(OUT/'head_led_assembly.png',dpi=150,facecolor=fig.get_facecolor())
