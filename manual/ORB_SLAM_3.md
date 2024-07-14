# ORB-SLAM3
2024.07.??, updated by Seongbo Ha.

## Environmental Settings (Docker)
### Build Docker images from Dockerfile
- For amd architecture processors
    - ORB-SLAM3, Realsesne-sdk/ROS driver and requirements will be installed in the docker image.
    - Additionally, a demo rosbag file (EUROC dataset MH02) will be downloaded.
        ```bash
        docker build docker_files/ORB-SLAM3/amd -t orb:demo
        ```
- For arm architecture processors (jetson)
    - ORB-SLAM3 and requirements, **excluding Realsense-sdk/ROS driver** will be installed in the docker image.
    - Additionally, a rosbag file for demo will be downloaded.
        ```bash
        docker build docker_files/vins/arm -t vins:demo
        ```
    - For jetson, we have to install Realsense-sdk/ROS driver **in the local environment** manually.
        - Realsense-sdk/ROS driver installed by using simple command "sudo apt-get install ros-$ROS_DISTRO-realsense2-camera" doesn't output imu data.
        - So we have to install Realsense-sdk (v.2.50.0) -> ROS driver manually.
        - For this, use support_files/install_realsense_driver_jetson.sh in this repo.
        ```bash
        # in the local environment
        bash support_files/install_realsense_driver_jetson.sh
        ```

### Make container
```bash
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev:/dev \
    -e DISPLAY=$DISPLAY -e USER=$USER \
    -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
    NVIDIA_VISIBLE_DEVICES=all \
    --net host --privileged \
    --name orb orb:demo /bin/bash
```

### Transporting messages between the local environment and a docker container
(SLAM tutorial 진행중인 학부인턴 학생분들은 이 과정 생략해주세요.)<br>
If you're using both the local environment and Docker container together, follow this [manual](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/manual/ROS_multidevice.md).
## RUN
### With demo rosbag file
- RUN ORB-SLAM3 and play demo rosbag file.
    - Terminal 1
        ```bash
        source /ORB_SLAM3/Examples_old/ROS/ORB_SLAM3/build/devel/setup.bash
        roslaunch ORB_SLAM3 euroc_stereoimu.launch
        ```
    - Terminal 2
        ```bash
        rosbag play /dataset/test.bag
        ```
### With Realsense d435i
- Stream data using ROS driver (RGBD)
    ```bash
    roslaunch realsense2_camera rs_camera.launch \
        depth_width:=640 depth_height:=480 \
        color_width:=640 color_height:=480 \
        align_depth:=true color_fps:=30 depth_fps:=30 \
        enable_sync:=true clip_distance:=3.0 \
        unite_imu_method:="copy" \
        enable_gyro:=true enable_accel:=true \
        accel_fps:=250 gyro_fps:=200
    ```
- RUN ORB-SLAM3
    - RGBD
        ```bash
        roslaunch ORB_SLAM3 realsense_rgbd.launch
        ```
    - RGBD-inertial
        ```bash
        roslaunch ORB_SLAM3 realsense_rgbdimu.launch
        ```