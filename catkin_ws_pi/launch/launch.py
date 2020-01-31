#! /usr/bin/python

import subprocess
	
# starting all IMUS
subprocess.Popen(["roslaunch", "imu1.launch"])
subprocess.Popen(["roslaunch", "imu2.launch"])
subprocess.Popen(["roslaunch", "imu3.launch"])
#subprocess.Popen(["roslaunch","lms100info7.launch"])
subprocess.Popen(["roslaunch", "lmslaunch.launch"])

# starting the IMU merge node in quiet mode
subprocess.Popen(["rosrun", "imu_listener", "imu_listener", "-q"])
#subprocess.Popen(["rosrun", "pwm_commander", "pwm_reader"])
#subprocess.Popen(["rosrun", "pwm_commander", "pwm_const_publisher"])
#subprocess.Popen(["rosrun", "pwm_commander", "high_res_pwm_to_pin"])
