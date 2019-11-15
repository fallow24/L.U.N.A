#include "ros/ros.h"
#include "sensor_msgs/Imu.h"
#include <fstream>
#include <string.h>
using std::ofstream;
using std::cout;
using std::endl;

void chatterCallback(const sensor_msgs::Imu::ConstPtr& msg);

double xAcc;
double yAcc;
double zAcc;

bool quietmode = false;     

/* Publisher to publish combined IMU data for virtual IMU */ 
ros::Publisher pub;                                                                                                                                                                          

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
        ROS_INFO("Starting IMU subscriber\n");
        
        /* Init ROS subscriber that listens to all 3 IMU data*/ 
        ros::Subscriber sub = n.subscribe("imu/data", 1000, chatterCallback);
        
        /* Init ROS publisher with topic "imuMerged" */ 
        pub = n.advertise<sensor_msgs::Imu>("imuMerged", 1000);

        ros::spin();
        return 0;
}

void chatterCallback(const sensor_msgs::Imu::ConstPtr& msg)
{
        /* Combine Sensor Data of every IMU into the "virtual" IMU */
        if(strcmp(msg->header.frame_id.c_str(),"imu1"))
                xAcc= msg->angular_velocity.z;
        else if(strcmp(msg->header.frame_id.c_str(),"imu2"))
                yAcc= msg->angular_velocity.z;
        else if(strcmp(msg->header.frame_id.c_str(),"imu3"))
                zAcc= msg->angular_velocity.z;

        ROS_INFO("Combined Velocity  x: [%f], y: [%f], z: [%f]",xAcc,yAcc,zAcc);

        /* Create msgSend to be published */ 
        sensor_msgs::Imu msgSend;

        /* Fill msg header */ 
        msgSend.header.stamp = ros::Time::now();
        msgSend.header.frame_id = "/base_link";

        /* Fill msg data */ 
        msgSend.angular_velocity.x=xAcc;
        msgSend.angular_velocity.y=yAcc;
        msgSend.angular_velocity.z=zAcc;

        /* Fill accelerometer of msg with 0 (if needed) */ 
        //msgSend.linear_acceleration.x=0;
        //msgSend.linear_acceleration.y=0;
        //msgSend.linear_acceleration.z=0;

        /* Publish the data */ 
        pub.publish(msgSend);

        /* ROS Output (supress if quietmode) */ 
        if(!quietmode){
                ROS_INFO("Got Information");
                ROS_INFO("Imu Name: [%s]", msg->header.frame_id.c_str());
                ROS_INFO("Imu Seq: [%d]", msg->header.seq);
                ROS_INFO("Imu Orientation x: [%f], y: [%f], z: [%f], w: [%f]", msg->orientation.x,msg->orientation.y,msg->orientation.z,msg->orientation.w);
        }
}
 
