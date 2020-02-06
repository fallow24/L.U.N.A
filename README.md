![L.U.N.A. Logo](https://github.com/fallow24/L.U.N.A/blob/master/Media/luna_logo_notext.png)

# L.U.N.A. - Laser-Mapping Unidirectional Navigation Actuator
## Introduction
The L.U.N.A. sphere has a simple goal: roll into an area and create a 3D model of the environment. The design was chosen due to its multi-directional nature, however the current prototype was build to roll in one direction only.

![](https://github.com/fallow24/L.U.N.A/blob/master/Media/BlueprintPNG.png)

Different application scenarios could include:
* Mapping of underground tunnels that are not accessible to humans or larger robots
* Mapping of planetary surfaces (such as lunar craters) and similar scenarios.

The project was developed within the _FloatSat_ - Module of the Julius-Maximilians-University of Würzburg by three Satellite Technology students: Fabian A., Anton B. and Jasper Z. 


[![Roll 1](https://res.cloudinary.com/marcomontalbano/image/upload/v1581005771/video_to_markdown/images/youtube--4A9AdD9eoiU-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://youtu.be/4A9AdD9eoiU "Roll 1")
[![Roll 2](https://res.cloudinary.com/marcomontalbano/image/upload/v1581005862/video_to_markdown/images/youtube--cJOBozcbXv8-c05b58ac6eb4c4700831b2b3070cd403.jpg)](https://youtu.be/cJOBozcbXv8 "Roll 2")

***


## How to use L.U.N.A.
This section shall function as an introduction on how to reproduce the results mentioned below. The physical setup and the software structure will be explained and a simple follow on guide on how to use it will be given.

**TLDR:** Connect the power and the voltmeter. Assemble the sphere in such a way that the plastic sphere is properly shut. Tape it shut! Run the launch file `~/catkin_ws/launch/launch.py`, the nodes `pwm_commander pwm_reader`, `pwm_commander pwm_const_publisher`, `pwm_commander high_res_pwm_to_pin` on the RaspberryPi and control the throttle via `pwm_reader`. Run the node `point_cloud point_cloud` on your machine and visualize the data using 3DTK.

### Hardware
The sphere consist of four easily dissassemblable parts: The lower hemisphere, the upper hemisphere with measuring slits in the plastic, the top plate with adjustable weights and the support structure to which all other parts are attached by screws. PICTURES HERE The support structure is made of acrylic glass and is attached to the laser scanner (SICK LMS100) as a main point of attachment. The CAD files for the design can be found [here](https://github.com/fallow24/L.U.N.A/tree/master/CAD-Model).

To assemble the sphere first connect the battery to the power cable and turn on the voltmeter by plugging the battery charging port into it. Place the support structure into the lower hemisphere and place the top plate on top in such a way, that it balances the sphere. Make sure to place the support structure as centered as possible and next to the blockade found at the bottom. Now place the upper hemisphere on top with the laser scanner facing the measuring slits. It is likely that you will have to readjust the position of the support structure multiple times until the upper hemisphere fits nicely. Finally tape the sphere closed using the tape of your choice. Now you should be good to go to start the software driving the sphere.

### Software

It is required to set up the `catkin_ws_pi` on the RaspberryPi and the `catkin_ws_host` on a linux machine with a current ROS install. Make sure both workspaces are compiled without error before continuing. To start the L.U.N.A. sphere there are two options: the python start scrip via command line or the app. Both will be described.

**Start Script** 
1. Connect your Computer to the RaspberryPi on the sphere using the wireless network _ubiquityrobot3929_ using the password "_robotseverywhere_". 
2. Open a ssh connection using the command `ssh ubuntu@ubiquityrobot.local`. This will prompt you to enter a password. Enter "_ubuntu_"
3. Navigate to the launch file folder (`cd catkin_ws/launch`).
4. Execute the launch script (`./launch.py`) this will start all devices except for the motors/ESCs
5. Open three new terminals and connect them to the RaspberryPi (Step 2)
6. For each terminal do the following:
   1. Start the pwm reader `rosrun pwm_commander pwm_reader`
   2. Start the pwm constant publisher `rosrun pwm_commander pwm_const_publisher`
   3. Follow this procedure:
        1. Log in as root `su` using the password "_ubuntu_"
        2. Navigate to the catkin workspace `cd ~/catkin_ws`
        3. Source the workspace `source devel/setup.bash`
        4. Run the pwm to pin node `rosrun pwm_commander high_res_pwm_to_pin` 

**App**

Download the apk found in the [repository](https://github.com/fallow24/L.U.N.A/blob/master/LunarApp2/lunarApp.apk) and install it on your android phone. Connect your phone to the wireless network _ubiquityrobot3929_ using the password "_robotseverywhere_". Make sure your phone has no further internet connection i.e. turn off your mobile data. Open the app and and click _OPEN SSH_ and afterwards _TEST SSH_. The app should show the current time if the connection succeeded. Using the sliders you can now turn on all nodes one after another. SCREENSHOT OF APP HERE

After either one of the procedures above, all required nodes at the RaspberryPi should be running. You can double check by calling `rosnode list` in a connected terminal to see all nodes. You should be able to control the sphere using commands send to the `pwm_reader`. These commands have the following format:

 `[command] [value]`

Possible commands are:
 * `d [0 - 100]` = direct feed-through mode 
 * `s [0 - 100]` = smooth acceleration mode 
 * `v [0, 1]`    = set vibration controller to be off(0)/on(1)
 * `m [value]`   = set smoothness factor, its the the time (value*100ms) which the controller waits to increment                   or decrement the current PWM to the desired PWM, which leads to a smooth translation
 * `t [value]`   = set standard deviation upper threshold for vibration controller (the lower threshold is hard-coded. Its default value is 4.)
 
On your computer use a terminal to export the ros master URI `export ROS_MASTER_URI=http://ubiquityrobot.local:11311`. In this terminal you can now run the point cloud node (`rosrun point_cloud point_cloud`) to turn the data published by the RaspberryPi into data readable for 3DTK. 

To visualize the created data please refer to the documentation of [3DTK](http://slam6d.sourceforge.net/doc/show.html).


***
