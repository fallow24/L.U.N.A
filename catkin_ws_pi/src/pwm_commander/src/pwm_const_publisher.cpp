#include "ros/ros.h"
#include "std_msgs/String.h"
#include "threshold.hpp"
#include <stdio.h>
#include <sstream>

//! Desired value of PWM signal
int PWM = 0;

//! Current value of PWM signal 
int currentPWM = 0;

/*!
 * Different modes for the controller can be used. Those are: <br>
 *   d [value] = "Direct feedthrough mode" <br>
 *   s [value] = "Smooth increase / decrease to given value" <br>
 *   x [1/2/3] = "Start sequence 1, 2 or 3" <br>
 *   v [1/0]   = "Switch vibrartion controller on (1)/off (0)" <br>  
 * Some parameters can also be set: <br>
 *   m [value] = "Set smoothnessfactor" <br>
 *   t [value] = "Set vibration deviation threshold" <br>   
 */
char mode = 'd';

/*! 
 * True if vibration controller is active <br> 
 * The vibration controller should reduce the vibrations induced by the rotating masses.
 */ 
bool vibCon = 0;

/*! 
 * True if strong vibrations occured in within the last few measurements. <br> 
 * The controller will go in hysterese-mode, which means that the rotation of the masses <br> 
 * will be slowed down until less vibration is measured.
 */ 
bool hysterese = false;

//! Counting variable for the controller.
int loopCount = 0;

//! Only needed in mode 's'. This is the number of cycles needes per change (5 = 0.5 seconds)
int smoothnessFactor = 5;

//! Upper vibration threshold (value is standard deviation) 
int vibThreshold = 8;

/*!
 * Lower vibration threshold (value is standard deviation) <br> 
 * If the standard deviation is comes below this value while being in hysterese mode, 
 * the hysterese mode will be deactivated.
 */
int vibThreshold2 = 5;

//! Deviation of 30 values (sliding window) of the x-axis of the accelerometer 
Deviation s_x(30);

//! Deviation of 30 values (sliding window) of the y-axis of the accelerometer
Deviation s_y(30);

//! Deviation of 30 values (sliding window) of the z-axis of the accelerometer
Deviation s_z(30);

//! [UNUSED VARIABLE!] Rotation speed around x axis of the sphere (which is the forward direction)
double rot_vel;

/*! 
 * (optional) Deviation publisher for debugging reasons. <br> 
 * Listen to /deviation topic to see Deviation values.
 */
ros::Publisher deviation_publisher;

/*! 
 * Reads commands as described in the "mode" variable. <br>
 * Sets the controller to specific mode. <br>
 * Subscribes to /pwm_call (which is published by pwm_reader node)
 */ 
void newPwmEntryCallback(const std_msgs::String::ConstPtr& msg)
{	
	const char* command = msg->data.c_str();
	ROS_INFO("[%s]", command);
	if(sizeof(command)<3) {
		ROS_INFO("Invalid Message");
		return;
	}
	char* cTemp = (char*) calloc(sizeof(command), sizeof(char));
	memcpy(cTemp, command, sizeof(command));
	char modeTemp = cTemp[0];
	cTemp++;
	cTemp++;
	int value = std::stoi(cTemp);
	ROS_INFO("Entering Mode %c with value %d",modeTemp,value );

	cTemp--;
	cTemp--;
	free(cTemp);
	switch(modeTemp) {
		case 'd': 
			loopCount =0;
			PWM = value;
			mode ='d';
			break;

		case 's':
			mode ='s';
			PWM = value;
			break;
		case 'v':
			if(value==1) {
				vibCon = 1;
			}
			else if(value ==0) {
				vibCon = 0;
			}
			else {
				ROS_INFO("v only with 0 and 1");}
			break;
		case 'm':
			if (value < 1) {
				break;
			}
			smoothnessFactor=value;
			break;
		case 't':
			if(value<1) break;
			vibThreshold = value;
			break;
		case 'l':	
			vibThreshold2 = value;
			break; 
	} 
}

//! Listens to one IMU and calculates the standard Deviation of the accelerometer in 3 axes <br>
void imuCallback(const sensor_msgs::Imu::ConstPtr& msg) {
	s_x.put(msg->linear_acceleration.x);
	s_y.put(msg->linear_acceleration.y);
	s_z.put(msg->linear_acceleration.z);
	
	/* Optional Part, only for debugging reasons */
	geometry_msgs::Vector3 v;
	std::stringstream ss;
		
	v.x = s_x.get();
	v.y = s_y.get();
	v.z = s_z.get();

	deviation_publisher.publish(v);        
}

/*! 
 * Listens to the angular velocity around the forward direction of the sphere <br> 
 * Saves the angular velocity into "rot_vel" variable, which is currently unused. <br>
 * In future work, this could be used to increase the vibration controller performance.
 */ 
void velCallback(const sensor_msgs::Imu::ConstPtr& msg) {
	rot_vel = msg->angular_velocity.x;
}

int main(int argc, char **argv)
{
  /*
  * Init Node.
  * This node recieves the input given by the user console and constantly 
  * publishes the most recent value in a constant time interval to 
  * the topic "pwm_const".
  */
  ros::init(argc, argv, "pwm_const_publisher");
  ros::NodeHandle n;
  /*Init Subscriber functionality*/
  ros::Subscriber sub = n.subscribe("pwm_call", 1000, newPwmEntryCallback);
  ros::Subscriber imu_sub = n.subscribe("imu2/data_raw", 1000, imuCallback);
  ros::Subscriber vel_sub = n.subscribe("imuMerged", 1000, velCallback); 
 
  /*Init Publisher functionality*/
  ros::Publisher pwm_const_pub = n.advertise<std_msgs::String>("pwm_const", 1000);
  deviation_publisher = n.advertise<geometry_msgs::Vector3>("deviation", 1000);

  ros::Rate loop_rate(10);

  /*while the ros node is running*/
  while (ros::ok())
  {
    std_msgs::String msg;
    std::stringstream ss;
	switch(mode) {
                case 'd':
			currentPWM = PWM;
                        break;
                case 's':
			if(loopCount >= smoothnessFactor) {
			    if(currentPWM < PWM) {
				currentPWM++;
			    } else if (currentPWM>PWM) {
				currentPWM--;
			    }
			    loopCount = 0;}
			else { 
			    loopCount++;
			}
                        break;
        }

    if(vibCon == 1) {
	if (!hysterese&&(s_x.get() >= vibThreshold || s_y.get() >= vibThreshold || s_z.get() >= vibThreshold)) {
		mode = 's';
		currentPWM= 14;
		hysterese=true;
	}else if(hysterese && (s_x.get() >= vibThreshold2 && s_y.get() >= vibThreshold2 && s_z.get() >= vibThreshold2)){
	currentPWM=14;
	}else if(hysterese){
	hysterese = false;
	}
	if(PWM<10) {
		currentPWM=PWM;
	}
    }
    ss<< currentPWM;
    msg.data = ss.str();
    
    pwm_const_pub.publish(msg);

    ros::spinOnce();
    loop_rate.sleep();
  }


  return 0;
 }
