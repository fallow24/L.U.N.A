#include "ros/ros.h"
#include "std_msgs/String.h"
# include <wiringPi.h>
#include <stdio.h>
#include <sstream>

int PWM = 0;
//Constants
const int PIN = 12;
const long BASE_FREQ = 19600000; //19.6*10^6 Hz
const int RANGE_VALUE = 200;
const int CLOCK_DIVISOR = 1920;

/*Required Subfunction declaration*/
void init_motor(int pin_number);
int percent2ticknumber(double percent_value);

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
  
/*Init wiringPi functionality*/
//WiringPi Vlaues
wiringPiSetupPhys();
pwmSetMode(PWM_MODE_MS);
pwmSetRange(RANGE_VALUE);
pwmSetClock(CLOCK_DIVISOR);
pinMode(PIN,PWM_OUTPUT);

  while(ros::ok())
  {
    
    
     int cor_value = percent2ticknumber(PWM/100.0);   
     pwmWrite(PIN,cor_value);
     ROS_INFO("Putting %d ticks on Pin", cor_value);
     ros::spinOnce();
  }

  return 0;
}

void init_motor(int pin_number)
{
   std::cout << "Duty Cycle = 0%" << std::endl; 
   pwmWrite(pin_number,percent2ticknumber(0));
   std::cout << "Connect Motor Now..." << std::endl; 
   delay(5000);
   std::cout<< "...Continuing" <<std::endl;
   
   std::cout << "Duty Cycle = 100%" << std::endl; 
   pwmWrite(pin_number,percent2ticknumber(1.0));
   delay(5000);
   std::cout<< "...Continuing" <<std::endl;
   
   std::cout << "Duty Cycle = 50%" << std::endl; 
   pwmWrite(pin_number,percent2ticknumber(0.5));
   delay(5000);
   std::cout<< "...Continuing" <<std::endl;
}

int percent2ticknumber(double percent_value)
{
  int ticks_per_ms = (BASE_FREQ/CLOCK_DIVISOR)/1000.0;
  //int tick_number = (ticks_per_ms + percent_value*ticks_per_ms); 
  //return tick_number;
  return int(20*ticks_per_ms*percent_value);
}


