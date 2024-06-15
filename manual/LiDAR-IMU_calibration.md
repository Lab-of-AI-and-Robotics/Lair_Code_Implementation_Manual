# LiDAR-IMU Calibration
2024.06.15, updated by Seongbo Ha.

## Install

- To tackle error (Building error “ LZ4_stream“)
    ```bash
    sudo mv /usr/include/flann/ext/lz4.h /usr/include/flann/ext/lz4.h.bak \
    sudo mv /usr/include/flann/ext/lz4hc.h /usr/include/flann/ext/lz4.h.bak \
    sudo ln -s /usr/include/lz4.h /usr/include/flann/ext/lz4.h \
    sudo ln -s /usr/include/lz4hc.h /usr/include/flann/ext/lz4hc.h
    ```

- Clone repo and build
    ```bash
    cd [workspace/src]
    git clone https://github.com/Riboha/lidar_imu_calib_edited.git
    cd [workspace]
    catkin_make
    ```

## Calibrate
- Record rosbag file
  - Point cloud captured by LiDAR(sensor_msgs/PointCloud2), and IMU data(sensor_msgs/Imu) must be recorded.
  - Example command
    ```bash
    # rosbag record -O [file name] [topics to record]
    rosbag record -O calib_data.bag /ouster/points /imu
    ```
- Launch
  - launch calib_exR_lidar2imu.launch with [path of bag file], [name of lidar topic], [name of imu topic].
    ```bash
    roslaunch lidar_imu_calib calib_exR_lidar2imu.launch \
    bag_file:=[path of the bag file] \
    lidar_topic:=[name of lidar topic] \
    imu_topic:=[name of imu topic]
    ```
  - Example command
    ```bash
    roslaunch lidar_imu_calib calib_exR_lidar2imu.launch \
    bag_file:=/calib_bag.bag \
    lidar_topic:=/ouster/points \
    imu_topic:=/imu
    ```
- Result
    - Extrinsic rotation parameters between the LiDAR and IMU will be output.
    ```
    result euler angle(RPY) : -0.0379889 -0.00972458 1.44685
    result extrinsic rotation matrix
    IMU to LiDAR
    0.123624   -0.991567  -0.0388897
    0.992281    0.123908 -0.00494742
    0.00972443  -0.0379779    0.999231
    LiDAR to IMU
    0.123624    0.992281  0.00972443
    -0.991567    0.123908  -0.0379779
    -0.0388897 -0.00494742    0.999231
    ```