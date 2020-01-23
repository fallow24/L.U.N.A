#include <ros/ros.h>
#include "std_msgs/String.h"
#include "sensor_msgs/Imu.h"
#include "sensor_msgs/LaserScan.h"
#include <fstream>
#include <sstream>
#include <math.h>
#include <tf/transform_listener.h>
#include <tf/transform_broadcaster.h>
#include "globals.icc"
 
std::ofstream output;
int file_num = 0;
tf::TransformListener *listener;

void getTransform(tf::StampedTransform &transform, double *t, double *ti, double *rP, double *rPT) {

    double mat[9];
    double x = transform.getOrigin().getX()*100;
    double y = transform.getOrigin().getY()*100;
    double z = transform.getOrigin().getZ()*100;
    mat[0] = transform.getBasis().getRow(0).getX();
    mat[1] = transform.getBasis().getRow(0).getY();
    mat[2] = transform.getBasis().getRow(0).getZ();

    mat[3] = transform.getBasis().getRow(1).getX();
    mat[4] = transform.getBasis().getRow(1).getY();
    mat[5] = transform.getBasis().getRow(1).getZ();

    mat[6] = transform.getBasis().getRow(2).getX();
    mat[7] = transform.getBasis().getRow(2).getY();
    mat[8] = transform.getBasis().getRow(2).getZ();

    t[0] = mat[4];
    t[1] = -mat[7];
    t[2] = -mat[1];
    t[3] = 0.0;
    t[4] = -mat[5];
    t[5] = mat[8];
    t[6] = mat[2];
    t[7] = 0.0;
    t[8] = -mat[3];
    t[9] = mat[6];
    t[10] = mat[0];
    t[11] = 0.0;

    //translation
    t[12] =  -y;
    t[13] =  z;
    t[14] =  x;
    t[15] = 1;
    M4inv(t, ti);
    Matrix4ToEuler(t, rPT, rP);
}


void LMSCallback(const sensor_msgs::LaserScan& msg){
  
  ROS_INFO("LMS Data received");

  //Get transformation from odom to lms
  tf::StampedTransform transform;
  try{
      listener->lookupTransform("/world", "/front_laser", ros::Time(msg.header.stamp), transform);
  }catch (tf::TransformException ex) {
      ROS_ERROR("%s",ex.what());
	  return;
  }
 
  ROS_INFO("Transformation listener OK");

  //Get translation and rotation
  double t[16];
  double ti[16];
  double rP[3], rPT[3];
  getTransform(transform, t, ti, rP, rPT);
  
  ROS_INFO("Transformation OK");

  if (isnan(rPT[1])){
	  ROS_ERROR("nan exception");
	  return;
  }
  
  double xOrDe = (rPT[0] * 360) / (2 * M_PI);
  double yOrDe = (rPT[1] * 360) / (2 * M_PI);
  double zOrDe = (rPT[2] * 360) / (2 * M_PI);
  
  ROS_INFO("Opening file...");
 
  //Save translation and rotation
  std::string file_name = "/home/fabi/scan/scanfile";
  std::stringstream pos_num;
  if (file_num < 10){
    pos_num << "00";
  }else if (file_num < 100){
    pos_num << "0";
  }
  pos_num << file_num;
  file_name += pos_num.str() + ".pose";

  output.open(file_name.c_str());
  output << rP[0] << " " << rP[1] << " " << rP[2] << " ";
  output << xOrDe << " " << yOrDe << " " << zOrDe << "\n";
  
  ROS_INFO("writing...");

  output.flush();
  output.close();

  ROS_INFO("Opening new file...");

  //Iterate every angle and get every point
  int i = 0;
  file_name = "/home/fabi/scan/scanfile";
  file_name += pos_num.str() + ".3d";
  output.open(file_name.c_str());

  for(double angle=msg.angle_min; angle <= msg.angle_max; angle+=msg.angle_increment){
	ROS_INFO("Iteration: %d", i);
	double x = msg.ranges[i] * sin(angle);
	double z = msg.ranges[i] * cos(angle);
	double y = 0;
	x *= 100;
	z *= 100;
    i++;
    
    output << x << " " << y << " " << z << "\n";
    
  }
  ROS_INFO("Writing to file...");
  output.flush();
  ROS_INFO("done.");
  output.close();
  file_num++;

}

const double radius = 0.122; 
double last_time = 0;
tf::Vector3 velocity(0, 0, 0);
tf::Vector3 position(0, 0, 0);

void IMUCallback(const sensor_msgs::Imu::ConstPtr& msg){
		
	//Make angular velocity into a tf vector and rotate it into the real world frame
	tf::Quaternion q(msg->orientation.x, msg->orientation.y, msg->orientation.z, msg->orientation.w);
	tf::Matrix3x3 m_rot(q);
	tf::Vector3 angular_velocity(msg->angular_velocity.x, msg->angular_velocity.y, msg->angular_velocity.z);
	angular_velocity = (m_rot * angular_velocity);
	
	//Get velocity on xy plane
	velocity.setX(angular_velocity.getY() * radius);
	velocity.setY(-1.0 * angular_velocity.getX() * radius);
	
	//Get position integrating velocity
	double current_time = msg->header.stamp.sec + (msg->header.stamp.nsec * pow (10, -9));
	double time_diff = current_time - last_time;
	
	if (last_time != 0){
		position.setX(position.getX() + velocity.getX() * time_diff);
		position.setY(position.getY() + velocity.getY() * time_diff);
	}
	
	last_time = current_time;
	
	//Publish translation in ros::tf 
	static tf::TransformBroadcaster br;
	
	tf::Transform transform;
	transform.setOrigin(position);
	tf::Quaternion q2;
	q2.setRPY(0, 0, 0);
	transform.setRotation(q2);
	br.sendTransform(tf::StampedTransform(transform, ros::Time(msg->header.stamp), "/world", "/imu_base")); 
} 
 
int main(int argc, char** argv){

  ros::init(argc, argv, "point_cloud_node");

  ros::NodeHandle node;
  
  listener = new tf::TransformListener();

  ros::Subscriber sub_imu = node.subscribe("/imuMerged", 1000, &IMUCallback);
  ros::Subscriber sub_lms = node.subscribe("/scan", 1000, &LMSCallback);
  

  ros::spin();

  return 0;

};


