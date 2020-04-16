import numpy as np
from matplotlib import pyplot as plt

data = np.loadtxt("ang_vel.txt",comments="%",delimiter=",")

# Normalizing time to start at t = 0
t_begin = 40 # Experiment starts 40 seconds in
t0 =data[0,0]
time = np.array([(t - t0)/10**9 for t in data[:,0]])
wanted_indeces =np.where(time >= t_begin)
# Extracting each component array
x = data[wanted_indeces,1].flatten()
y = data[wanted_indeces,2].flatten()
z = data[wanted_indeces,3].flatten()
t = time[wanted_indeces]
avg_dt = np.mean([abs(t[i]-t[i+1]) for i in range(len(t)-1)])

# Window size
window_size = 500
# Sliding Window Average
x_avg, y_avg, z_avg = [], [], []
for i in range(len(t)):
	n = window_size if len(t) - i > window_size \
					else (len(t)-i)
	x_avg.append(np.mean(x[i:i+n]))
	y_avg.append(np.mean(y[i:i+n]))
	z_avg.append(np.mean(z[i:i+n]))

fig = plt.figure()
plt.plot(t,x,'C0',t,y,'C2',t,z,'C4',linewidth=0.5)
plt.plot(t,x_avg,'b--',t,y_avg,'g--',t,z_avg, 'm--')
plt.legend(["x","y","z","x Average", "y Average", "z Average"],\
	loc='lower left')
plt.xlabel("Time [s]")
plt.ylabel("Angular Velocity [°/s]")
plt.text(39, 0.75,"The average\nwas calculated\nusing a"\
	+ "rolling\nwindow average\nof size {0:.2f} s"\
	.format(window_size*avg_dt), bbox=dict(facecolor='white'))
plt.grid(True)
plt.savefig("ang-vel.eps", format="eps")
plt.show()
