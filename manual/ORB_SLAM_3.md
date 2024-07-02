# ORB-SLAM3
2024.07.??, updated by Seongbo Ha.

## Environmental Settings (Docker)
- Build Docker images from Dockerfile
  - ORB-SLAM3 and its requirements will be installed in the docker image.
  - Additionally, a demo rosbag file (EUROC dataset MH02) will be downloaded.
    ```bash
    docker build docker_files/ORB-SLAM3 -t orb:demo
    ```

- Make container
    ```bash
    docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /dev:/dev \
        -e DISPLAY=$DISPLAY -e USER=$USER \
        -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
        NVIDIA_VISIBLE_DEVICES=all \
        --net host --gpus all --privileged \
        --name orb orb:demo /bin/bash
    ```

## RUN

```bash
roslaunch ORB_SLAM3 euroc_stereo.launch
```

```bash
rosbag play /dataset/test.bag
```