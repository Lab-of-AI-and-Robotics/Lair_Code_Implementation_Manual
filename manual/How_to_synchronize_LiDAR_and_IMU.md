last update 2023 7.24 by Seongbo Ha. <br>

### 문제
- 실제 LiDAR, IMU를 활용해서 LIO-SAM, Fast-LIO를 작동시키는데 문제 발생
  - LIO-SAM: 무응답
  - Fast-LIO: "not enough feature"(정확하지 않음) 경고 메시지가 계속해서 출력되며 SLAM 동작 x

### 확인된 원인
- LiDAR, IMU 데이터가 담긴 두 message에는 공통적으로 header 항목이 존재하고, header에 timestamp가 기록됨
- IMU driver는 정상적으로 timestamp를 기록하여 message를 전송
- 하지만 LiDAR driver가 이상한 시점의 timestamp를 기록해 message를 전송
    -> 두 message의 timestamp가 맞지 않아 SLAM이 원활하게 작동하지 않는다
    **std_msgs/Header.msg**

    ```cpp
    uint32 seq
    time stamp     <---
    string frame_id
    ```
    - LiDAR message

        **sensor_msgs/PointCloud2.msg**

        ```cpp
        형식                       이름
        std_msgs/Header            header     <---
        uint32                     height
        uint32                     width
        sensor_msgs/PointField[]   fields
        bool                       is_bigendian
        uint32                     point_step
        uint32                     row_step
        uint8[]                    data
        bool                       is_dense
        ```

    - IMU message
        **sensor_msgs/Imu.msg**

        ```cpp
        형식                       이름
        std_msgs/Header            header         <---
        geometry_msgs/Quaternion   orientation
        float64[9]                 orientation_covariance
        geometry_msgs/Vector3      angular_velocity
        float64[9]                 angular_velocity_covariance
        geometry_msgs/Vector3      linear_acceleration
        float64[9]                 linear_acceleration_covariance
        ```
    

## 해결방법
- LiDAR와 IMU를 함께 사용하는 SLAM(LIO-SAM, FAST-LIO)들의 경우 LiDAR와 IMU를 동기화시켜야 함
- 즉 pointcloud message와 imu message의 timestamp에 같은 시점이 기록되어야 한다
- LiDAR의 driver를 수정해 올바른 timestamp를 기록하도록 해야 함
- 직접 수정 or 수정된 코드 다운

### 방법 1 : 직접 수정 (Ouster)

- Ouster ROS driver 다운로드

```bash
cd <your workspace>/src
git clone --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git
sudo apt install -y         \
    build-essential         \
    libeigen3-dev           \
    libjsoncpp-dev          \
    libspdlog-dev           \
    libcurl4-openssl-dev    \
    cmake
```

- ouster-ros/src 경로의 cpp 파일들 수정

os_cloud_nodelet.cpp

```cpp
void convert_scan_to_pointcloud_publish(uint64_t scan_ts,
                                            const ros::Time& msg_ts) {
    for (int i = 0; i < n_returns; ++i) {
        scan_to_cloud_f(points, lut_direction, lut_offset, scan_ts, ls,
                        cloud, i);
        pcl_toROSMsg(cloud, *pc_ptr);
				// msg_ts를 ros::Time::now() 로 수정
        //pc_ptr->header.stamp = msg_ts;                <---- 수정 전
	pc_ptr->header.stamp = ros::Time::now();        <---- 수정 후
        pc_ptr->header.frame_id = sensor_frame;
        lidar_pubs[i].publish(pc_ptr);
    }

    tf_bcast.sendTransform(ouster_ros::transform_to_tf_msg(
        info.lidar_to_sensor_transform, sensor_frame, lidar_frame, msg_ts));

    tf_bcast.sendTransform(ouster_ros::transform_to_tf_msg(
        info.imu_to_sensor_transform, sensor_frame, imu_frame, msg_ts));
}
```

다른 파일들도 “header.stamp” 검색해서 ros::Time::now() 값이 들어가도록 바꿔주기

### 방법 2 : 수정된 코드 다운
Todo
