/**
  * Example use:
  *
1 * Deviation deviation(5); //buffers up to 5 values
2 * deviation.put(2.312);
3 * deviation.put(M_PI);
4 * deviation.put(0);
5 * double s = deviation.get(); 
  *
  */

#ifndef THRESHOLD_HPP
#define THRESHOLD_HPP

#include "ros/ros.h"
#include "sensor_msgs/Imu.h"
#include <deque>
#include <math.h>

#define SQR(n) ((n)*(n))

using namespace std;

class Deviation {

private:
	int buffer_size;
	deque<double> buffer;		
	double value;

	double m; //mean

	void add(double elem) {
		buffer.push_back(elem);
		if (buffer.size() > buffer_size)
			buffer.pop_front();
		calc_deviation(); 	
	}

	double mean() {
		double sum = 0.0;
		for (int i = 0; i < buffer.size(); i++) {
			sum += buffer[i];
		}
		m = sum / buffer.size();
		return m;
	}

	double calc_deviation() {
		mean();
		double sum = 0.0;
		for (int i = 0; i < buffer.size(); i++)	{
			sum += SQR((buffer[i] - m));
		}
		value = sqrt(sum / (buffer.size() - 1));
		return value;	
	}

public: 
	Deviation(int n) : buffer_size(n) {}

	double get() { return value; }

	double put(double elem) {
		add(elem);
		return value;
	}
	
}; 

#endif 
