#include "ros/ros.h"
#include "std_msgs/String.h"

#include <stdio.h>
#include <sstream>


int PWM = 0;

void newPwmEntryCallback(const std_msgs::String::ConstPtr& msg)
{
  const char* num = msg->data.c_str();
  ROS_INFO("[%s]", num);
  PWM = std::stoi(num,nullptr,10);
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
  /*Init Publisher functionality*/
  ros::Publisher pwm_const_pub = n.advertise<std_msgs::String>("pwm_const", 1000);
  ros::Rate loop_rate(10);

  /*while the ros node is running*/
  while (ros::ok())
  {
    std_msgs::String msg;
    std::stringstream ss;

    ss << PWM;
    msg.data = ss.str();
    
    pwm_const_pub.publish(msg);

    ros::spinOnce();
    loop_rate.sleep();
  }


  return 0;
}