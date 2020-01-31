#include "ros/ros.h"
#include "std_msgs/String.h"
#include "sensor_msgs/Imu.h"
#include "geometry_msgs/Vector3.h"
#include <pigpio.h>
#include <stdio.h>
#include <sstream>

//How fast should we go (motor throttle)?
// Positive = forwards
// Negative = backwards
int throttle = 0;
const int PWM_RANGE = 2000;
const int PWM_FREQUENCY = 50;
const double MAX_ROT_SPEED = 3.5;
//Current pwm values required for diff calculation
int curr_pwm_values[2] = {100,100};
geometry_msgs::Vector3* curr_ang_vel = new geometry_msgs::Vector3();
//Constants
const int PIN1 = 18;
const int PIN2 = 23;

/*Requiredd Subfunction declaration*/


//start procedure
int start_procedure(int pin_1, int pin_2);

//Arms the ESC
void init_esc(int pin);

//Computes the pwm values for both motors
//given a vehicle throttle precentage
int* throttle2pwmValues(int throttle);

//Transfers the pwm value smoothly
//for each 1% of throttle it takes 0.5s
void transfer_pwm(int pin_1, int pin_2, int curr_pwm_value, int new_pwm_value);

//Called when pwm - data from the const pub is available
void pwmValCallback(const std_msgs::String::ConstPtr& msg)
{
  const char* num = msg->data.c_str();
  throttle = std::stoi(num,nullptr,10);

    int * pwmValues = throttle2pwmValues(throttle);
    transfer_pwm(PIN1,PIN2,curr_pwm_values[0],0);
    curr_pwm_values[0] = pwmValues[0];
    curr_pwm_values[1] = pwmValues[1];
  return;
}

void imuDataCallback(const sensor_msgs::Imu msg)
{
 curr_ang_vel->x = msg.angular_velocity.x;
 curr_ang_vel->y = msg.angular_velocity.y;
 curr_ang_vel->z = msg.angular_velocity.z;
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
  ros::Subscriber sub_pwm = n.subscribe("pwm_const", 1000, pwmValCallback);
  ros::Subscriber sub_ang_vel = n.subscribe("imu1/data",1000,imuDataCallback);

  /*Init Gpio Pins*/
  if(gpioInitialise() < 0) return 1;
  gpioSetPWMfrequency(PIN1,PWM_FREQUENCY);
  gpioSetPWMfrequency(PIN2,PWM_FREQUENCY);

  gpioSetPWMrange(PIN1,PWM_RANGE);
  gpioSetPWMrange(PIN2,PWM_RANGE);

  init_esc(PIN1);
  init_esc(PIN2);

  ROS_INFO("Starting main programm.");
  while(ros::ok())
  {
    ros::spinOnce();
  }

  //When shutdown set pwm out to 0;
  transfer_pwm(PIN1,PIN2,curr_pwm_values[0], throttle2pwmValues(0)[0]);
  return 0;
}

void init_esc(int pin)
{
   ROS_INFO("Duty cycle 0%% at pin %d.", pin);
   gpioPWM(pin, PWM_RANGE*0.05);
   gpioDelay(5000);
   ROS_INFO("Attach Motor Now! Wait for beeping sound -> should be armed");
   return;
}

int* throttle2pwmValues(int throttle)
{
  int* pwmValues = new int[2];
  //Lowest pulse width 0% == 1 ms

  // Throttle == Throttle of one motor.
  pwmValues[0] = PWM_RANGE*0.05 + throttle/100.0*PWM_RANGE*0.05;
  pwmValues[1] = PWM_RANGE*0.05 + throttle/100.0*PWM_RANGE*0.05;

  return pwmValues;
}

void transfer_pwm(int pin_1, int pin_2, int curr_pwm_value, int new_pwm_value)
{
    ROS_INFO("Writing following pwm: %d to pin %d", curr_pwm_value, pin_1);
    gpioPWM(pin_1,curr_pwm_value);
    ROS_INFO("Writing following pwm: %d to pin %d", curr_pwm_value, pin_2);
    gpioPWM(pin_2,curr_pwm_value);
}

