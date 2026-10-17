from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.colors import to_rgb
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
from mpl_toolkits.mplot3d import proj3d

root=Path(__file__).resolve().parent
CX=4.820418357849121
def mesh(name,sign):
 raw=(root/'arm-cad'/(name+'_DRAFT.stl')).read_bytes()
 t=np.frombuffer(raw,dtype=np.dtype([('n','<f4',3),('v','<f4',(3,3)),('a','<u2')]),offset=84)['v'].astype(float)
 t[:,:,0]=sign*(t[:,:,0]-CX)
 return t
def draw(ax,t,color,shift=(0,0,0)):
 t=t+np.array(shift);n=np.cross(t[:,1]-t[:,0],t[:,2]-t[:,0]);n/=np.maximum(np.linalg.norm(n,axis=1)[:,None],1e-9)
 shade=.58+.42*np.abs(n@np.array([-.5,.45,.74]))
 ax.add_collection3d(Poly3DCollection(t,facecolors=shade[:,None]*np.array(to_rgb(color)),edgecolors='none',rasterized=True))
def box(c,d):
 v=np.array([[a,b,z] for z in [-1,1] for b in [-1,1] for a in [-1,1]])*np.array(d)/2+np.array(c)
 return v[np.array([[0,1,3],[0,3,2],[4,6,7],[4,7,5],[0,4,5],[0,5,1],[2,3,7],[2,7,6],[0,2,6],[0,6,4],[1,5,7],[1,7,3]])]
def cylx(c,r,h):
 a=np.linspace(0,2*np.pi,49)
 lo=np.array([np.full(len(a),c[0]-h/2),c[1]+r*np.cos(a),c[2]+r*np.sin(a)]).T;hi=lo+[h,0,0];out=[]
 for j in range(48):out.extend([[lo[j],lo[j+1],hi[j]],[hi[j],lo[j+1],hi[j+1]],[[c[0]-h/2,c[1],c[2]],lo[j+1],lo[j]],[[c[0]+h/2,c[1],c[2]],hi[j],hi[j+1]]])
 return np.array(out)
def label(ax,p,txt,xy,color):
 x,y,_=proj3d.proj_transform(*p,ax.get_proj())
 ax.annotate(txt,xy=(x,y),xycoords='data',xytext=xy,textcoords='axes fraction',fontsize=11,weight='bold',va='center',color=color,arrowprops=dict(arrowstyle='-',color=color,lw=1),bbox=dict(facecolor='#f7f9fc',edgecolor='none',pad=2))
fig=plt.figure(figsize=(17,14),facecolor='#f7f9fc')
fig.text(.04,.962,'BOTH ARMS — ASSEMBLY FROM YOUR ACTUAL CAD',fontsize=24,weight='bold',color='#16324c')
fig.text(.04,.928,'Head assembly is separate. Keep the torso rear open while fitting the shoulder servos.',fontsize=14,color='#334155')
fig.text(.04,.902,'Printed arm shells and clamps below are exact CAD meshes; servo / horn shapes are illustrative.',fontsize=12,color='#334155')
for index,(side,sign) in enumerate([('Left',-1),('Right',1)]):
 ax=fig.add_axes([.015+index*.5,.365,.48,.51],projection='3d')
 front=mesh('06_'+side+'_arm_and_hand_front',sign);rear=mesh('06_'+side+'_arm_and_hand_rear',sign)
 clamp=mesh('07_'+side+'_horn_clamp',sign)
 draw(ax,front,'#ced9e4',(28,0,0));draw(ax,rear,'#a5bacd',(28,28,0));draw(ax,clamp,'#7965d4',(4,0,0))
 # Nominal SG90 case and output envelopes, from the existing CAD audit.
 draw(ax,box((13,-1,128),(22.8,22.4,12.5)),'#3d8cd5')
 draw(ax,box((21.3,-1,128),(2.4,32.4,12.5)),'#3d8cd5')
 draw(ax,cylx((27.4,4.2,128),6.25,6.02),'#3d8cd5');draw(ax,cylx((32.4,4.2,128),2.5,4.02),'#e6ebf0')
 # One short stock horn, exploded away from the printed clamp; arm points DOWN.
 draw(ax,cylx((44,4.2,128),3,1.5),'#f3ac43');draw(ax,box((44,4.2,121.5),(1.5,4,10)),'#f3ac43')
 ax.plot([32,72],[4.2,4.2],[128,128],'--',lw=1,color='#748297')
 ax.set_xlim(-5,83);ax.set_ylim(-21,61);ax.set_zlim(60,151)
 ax.set_box_aspect((88,82,91));ax.set_proj_type('ortho');ax.view_init(elev=23,azim=135);ax.set_axis_off()
 ax.set_title('CAD '+side.upper()+' ARM',fontsize=18,weight='bold',color='#16324c',pad=3)
 label(ax,(13,-1,128),'1  SERVO\ninside torso',(.02,.79),'#215d98')
 label(ax,(34,6,116),'2  CLAMP\nbody-facing side',(.01,.61),'#6551bb')
 label(ax,(44,4.2,120),'3  STOCK HORN\narm points DOWN',(.01,.44),'#975b07')
 label(ax,(64,1,91),'4  ARM FRONT',(.03,.16),'#3c546d')
 label(ax,(65,42,98),'5  REAR COVER',(.65,.19),'#3c546d')
fig.text(.04,.345,'Both viewed from the body side. Gaps enlarged. Left / Right follow CAD filenames; match pairs by shape.',fontsize=12,color='#334155')
fig.text(.04,.304,'1  CENTRE + MOUNT',fontsize=17,weight='bold',color='#16324c')
fig.text(.04,.273,'Centre each unloaded servo with its horn OFF.\nThen disconnect power.\n\nSeat each servo sideways in its torso cradle.\nShaft points OUT through the shoulder.\nSecure the case with narrow cable ties.\nKeep ties and wires clear of the shaft.',fontsize=12,va='top',linespacing=1.5)
fig.text(.365,.304,'2  BUILD EACH ARM',fontsize=17,weight='bold',color='#16324c')
fig.text(.365,.273,'Seat the original short horn in the arm pocket.\nHorn tip points DOWN toward the hand.\n\nDry-fit front + rear to align the clamp bosses.\nSecure the printed clamp with\n2 × M2.5 × 10 mm screws per arm.\nRear cover: 2 × M2.5 × 20 mm per arm.',fontsize=12,va='top',linespacing=1.5)
fig.text(.69,.304,'3  FIT + TEST',fontsize=17,weight='bold',color='#16324c')
fig.text(.69,.273,'Fit each arm with the hand pointing DOWN.\nUse the servo’s OWN centre screw\nthrough the OUTER shoulder access hole.\n\nKeep the small access plug removable.\nTest one arm at a time with a small slow lift.\nDo not run a full sweep after mounting.',fontsize=12,va='top',linespacing=1.5)
fig.text(.04,.055,'No glue on the shoulder bearing, horn, moving seam or removable covers. Tighten screws gently by hand.',fontsize=14,weight='bold',color='#ad3c1e')
fig.text(.04,.026,'Physical horn fit and servo zero still require checking. This guide does not mean the arm servos have been centred.',fontsize=11,color='#334155')
fig.savefig(root/'arms-assembly-cad.png',dpi=160,facecolor=fig.get_facecolor())
