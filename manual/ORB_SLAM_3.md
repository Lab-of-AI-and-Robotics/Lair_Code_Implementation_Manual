# ORB-SLAM3
2024.07.??, updated by Seongbo Ha.

## Environmental Settings (Docker)
### Build Docker images from Dockerfile
- ORB-SLAM3 and its requirements will be installed in the docker image.
- Additionally, a demo rosbag file (EUROC dataset MH02) will be downloaded.
- For amd architecture processors
    ```bash
    docker build docker_files/ORB-SLAM3/amd -t orb:demo
    ```
- For arm architecture processors (jetson)
    ```bash
    docker build docker_files/ORB-SLAM3/arm -t orb:demo
    ```

### Make container
```bash
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /dev:/dev \
    -e DISPLAY=$DISPLAY -e USER=$USER \
    -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
    NVIDIA_VISIBLE_DEVICES=all \
    --net host --gpus all --privileged \
    --name orb orb:demo /bin/bash
```

### Transporting messages between the local environment and a docker container
(SLAM tutorial 진행중인 학부인턴 학생분들은 이 과정 생략해주세요.)<br>
If you're using both the local environment and Docker container together, follow this [manual](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/manual/ROS_multidevice.md).
## RUN

```bash
roslaunch ORB_SLAM3 euroc_stereo.launch
```

```bash
rosbag play /dataset/test.bag
```