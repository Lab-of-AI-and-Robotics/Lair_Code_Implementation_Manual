# LOAM with Ouster 64ch
2024.06.15, updated by Seongbo Ha.

## Contents
  - Environmental Settings
  - Run
    - with demo data
    - with real sensor

## Environmental Settings (Docker)

### Build docker image from Dockerfile
- LOAM and requirements will be installed in the docker image.
- Additionally, a rosbag file for demo will be downloaded.
  - For amd architecture processors
    ```bash
    docker build docker_files/LOAM/amd -t loam:demo
    ```
  - For arm architecture processors (jetson)
    ```bash
    docker build docker_files/LOAM/arm -t loam:demo
    ```

### Make container
```bash
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=$DISPLAY -e USER=$USER \
-e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
NVIDIA_VISIBLE_DEVICES=all \
--net host --privileged \
--name loam loam:demo /bin/bash
```

### Transporting messages between the local environment and a docker container (optional)
(SLAM tutorial 진행중인 학부인턴 학생분들은 이 과정 생략해주세요.)<br>
If you're using both the local environment and Docker container together, follow this [manual](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/manual/ROS_multidevice.md).

## RUN
- To run and visualize A-LOAM, we need 2 terminals.
  - One to launch A-LOAM
  - One to play rosbag file
- So open two terminals and enter the command below to access the docker container.
  ```bash
  docker exec -it loam /bin/bash
  ```
  Like this
  ![loam](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/2c9eb699-2cab-4bcf-bfd3-563fcc4095b6)

### With demo rosbag file
- Rosbag file for demo is downloaded in the container. (/dataset/vins_test.bag)
- As mentioned above, we use two separate terminals
  - Terminal 1 (launch A-LOAM)
    ```bash
    roslaunch aloam_ouster ouster_demo.launch
    ```
  - Terminal 2 (play rosbag file)
    ```bash
    rosbag play /dataset/ouster_64.bag
    ```
    Like this
    ![Screenshot from 2024-05-30 10-59-41](https://github.com/Lab-of-AI-and-Robotics/A-LOAM_ouster64ch/assets/34827206/5244c42f-6fb3-4363-a498-28884f9072aa)

  - Expected result
    ![Screenshot from 2024-05-30 10-57-52](https://github.com/Lab-of-AI-and-Robotics/A-LOAM_ouster64ch/assets/34827206/27698594-7d28-4d6a-b2df-06ed7368b278)

### With user's own LiDAR
- Connect LiDAR
  - Please follow this [page](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/manual/Ouster.md).
  - **Note that ROS driver is already installed in the docker environment.**
- Edit topic name in the launch file (launch/ouster.launch) (if needed)
  ```yaml
  <param name="minimum_range" type="double" value="1"/>

  <remap from="/velodyne_points" to="/ouster/points"/>   <---- Edit

  <param name="mapping_line_resolution" type="double" value="0.4"/>
  <param name="mapping_plane_resolution" type="double" value="0.8"/>
  ```
  Then, re-build A-LOAM
  ```bash
  cd /catkin_ws
  catkin_make
  ```
- Run
  - Terminal 1 (launch A-LOAM)
    ```bash
    roslaunch aloam_ouster ouster.launch
    ```
  - Terminal 2 (launch ouster driver)
    ```bash
    roslaunch ouster_ros sensor.launch sensor_hostname:="your address" udp_dest:="your address"
    ```

## Known issues
- "docker exec -it loam /bin/bash" is not working with below error message.
    ```bash
    Error response from daemon: Container 13b80ddc4587e65441f690bc6c011eeb5626b01addabb4ebcb2c0386c595135b is not running
    ```
    - This issue occurs because the Docker container has been terminated. One need to run docker container with the command below.
        ```bash
        docker start loam
        ```
- rviz is not working with below error message.
  ```bash
  qt.qpa.screen: QXcbConnection: Could not connect to display :0
  Could not connect to any X display.
  ```
  - run this command on "original environment", not on container.
    ```bash
    xhost +
    ```
