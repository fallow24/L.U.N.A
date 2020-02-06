#ifndef THRESHOLD_HPP
#define THRESHOLD_HPP

#include "ros/ros.h"
#include "sensor_msgs/Imu.h"
#include <deque>
#include <math.h>

//! Calculate n^2
#define SQR(n) ((n)*(n))

using namespace std;

/*! 
 * Class that buffers up to n values and calculates the 
 * standard deviation of those. The buffer works as a sliding window.
 */ 
class Deviation {

private:
        //! Size of the sliding window.
	int buffer_size;

	//! The sliding window implemented as a double ended queue
	deque<double> buffer;

	//! Current deviation of the buffer		
	double value;

	//! Current mean of the buffer
	double m;

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
	
	//! Returns the current deviation value
	double get() { return value; }

	//! Add new value to the buffer. Removes the item which is stored the longest (if the buffer is full)
	double put(double elem) {
		add(elem);
		return value;
	}
	
}; 

#endif 
