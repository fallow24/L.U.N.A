#ifndef Q_AVE_H
#define Q_AVE_H

#include "ros/ros.h"
#include "sensor_msgs/Imu.h"
#include <fstream>
#include <string.h>
#include "sensor_msgs/LaserScan.h"
#include <fstream>
#include <sstream>
#include <math.h>
#include <tf/transform_listener.h>
#include <tf/transform_broadcaster.h>

bool qclose(tf::Quaternion, tf::Quaternion);

tf::Quaternion average(tf::Quaternion& q1, tf::Quaternion& q2, tf::Quaternion& q3) {
	float x = q1.x(), y = q1.y(), z = q1.z(), w = q1.w();
	//if(qclose(q1, q2)) q2 = -q2;
	x += q2.x(); y += q2.y(); z += q2.z(); w += q2.w();
	//if(qclose(q1, q3)) q3 = -q3;
	x += q3.x(); y += q3.y(); z += q3.z(); w += q3.w();
	x /= 3; y /= 3; z /= 3; w /= 3;
}

bool qclose(tf::Quaternion q1, tf::Quaternion q2) {
	if (q1.dot(q2) < 0.0) return false;
	else return true; 
}

#endif //Q_AVE_H
