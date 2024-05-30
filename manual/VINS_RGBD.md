# VINS_RGBD

### Environmental Settings (Docker)

- Build docker image from Dockerfile
  - VINS-RGBD and requirements will be installed in the docker image.
  - Additionally, a rosbag file for demo will be downloaded.

    ```bash
    cd docker_files/vins
    docker build -t vins:demo .
    ```

- Make container
    ```bash
    docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY -e USER=$USER \
    -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
    NVIDIA_VISIBLE_DEVICES=all \
    --net host --gpus all --privileged \
    --name vins vins:demo /bin/bash
    ```
<br>

### RUN
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

#### With Demo rosbag file
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

#### With realsense 435i
- Connect realsense camera.
- As mentioned above, we use three separate terminals
  - Terminal 1
    - Launch realsense ros driver with below command.
    ```bash
    roslaunch realsense2_camera rs_camera.launch \
    depth_width:=640 depth_height:=480 \
    color_width:=640 color_height:=480 \
    align_depth:=true color_fps:=30 depth_fps:=30 \
    enable_sync:=true clip_distance:=1.5
    ```
  - Terminal 2 (run rviz for visualization)
    ```bash
    roslaunch vins_estimator vins_rviz.launch
    ```
  - Terminal 3 (play rosbag file)
    ```bash
    rosbag play /dataset/vins_test.bag
    ```

### Known issues
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