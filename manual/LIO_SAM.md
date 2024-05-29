# LIO_SAM

### Environmental Settings(Docker)

- Build docker image from Dockerfile
    - LIO_SAM and requirements will be installed in the docker image.
    
        ```bash
        docker build /docker_files/LIO-SAM -t lio:demo
        ```

- Make container
   
  
  ```
    docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY -e USER=$USER \
    -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e \
    NVIDIA_VISIBLE_DEVICES=all \
    --net host --gpus all --privileged \
    --name lio lio:demo /bin/bash
  ```
- build
  ```
  catkin_make
  ```
- make dataset file
  ```
  mkdir dataset
  ```  

### Download Dataset
   - We should Download Dataset for LIO-SAM
   - Enter https://drive.google.com/drive/folders/1gJHwfdHCRdjP7vuT556pv8atqrCJPbUq
   - Download rooftop_ouster_dataset.bag for test
  
### RUN

- To run and visualize LIO-SAM, we need 2 terminals
  - One to launch LIO-SAM
  - One to play rosbag file.
- Open two terminals and insert the command below to access the docker container.
  
  ```
  docker exec -it lio /bin/bash

  cd catkin_ws 

  source devel/setup.bash
  ```
- copy dataset to docker environment
  - insert the command to local terminal
     ```
     docker cp Downloads/rooftop_ouster_dataset.bag lio:/catkin_ws/dataset
     ```
- With Demo rosbag file
  - Terminal 1(launch LIO-SAM)
    ```
    roslaunch lio_sam run.launch
    ```
  - Terminal 2(play rosbag file)
    ```
    cd /catkin_ws/dataset

    rosbag play rooftop_ouster_dataset.bag
    ```
- Expected Results
  ![alt text](LIO_SAM.png)

# Expected Issue
  - "docker exec -it lio /bin/bash" is not working with below error message.
         
        ```
        Error response from daemon: Container {container_ID} is not running.
        ```
      - This issue occurs because docker container has been terminated. 
        Just start docker container with this command
        ```
        docker start lio
        ```

   - Rviz is not working
      - run this command on local terminal
        ```
        xhost +
        ```
      - run this command on docker terminal
        ```
        apt-get update
    
        apt-get install x11-apps
    
        xeyes
        ```


