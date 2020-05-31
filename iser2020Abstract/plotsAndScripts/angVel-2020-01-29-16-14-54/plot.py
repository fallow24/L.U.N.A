import sys
import numpy as np
from matplotlib import pyplot as plt


FILENAME = "merged_ang_vel.txt"
if len(sys.argv) > 1:
    FILENAME = sys.argv[1]

DATA = np.loadtxt(FILENAME, comments="%", delimiter=",")

# Normalizing TIME To startart at T = 0
T_BEGIN = 20 # Experiment starts 40 seconds in
T_0 = DATA[0, 0]
TIME = np.array([(T - T_0)/10**9 for T in DATA[:, 0]])
WANTED_INDECES = np.where(TIME >= T_BEGIN)
# Extracting each component array
X = DATA[WANTED_INDECES, 1].flatten()
Y = DATA[WANTED_INDECES, 2].flatten()
Z = DATA[WANTED_INDECES, 3].flatten()
T = TIME[WANTED_INDECES]
AVG_DT = np.mean([abs(T[i]-T[i+1]) for i in range(len(T)-1)])

# Window size
WINDOW_SIZE = 500
# Sliding Window Average
X_AVG, Y_AVG, Z_AVG = [], [], []
for i in range(len(T)):
    n_l = int(WINDOW_SIZE/2 if i > WINDOW_SIZE/2\
					else i)
    n_r = int(WINDOW_SIZE/2 if len(T) - i > WINDOW_SIZE/2 \
					else (len(T)-i))
    X_AVG.append(np.mean(X[i-n_l:i+n_r]))
    Y_AVG.append(np.mean(Y[i-n_l:i+n_r]))
    Z_AVG.append(np.mean(Z[i-n_l:i+n_r]))

plt.figure()
plt.plot(T, X, 'C0', T, Y, 'C2', T, Z, 'C4', linewidth=0.5)
plt.plot(T, X_AVG, 'b--', T, Y_AVG, 'g--', T, Z_AVG, 'm--')
plt.ylim([-6,6])
plt.legend(["X", "Y", "Z", "X Average", "Y Average", "Z Average"],\
	loc='lower left')
plt.xlabel("TIME [s]")
plt.ylabel("Angular Velocity [°/s]")
plt.text(55, -5, "The average\nwas calculated\nusing a"\
	+ "rolling\nwindow average\nof size {0:.2f} s"\
	.format(WINDOW_SIZE*AVG_DT), bbox=dict(facecolor='white'))
plt.grid(True)
plt.savefig(FILENAME.split('.')[0] + ".png", format="png")
plt.show()
