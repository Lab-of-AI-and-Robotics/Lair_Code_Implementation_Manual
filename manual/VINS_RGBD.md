# VINS_RGBD
2024.06.15, updated by Seongbo Ha.

## Environmental Settings (Docker)

### Build docker image from Dockerfile
  - VINS-RGBD and requirements will be installed in the docker image.
  - Additionally, a rosbag file for demo will be downloaded.
    - For amd architecture processors
        ```bash
        docker build docker_files/vins/amd -t vins:demo
        ```
    - For arm architecture processors (jetson)
      ```bash
      docker build docker_files/vins/arm -t vins:demo
      ```

### Make container
  ```bash
  docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev:/dev \
  -e DISPLAY=$DISPLAY -e USER=$USER \
  -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
  NVIDIA_VISIBLE_DEVICES=all \
  --net host --privileged \
  --name vins vins:demo /bin/bash
  ```

### Transporting messages between the local environment and a docker container
(SLAM tutorial 진행중인 학부인턴 학생분들은 이 과정 생략해주세요.)<br>
If you're using both the local environment and Docker container together, follow this [manual](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/manual/ROS_multidevice.md).
## RUN
- To run and visualize VINS-RGBD, we need 3 terminals.
  - One to launch VINS-RGBD.
  - One to run rviz for visualization.
  - One to play rosbag file.
- So open three terminals and enter the command below to access the docker container.
    ```bash
    docker exec -it vins /bin/bash
    ```
    Like this
    ![Screenshot from 2024-05-25 19-55-25](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/a5176f80-103c-48da-a9d3-6469d6a250f7)

### With Demo rosbag file
- Rosbag file for demo is downloaded in the container. (/dataset/vins_test.bag)
- As mentioned above, we use three separate terminals
  - Terminal 1 (launch VINS-RGBD)
    ```bash
    roslaunch vins_estimator realsense_color.launch
    ```
  - Terminal 2 (run rviz for visualization)
    ```bash
    roslaunch vins_estimator vins_rviz.launch
    ```
  - Terminal 3 (play rosbag file)
    ```bash
    rosbag play /dataset/vins_test.bag
    ```
  Like this
  ![Screenshot from 2024-05-25 20-18-35](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/640c80f9-5b74-4307-bccd-5b8cfc526035)
- Expected results
  ![Screenshot from 2024-05-25 20-32-29](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/assets/34827206/1c1c29ee-78c0-4a5c-ac0f-10f6bac0a929)

### With realsense 435i
- Connect realsense camera.
- ROS driver for realsense camera is already installed in the docker env.
- We need three separate terminals
  - Terminal 1
    - Launch realsense ros driver with below command.
    ```bash
    roslaunch realsense2_camera rs_camera.launch \
    depth_width:=640 depth_height:=480 \
    color_width:=640 color_height:=480 \
    align_depth:=true color_fps:=30 depth_fps:=30 \
    enable_sync:=true clip_distance:=3.0 \
    unite_imu_method:="linear_interpolation" \
    enable_gyro:=true enable_accel:=true \
    accel_fps:=250 gyro_fps:=200
    ```
  - Terminal 2 (run rviz for visualization)
    ```bash
    roslaunch vins_estimator vins_rviz.launch
    ```
  - Terminal 3 (launch VINS-RGBD)
    ```bash
    roslaunch vins_estimator realsense_ours.launch
    ```
  - Expected Results
    
    [![Video Label](http://img.youtube.com/vi/JUrakHYpFtg/0.jpg)](https://youtu.be/JUrakHYpFtg)

## Known issues
- "docker exec -it vins /bin/bash" is not working with below error message.
    ```bash
    Error response from daemon: Container 13b80ddc4587e65441f690bc6c011eeb5626b01addabb4ebcb2c0386c595135b is not running
    ```
    - This issue occurs because the Docker container has been terminated. One need to run docker container with the command below.
        ```bash
        docker start vins
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
- IMU data is not published
  - update hardware firmware to 5.12.7.100
  - [related issue](https://github.com/IntelRealSense/realsense-ros/issues/3103#issuecomment-2117946982)
  - [firmware releases](https://dev.intelrealsense.com/docs/firmware-releases-d400)
