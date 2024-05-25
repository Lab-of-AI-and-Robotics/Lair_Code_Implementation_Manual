# How to install ros

last update 2022 7.25 by Minjae Lee. <br>
last update 2022 7.22 by Minjae Lee. <br>


<br>
This manual explain how to install ros melodic in ubuntu.


[reference link](http://wiki.ros.org/melodic/Installation/Ubuntu) <- how ti install ros melodic in ubuntu. 
<br><br>

1. setting sources.list (not 2 line, only 1 command line)

```
$ sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```

<br/>

2. setting keys 

```
$ sudo apt install curl # if you haven't already installed curl
$ curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```

<br/>

3. before install, update apt

```
$ sudo apt update
```

<br/>

4. Install Desktop full (recommand) -> ROS, rqt,rviz,robot-generic libraries, 2D/3D simulators and 2D/3D perception. <br>
-> this command line install main ros library.

```
$ sudo apt install ros-melodic-desktop-full
```

<br/>

5. enviroment setting
  * Setting to automatically add loss environment variables (Every time a new shell runs)
  
  ```
  $ echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
  $ source ~/.bashrc
  ```
  <br/>
  
  * If you want to modify environmental variables at the current shell.
  
  ```
  $ source /opt/ros/melodic/setup.bash
  ```
  <br/>
  
  * If you want to use zsh instead of bash,
  
  ```
   $ echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
   $ source ~/.zshrc
   ```
   
<br/>
   
 6. Dependencies for building packages

   * To install too or other loss package building dependencies
   
   ```
   $ sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
   ```
   <br/>
   
   * Initialize rosdep
   
   ```
   $ sudo apt install python-rosdep (Need to initialize before using ROS)
   ```
   ```
   $ sudo rosdep init
   $ rosdep update
   ```
   
   
## Test after installing ros (turtleim)
<br/>

1. implement roscore <br>
   Open the terminal and execute the roscore command. Then the roscore governing the system is implemented. <br/>
   ```
   $ roscore
   ```

2. Run turtlesim_node in turtlesim package.<br>
   Open a **new terminal** and execute the following command: Then the info is printed on the terminal, and there is a turtle on the blue background. <br/>
   ```
   $ rosrun turtlesim turtlesim_node
   ```
   
3. Running turtleneck_teleop_key in turtleneck package. <br>
   Open a **new terminal** and execute the following command: And if you move the direction key at the terminal, the turtle moves. <br/>
   ```
   $ rosrun turtlesim turtle_teleop_key
   ```


<br/><br/>
If the above 1-3 works well, the installation is completed well.
