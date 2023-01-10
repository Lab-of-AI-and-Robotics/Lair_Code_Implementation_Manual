# How to implement velodyne_visualization

last update 2023 1.10 by Minjae Lee. <br>
last update 2022 8.16 by Minjae Lee. <br>
last update 2022 7.25 by Minjae Lee. <br>
last update 2022 7.22 by Minjae Lee. <br>


<br>

[Reference YouTube video link](https://youtu.be/QtChxWFEVlk) <br/>
[Reference wikiros link](http://wiki.ros.org/velodyne/Tutorials/Getting%20Started%20with%20the%20Velodyne%20VLP16) <br/>




0. If ipconfig is not installed, install it. (for check ridar name later)
```
$ sudo apt-get install net-tools
```


1. Download package. (It should be installed according to its own situation, such as melodic, kinetic, etc.) Our lab use melodic, so we installed melodic.
```
$ sudo apt-get install ros-melodic-velodyne
```

2. Make 2 folders using mkdir command.
```
$ mkdir -p /catkin_ws/src
```

3. In the src folder, download velodyne using git clone.
```
$ git clone https://github.com/ros-drivers/velodyne.git
```


4. Change directory to catkin_ws from src.
```
$ cd ..
```


5. Build at catkin_ws folder using catkin_make.
```
$ catkin_make
```


<br/>

6. After that, it disconnects Ethernet and local with LAN and connects Velodine and desktop with LAN.


7. Enter the command to verify that the Velodine and local are connected well. (Enp5s0 is a unique name for each rider. It is possible to check the name of the rider by 'sudo ifconfig' after the LAN connection.) <br>
Before checking the connection, you should set up an ip for communication on the desktop. It allows you to enter the network settings, ipv4. The same is allowed until address 192.168.1, and then not the same.(192.168.1.x  (x is not same with 201)) The netmask is 255.255.255.0 and the gateway is 0.0.0.0
(So, because velodyne 16 ip adress is 192.168.1.201 we set local ip adress 102.168.1.xxx)

```
$ sudo ifconfig enp5s0 192.168.1.201
```

8. You can also check the connection through your browser, and you can enter the window by typing 192.168.1.201 at the browser address. <br/>


9. After that, open a new terminal and roslaunch in catkin_ws/src. (Be careful with spacing!)
```
$ cd src
$ roslaunch velodyne_pointcloud VLP16_points.launch
```

10. Enter the command to float the visualization tool by command. (If it doesn't work, open another terminal, run roscore or roslaunch, and retype the command)
```
$ rosrun rviz rviz -f velodyne
```

11. Add pointcloud2 topic in rviz.

12. It can be seen that Velodyne receives laboratory data and visualizes it well.
![first_test](https://user-images.githubusercontent.com/79103625/178249246-bdf1a14a-b2d3-4f05-b640-4d9282d6a996.png)
