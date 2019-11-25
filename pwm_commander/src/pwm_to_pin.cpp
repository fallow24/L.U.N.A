#include "ros/ros.h"
#include "std_msgs/String.h"

#include <stdio.h>
#include <sstream>

int PWM = 0;

void pwmValCallback(const std_msgs::String::ConstPtr& msg)
{
  const char* num = msg->data.c_str();
  PWM = std::stoi(num,nullptr,10);
}

int main(int argc, char **argv)
{
  /*
  * Init Node.
  * This node recieves the constantly published values of topic 
  * "pwm_const" and puts them on the desired GPIO pin.
  */
  ros::init(argc, argv, "pwm_to_pin");
  ros::NodeHandle n;
  /*Init Subscriber functionality*/
  ros::Subscriber sub = n.subscribe("pwm_const", 1000, pwmValCallback);
  
  while(ros::ok())
  {
    ROS_INFO("Putting PWM %d on Pin", PWM);
    //TODO actually putting PWM on pin
    ros::spinOnce();
  }

  return 0;
}