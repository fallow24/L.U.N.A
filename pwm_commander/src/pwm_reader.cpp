#include "ros/ros.h"
#include "std_msgs/String.h"

#include <sstream>
#include <stdio.h>



bool is_number(const std::string& s);

int read_input();

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

    int value = read_input();

    /*Only accept valid percentage values*/
    if(value >= 0 && value <= 100)
    {
        std::stringstream ss;
        ss << value;
        msg.data = ss.str();

        ROS_INFO("%s", msg.data.c_str());
        pwm_pub.publish(msg);
        ros::spinOnce();
        loop_rate.sleep();
    }
    else
    {
      ROS_INFO("ERROR! Please choose value with 0 <= x <= 100.");
    }
  }
  return 0;
}

/*Checks whether a given string contains a number*/
bool is_number(const std::string& s) 
{
  return !s.empty() && std::find_if(s.begin(),
    s.end(), [](char c) { return !std::isdigit(c); }) == s.end();
}

/*Reads input from commandline. If input is nan it return -1.*/
int read_input()
{

  int value;

  std::string num;
  std::getline(std::cin, num);
  if(!is_number(num)) {
    std::cout << "Input is not a number , enter again: ";
    value = -1;
  }
  else
  {
    value = std::stoi(num,nullptr,10);
  }

  return value;
}
