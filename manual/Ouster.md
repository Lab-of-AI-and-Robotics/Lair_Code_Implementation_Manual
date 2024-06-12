# Ouster
## Including features
- Connecting Ouster LiDAR
- ROS driver

## Connecting Ouster LiDAR
- Connect LiDAR to desktop
- Configure network profile
  - Enter network settings
    Fig.1
  - Add new network profile
    Fig.2
    Fig.3
  - Set IP address/net mask
    Fig.4
    Set IP address as $\color{red}\text{192.168.1.x}$, and net mask as 255.255.255.0
    This IP address will be used as $\color{red}\text{udp\_dest}$ for ROS driver!
- Assign IP address to LiDAR
  - Check port name by using below command
    ```bash
    ifconfig
    ```
    Fig.5
    Find the name of the port which has same IP address(192.168.1.x) we set in the previous step. In the example case, the name of the port is "eno1".
  - Assign IP address to the LiDAR
    Use below command, fill out [port name] to yours.
    ```bash
    sudo dnsmasq -C /dev/null -kd -F 192.168.1.0,192.168.1.100 -i [port name] --bind-dynamic
    # ex)
    sudo dnsmasq -C /dev/null -kd -F 192.168.1.0,192.168.1.100 -i eno1 --bind-dynamic
    ```
    After a while... The IP address assigned to the LiDAR will be showed. (In the example case, $\color{blue}\text{192.168.1.75}$) And this address will be used as $\color{blue}\text{sensor\_hostname}$ for ROS driver!
    Fig.6

## ROS driver
- clone the [driver repo](https://github.com/Lab-of-AI-and-Robotics/Ouster_driver.git) and build it.
- launch
    Launch driver with $\color{blue}\text{sensor\_hostname}$ and $\color{red}\text{udp\_dest}$ address which we set in the previous step.
    ```bash
    roslaunch ouster_ros sensor.launch sensor_hostname:="192.168.1.75" udp_dest:="192.168.1.100" viz:=true
    ```
    Wait for the LiDAR to be initialized...
    Fig.7