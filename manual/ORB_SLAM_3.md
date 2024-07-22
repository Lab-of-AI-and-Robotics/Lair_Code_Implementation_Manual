# ORB-SLAM3
2024.07.22, updated by Seongbo Ha.

# Environmental Settings (Docker)
## Build Docker images from Dockerfile
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

## Make container
```bash
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev:/dev \
    -e DISPLAY=$DISPLAY -e USER=$USER \
    -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
    NVIDIA_VISIBLE_DEVICES=all \
    --net host --privileged \
    --name orb orb:demo /bin/bash
```

## Transporting messages between the local environment and a docker container
(SLAM tutorial 진행중인 학부인턴 학생분들은 이 과정 생략해주세요.)<br>
If you're using both the local environment and Docker container together, follow this [manual](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/manual/ROS_multidevice.md).
# RUN
## SLAM
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

## Localization Mode (with realsense D435i)
### 1. Run ORB-SLAM3 (SLAM mode) to get a map.
- Specify directory where the map will be saved by editing config file.<br>
    - Examples_old/ROS/ORB_SLAM3/configs/RealSense_D435i.yaml
        ```yaml
        # End of the config file.
        # If the LoadFile doesn't exist, the system give a message and create a new Atlas from scratch
        # System.LoadAtlasFromFile: "/ORB_SLAM3/localization_test" # <--- comment out this line

        # The store file is created from the current session, if a file with the same name exists it is deleted
        System.SaveAtlasToFile: "/ORB_SLAM3/localization_test"      # <--- directory where the map will be saved
        ```

- Run ORB-SLAM3
    - Stream RGBD and imu data using realsense.
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
    - Run ORB-SLAM3 (RGBD-inertial)
        ```bash
        roslaunch ORB-SLAM3 realsense_rgbdimu.launch
        ```
- Save map
    - Click "Stop" button in the viewer.

        <img src="https://github.com/user-attachments/assets/0f9f6038-ef39-4d53-8d9b-296483a77d07" width="700">
    
    - If the map is successfully saved, the message "Map saved" will be printed in the terminal.
        <img src="https://github.com/user-attachments/assets/351b7978-e9cc-4e34-bbc1-24dfb0379b1c" width="700">
    
### 2. Load map and run localization mode.
- Specify directory where the map is saved.<br>
    - Examples_old/ROS/ORB_SLAM3/configs/RealSense_D435i.yaml
        ```yaml
        # End of the config file.
        # If the LoadFile doesn't exist, the system give a message and create a new Atlas from scratch
        System.LoadAtlasFromFile: "/ORB_SLAM3/localization_test" # <--- directory where the map is saved

        # The store file is created from the current session, if a file with the same name exists it is deleted
        System.SaveAtlasToFile: "/ORB_SLAM3/localization_test"
        ```
    - Run ORB-SLAM3 with localization mode.
        ```bash
        roslaunch ORB_SLAM3 realsense_localization_rgbdimu.launch
        ```
    - Stream RGBD and imu data using realsense.
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

# Demo video (SLAM/Localization only)
[![Video Label](http://img.youtube.com/vi/uWmIJprJSns/0.jpg)](https://youtu.be/uWmIJprJSns)