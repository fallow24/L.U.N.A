import numpy as np
from matplotlib import pyplot as plt

data = np.loadtxt("ang_vel.txt",comments="%",delimiter=",")

# Normalizing time to start at t = 0
t0 =data[0,0]
time = [(t - t0)/10**9 for t in data[:,0]]
# Extracting each component array
x = data[:,1]
y = data[:,2]
z = data[:,3]

fig = plt.figure()
plt.plot(time,x,time,y,time,z,linewidth=0.35)
plt.legend(["x","y","z"])
plt.xlabel("Time [s]")
plt.ylabel("Angular Acceleration")
plt.grid(True)
plt.savefig("ang-vel.eps", format="eps")
plt.show()
