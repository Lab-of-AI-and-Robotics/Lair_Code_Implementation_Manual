# LOAM with Ouster 64ch
### Environmental Settings (Docker)

- Build docker image from Dockerfile
  - LOAM and requirements will be installed in the docker image.
  - Additionally, a rosbag file for demo will be downloaded.
    ```bash
    docker build docker_files/LOAM -t loam:demo
    ```

- Make container
   ```bash
   docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY -e USER=$USER \
    -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
    NVIDIA_VISIBLE_DEVICES=all \
    --net host --gpus all --privileged \
    --name loam loam:demo /bin/bash
    ```

### RUN
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
- Edit topic name in the launch file (launch/ouster.launch)
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
    
    ```