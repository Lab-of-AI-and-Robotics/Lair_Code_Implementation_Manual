# Ouster
## Including features
- Connecting Ouster LiDAR
- ROS driver

## Connecting Ouster LiDAR
- Connect LiDAR to desktop
- Configure network profile
  
  - Enter network settings

    <img src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/369ac6b0-fdbb-43e4-9a9f-ea28339a7207" width="35%">

  - Add new network
    
    <img src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/d3354014-c192-4ddf-80a4-4e2486136941" width="35%">
    <img src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/0f2141c5-3470-4821-bf0b-a5234e77c773" width="45%">

  - Set IP address/net mask
    
    <img src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/2cb92ec3-e728-4d9d-8bbe-e9c6cba378b9" width="45%">
    
    Set IP address as $\color{red}\text{192.168.1.x}$, and net mask as 255.255.255.0
    This IP address will be used as $\color{red}\text{udp-dest}$ for ROS driver!

- Assign IP address to LiDAR
  - Check port name by using below command
    ```bash
    ifconfig
    ```
    
    <img src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/5d5951b6-eb96-4bb6-ac0c-56c3dc658e07" width="35%">

    Find the port name with the same IP address(192.168.1.x) we set in the previous step. In the example case, the name of the port is "eno1".
  - Assign IP address to the LiDAR
    Use the below command, fill out [port name] to yours.
    ```bash
    sudo dnsmasq -C /dev/null -kd -F 192.168.1.0,192.168.1.100 -i [port name] --bind-dynamic
    # ex)
    sudo dnsmasq -C /dev/null -kd -F 192.168.1.0,192.168.1.100 -i eno1 --bind-dynamic
    ```
    After a while... The IP address assigned to the LiDAR will be showed. (In the example case, $\color{blue}\text{192.168.1.75}$) And this address will be used as $\color{blue}\text{sensor-hostname}$ for ROS driver!

    <img src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/ae3d3dcf-86e2-4a14-9592-80128b3e4e58" width="45%">


## ROS driver
- clone the [driver repo](https://github.com/Lab-of-AI-and-Robotics/Ouster_driver.git) and build it.
- launch
    Launch driver with $\color{blue}\text{sensor-hostname}$ and $\color{red}\text{udp-dest}$ address which we set in the previous step.
    ```bash
    roslaunch ouster_ros sensor.launch sensor_hostname:="192.168.1.75" udp_dest:="192.168.1.100" viz:=true
    ```
    Wait for the LiDAR to be initialized...

    <img src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/c1fc761e-c92e-48c3-abe5-28c4f6b92cc3" width="60%">
