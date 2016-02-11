#include "ros/ros.h"
#include "std_msgs/String.h"
#include <wiringPi.h>
#include <softPwm.h>
#include <stdio.h>
#include <sstream>

//How fast should we go (motor throttle)?
// Positive = forwards
// Negative = backwards
int throttle = 0;

//Current pwm values required for diff calculation
int curr_pwm_values[2] = {100,0};

//Constants
const int PIN1 = 12;
const int PIN2 = 16;
const int PWM_RANGE = 2000;

/*Required Subfunction declaration*/
//Arms the Motors, i.e. sets pwm position to 0%
void init_motor(int pin_number);

//Computes the pwm values for both motors
//given a vehicle throttle precentage
int* throttle2pwmValues(int throttle);

//Forces the pwm change to be smoother, i.e. for every
//10% of motor throttle it takes 0.5 s
void pwm_transition(int pin, int new_pwm_value, int curr_pwm_value);

//Called when pwm - data from the const pub is available
void pwmValCallback(const std_msgs::String::ConstPtr& msg)
{
  const char* num = msg->data.c_str();
  throttle = std::stoi(num,nullptr,10);
  int* pwmValues = throttle2pwmValues(throttle);
  pwm_transition(PIN1, pwmValues[0],curr_pwm_values[0]);
  pwm_transition(PIN2, pwmValues[1],curr_pwm_values[1]);
  curr_pwm_values[0] = pwmValues[0];
  curr_pwm_values[1] = pwmValues[1];

  return;
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
  //WiringPi Values
  wiringPiSetupPhys();
  softPwmCreate(PIN1,0,PWM_RANGE);
  softPwmCreate(PIN2,0,PWM_RANGE);

  /*Arm Motors*/
  init_motor(PIN1);
  init_motor(PIN2);

  ROS_INFO("Starting main programm.");
  while(ros::ok())
  {
    ros::spinOnce();
  }

  return 0;
}

void init_motor(int pin_number)
{
   ROS_INFO("Duty Cycle = 0%%");
   softPwmWrite(pin_number,PWM_RANGE*0.05);
   ROS_INFO("Connect Motor Now...");
   delay(5000);
   ROS_INFO("Listen for 'BEEEP---BEEEP. Should be armed.'");
}

int* throttle2pwmValues(int throttle)
{
  int* pwmValues = new int[2];
  //First Wheel always runs at a given value 50% == 1.5 ms pulse length,
  //Second Wheel is slowed down to increase overall throttle,
  //Lowest pulse width 0% == 1 ms

  // For actual Motors: throttle == throttle of vehicle
  //pwmValues[0] = 1.5 * PWM_RANGE*0.05;
  //pwmValues[1] = 1.5 * PWM_RANGE*0.05 - throttle/100.0 * (PWM_RANGE*0.05);

  // For testing with one motor: Throttle == Throttle of one motor.
  pwmValues[0] = PWM_RANGE*0.05 + throttle/100.0*PWM_RANGE*0.05;
  pwmValues[1] = 0;

  return pwmValues;
}

void pwm_transition(int pin, int new_pwm_value, int curr_pwm_value)
{
  int d_pwm = (new_pwm_value - curr_pwm_value)/10;
  if(d_pwm == 0)
  {
    ROS_INFO("Writing follwing pwm: %d to pin %d", curr_pwm_value, pin);
    softPwmWrite(pin,curr_pwm_value);
  }
  else
  {
     //For each pwm step difference we take half a second
     for(int i = 0; i <= std::abs(d_pwm); i++)
     {
       //Depending on whether we reduce or increase pwm the transition has to
       //be adjusted as well
       int write_val = d_pwm < 0 ? (curr_pwm_value - i*10):(curr_pwm_value + i*10);
       ROS_INFO("Writing follwing pwm: %d to pin %d", write_val, pin);
       softPwmWrite(pin,write_val);
       delay(500);
     }
  }
  return;
}
