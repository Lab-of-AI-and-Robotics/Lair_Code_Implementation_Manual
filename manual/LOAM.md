# LOAM

### Environmental Setting(Docker)

- Build docker image from Dockerfile
  - LOAM and requirements will be installed in the docker image.
    ```
    docker build /docker_files/LOAM -t loam:demo
    ```

- Make container
   ```
   docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY -e USER=$USER \
    -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
    NVIDIA_VISIBLE_DEVICES=all \
    --net host --gpus all --privileged \
    --name loam loam:demo /bin/bash
    ```

