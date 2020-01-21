#include "qave.hpp"
#include "tf/transform_listener.h"

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
tf::TransformListener *listener;

int main(int argc, char **argv) {                                                                                                                                                                         
        ROS_INFO("[%s]",argv[argc-1]);                                                                                                                                                       
        
        /* Set quiet mode */ 
        if(strcmp(argv[argc-1],"-q")==0) {                                                                                                                                                    
                quietmode=true;                                                                                                                                                                     
                argc--;
        }
        
        /* Initialize ROS node handler */
        ros::init(argc, argv, "imu_listener");                                                                                                                                               
        ros::NodeHandle n;
	listener = new tf::TransformListener();                                                                                                                                                                   
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

tf::Quaternion q_bottom, q_bottom_tf;
tf::Quaternion q_front;//, q_front_tf;

geometry_msgs::QuaternionStamped q_front_tf;

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
		wy = msg->angular_velocity.z;
		q_bottom = tf::Quaternion(msg->orientation.x, msg->orientation.y, msg->orientation.z, msg->orientation.w);
	        ROS_INFO("BOT.: [%f][%f][%f][%f]", q_bottom.x(), q_bottom.y(), q_bottom.z(), q_bottom.w());
	}
	// IMU 3: FRONT IMU
	else if(strcmp(msg->header.frame_id.c_str(), "imu3") == 0)
	{
  		wz = msg->angular_velocity.z;
		q_front = tf::Quaternion(msg->orientation.x, msg->orientation.y, msg->orientation.z, msg->orientation.w);
		tf::StampedTransform tf; 
		while(true) {
			try { 
				geometry_msgs::QuaternionStamped q_stamped;
				q_stamped.header = msg->header;
				q_stamped.quaternion = msg->orientation;
				listener->transformQuaternion("/imu2", ros::Time(0), q_stamped, "/odom" , q_front_tf);
				break;
			} catch (tf::TransformException ex) {
				ROS_ERROR("%s", ex.what());
				continue;
			}
		}
		ROS_INFO("FRNT: [%f][%f][%f][%f]", q_front_tf.quaternion.x, q_front_tf.quaternion.y, q_front_tf.quaternion.z, q_front_tf.quaternion.w);
	}

	if(!quietmode) 
        	ROS_INFO("Combined Velocity  x: [%f], y: [%f], z: [%f]", wx, wy, wz);

	// Average orientation
        //tf::Quaternion q_ave = average(q_side, q_bottom, q_front);	
	
        /* Create msgSend to be published */ 
        sensor_msgs::Imu msgSend;

        /* Fill msg header */ 
        msgSend.header.stamp = ros::Time::now();
        msgSend.header.frame_id = "/base_link";


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
        if(!quietmode){
                ROS_INFO("Got Information");
                ROS_INFO("Imu Name: [%s]", msg->header.frame_id.c_str());
                ROS_INFO("Imu Seq: [%d]", msg->header.seq);
                ROS_INFO("Imu Orientation x: [%f], y: [%f], z: [%f], w: [%f]", msg->orientation.x,msg->orientation.y,msg->orientation.z,msg->orientation.w);

		ROS_INFO("Imu Name: [%s]", msg->header.frame_id.c_str());

        }
}
