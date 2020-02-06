#include "ros/ros.h"
#include "std_msgs/String.h"
#include <regex>
#include <sstream>
#include <stdio.h>


//! Checks if a string is a number.
bool is_number(const std::string& s);

//! Reads input from commandline. If input is nan it return -100.
std::string read_input();

int main(int argc, char **argv)
{

  /*
  *  Initializing Node and its topic.
  *  This node read pwm percentage values from the command line
  *  and publishes them to the topic "pwm_call".
  */
  ros::init(argc, argv, "pwm_reader");
  ros::NodeHandle n;
  ros::Publisher pwm_pub = n.advertise<std_msgs::String>("pwm_call", 1000);
  ros::Rate loop_rate(10);

    

  /*while the ros node is running*/
  while (ros::ok())
  {
    std_msgs::String msg;

    std::string value = read_input();
    
    // Matches an alphabetic character in first group, and multiple digits in second group 
    std::regex reg("\\s*([^\\d\\s])\\s+(\\d+)");
    std::smatch matches; 

    /*Only accept valid percentage values and 1 for startup procedure*/
    if(std::regex_search(value, matches, reg))
    {
	std::string mode = matches[1].str();
        int val = std::stoi(matches[2].str());

        std::stringstream ss;
        ss << mode << " " << val;
        msg.data = ss.str();

        ROS_INFO("Mode: %s with value %d", mode.c_str(), val);
        pwm_pub.publish(msg);
        ros::spinOnce();
        loop_rate.sleep();
    }
    else
    {
      ROS_INFO("Usage: [mode] [value]");
      ROS_INFO("Example: $ d 20"); 
    }
  }
  return 0;
}

std::string read_input()
{
  std::string num;
  std::getline(std::cin, num);
  return num;
}
