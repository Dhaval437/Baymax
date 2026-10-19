from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon
from mpl_toolkits.mplot3d.art3d import Poly3DCollection
import generate as model

fig=plt.figure(figsize=(11,6),facecolor='white')
ax=fig.add_subplot(121,projection='3d')
ax.add_collection3d(Poly3DCollection([[model.vertices[i] for i in f] for f in model.faces],
    facecolors='#79b4cc',edgecolors='none',alpha=1))
ax.set(xlim=(-5,5),ylim=(-5,5),zlim=(0,14));ax.set_box_aspect((10,10,14))
ax.view_init(elev=23,azim=-48);ax.set_axis_off();ax.set_title('Round adapter - external view',fontsize=13)
ax2=fig.add_subplot(122)
section=[(-4,0),(-2.5,0),(-2.5,3),(2.5,3),(2.5,0),(4,0),(4,10),(2.5,10),(2.5,13),(-2.5,13),(-2.5,10),(-4,10)]
ax2.add_patch(Polygon(section,facecolor='#b8d9e6',edgecolor='#20516a',linewidth=1.5))
ax2.plot([0,0],[-1,14],color='#888888',ls='--',lw=.7)
def dim(a,b,label,where):
 ax2.annotate('',xy=a,xytext=b,arrowprops={'arrowstyle':'<->','color':'#263744'})
 ax2.text(*where,label,fontsize=10,ha='center',va='center',color='#263744')
dim((5,0),(5,10),'Body\n10 mm',(6.7,5))
dim((-2.5,14),(2.5,14),'Male diameter 5 mm',(0,15))
dim((-2.5,-1),(2.5,-1),'Female diameter 5 mm',(0,-2))
ax2.annotate('Hole depth 3 mm',xy=(1.5,2.8),xytext=(-8,4.5),fontsize=10,
 arrowprops={'arrowstyle':'->','color':'#263744'})
ax2.annotate('Peg length 3 mm\n(assumed)',xy=(2.5,11.5),xytext=(4,12.6),fontsize=10,
 arrowprops={'arrowstyle':'->','color':'#263744'})
ax2.set(xlim=(-9,10),ylim=(-3,16));ax2.set_aspect('equal');ax2.axis('off')
ax2.set_title('Section view - dimensions in mm',fontsize=13)
fig.suptitle('Baymax arm extension | 10 mm body | 5 mm male / female | print 2 copies',fontsize=16,y=.97)
fig.text(.5,.05,'Smooth round fit prototype - no servo spline teeth. Total length: 13 mm. Body diameter: 8 mm.',ha='center',fontsize=10)
fig.subplots_adjust(top=.86,bottom=.14,wspace=.06)
fig.savefig(Path(__file__).with_name('adapter_dimensions.png'),dpi=170)

