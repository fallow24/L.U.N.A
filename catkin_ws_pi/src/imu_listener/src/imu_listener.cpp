#include "tf/transform_listener.h"

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

#define r2d(r) ((r) * 180.0 / M_PI)
#define d2r(d) ((d) * M_PI / 180.0)

using std::ofstream;
using std::cout;
using std::endl;

void chatterCallback(const sensor_msgs::Imu::ConstPtr& msg);

// rotation speeds
double wx;
double wy;
double wz;

bool quietmode = false;

ros::Publisher pub;

int main(int argc, char **argv) {

        /* Set quiet mode */
        if(strcmp(argv[argc-1],"-q")==0) {
                quietmode=true;
                argc--;
        }

        /* Initialize ROS node handler */
        ros::init(argc, argv, "imu_listener");
        ros::NodeHandle n;
	ROS_INFO("Starting IMU subscriber\n");

        /* Init ROS subscriber that listens to all 3 IMU data*/
        ros::Subscriber sub1 = n.subscribe("imu1/data", 5000, chatterCallback);
        ros::Subscriber sub2 = n.subscribe("imu2/data", 5000, chatterCallback);
        ros::Subscriber sub3 = n.subscribe("imu3/data", 5000, chatterCallback);

        /* Init ROS publisher with topic "imuMerged" */
        pub = n.advertise<sensor_msgs::Imu>("imuMerged", 5000);

        ros::spin();
        return 0;
}

tf::Quaternion q_bottom;

void chatterCallback(const sensor_msgs::Imu::ConstPtr& msg)
{

        /* Combine Sensor Data of every IMU into the "virtual" IMU */
        // IMU 1: SIDE IMU
	if(strcmp(msg->header.frame_id.c_str(), "imu1") == 0) 
	{
	        wx = msg->angular_velocity.z;
	}
	// IMU 2: BOTTOM IMU
	else if(strcmp(msg->header.frame_id.c_str(), "imu2") == 0)
	{
		wz= msg->angular_velocity.z;
		q_bottom = tf::Quaternion(msg->orientation.x, msg->orientation.y, msg->orientation.z, msg->orientation.w);
        }
	// IMU 3: FRONT IMU
	else if(strcmp(msg->header.frame_id.c_str(), "imu3") == 0)
	{
  		wy = msg->angular_velocity.z;
		//q_front = tf::Quaternion(msg->orientation.x, msg->orientation.y, msg->orientation.z, msg->orientation.w);
	}

	if(!quietmode) ROS_INFO("Combined Velocity  x: [%f], y: [%f], z: [%f]", wx, wy, wz);

        /* Create msgSend to be published */ 
        sensor_msgs::Imu msgSend;

        /* Fill msg header */ 
        msgSend.header.stamp = ros::Time::now();
        msgSend.header.frame_id = "/imu_base";


        /* Fill msg data */ 
        msgSend.angular_velocity.x = wx;
        msgSend.angular_velocity.y = wy;
        msgSend.angular_velocity.z = wz;
	msgSend.orientation.x = q_bottom.x();
        msgSend.orientation.y = q_bottom.y();
	msgSend.orientation.z = q_bottom.z();
	msgSend.orientation.w = q_bottom.w();

        /* Publish the data */ 
        pub.publish(msgSend);

        /* ROS Output (supress if quietmode) */ 
        if(!quietmode) {
                ROS_INFO("Got Information");
                ROS_INFO("Imu Name: [%s]", msg->header.frame_id.c_str());
                ROS_INFO("Imu Seq: [%d]", msg->header.seq);
                ROS_INFO("Imu Orientation x: [%f], y: [%f], z: [%f], w: [%f]", msg->orientation.x,msg->orientation.y,msg->orientation.z,msg->orientation.w);
		ROS_INFO("Imu Name: [%s]", msg->header.frame_id.c_str());
        }
}
