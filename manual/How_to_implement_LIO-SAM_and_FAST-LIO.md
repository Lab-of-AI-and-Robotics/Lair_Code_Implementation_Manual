# How to implement LIO-SAM, FAST-LIO
last update 2023 7.24 by Seongbo Ha. <br>

🚨 LiDAR, IMU를 함께 사용하는 경우, LiDAR와 IMU가 보내는 timestamp가 일치하는지 확인해야 함



[이 문서 먼저 확인](https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/manual/7.%20How_to_synchronize_LiDAR_and_IMU.md)

# LiDAR, IMU

IMU rate 설정 등
업데이트 예정
https://github.com/unmannedlab/imu_lidar_calibration

# LIO-SAM

- Install dependencies

```bash
## Ros dependencies
sudo apt-get install -y ros-$ROS_DISTRO-navigation
sudo apt-get install -y ros-$ROS_DISTRO-localization
sudo apt-get install -y ros-$ROS_DISTRO-robot-state-publisher

## gtsam
sudo add-apt-repository ppa:borglab/gtsam-release-4.0
sudo apt install libgtsam-dev libgtsam-unstable-dev
```

- Download package

```bash
cd <your workspace>/src
git clone https://github.com/TixiaoShan/LIO-SAM.git
cd ..
catkin_make
```

- Edit config file (LIO-SAM/config/params.yaml)

Pointcloud, IMU 토픽명 바꿔주기

```yaml
lio_sam:

  # Topics
  pointCloudTopic: "Pointcloud 토픽명 ex)ouster/points"               # Point cloud data
  imuTopic: "IMU 토픽명 ex)imu"                                       # IMU data
  odomTopic: "odometry/imu"                                          # IMU pre-preintegration odometry, same frequency as IMU
  gpsTopic: "odometry/gpsz"
```

LiDAR 설정

Unitree GO1의 LiDAR는 Ouster OS1-64이므로 여기에 맞게 수정

```yaml
# Sensor Settings
  sensor: ouster                            # lidar sensor type, 'velodyne' or 'ouster' or 'livox'
  N_SCAN: 64             <---- 수정                     # number of lidar channel (i.e., Velodyne/Ouster: 16, 32, 64, 128, Livox Horizon: 6)
  Horizon_SCAN: 1024     <---- 수정                     # lidar horizontal resolution (Velodyne:1800, Ouster:512,1024,2048, Livox Horizon: 4000)
  downsampleRate: 1                           # default: 1. Downsample your data if too many points. i.e., 16 = 64 / 4, 16 = 16 / 1
  lidarMinRange: 1.0                          # default: 1.0, minimum lidar range to be used
  lidarMaxRange: 1000.0
```

LiDAR와 IMU의 위치관계를 나타내는 extrinsic parameter 수정

예시 1) 
<br/>
<img width="50%" src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/images/imu-transform.png"/>
```yaml
# Extrinsics: T_lb (lidar -> imu)
  extrinsicTrans: [0.0, 0.0, 0.0]            
  extrinsicRot: [-1, 0, 0,   
                  0, 1, 0,
                  0, 0, -1]
  extrinsicRPY: [0, -1, 0,
                 1, 0, 0,
                 0, 0, 1]
```

예시 2) 우리꺼
<br/>
<img width="30%" src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/images/ourset.jpg"/>
```yaml
# Extrinsics: T_lb (lidar -> imu)
  extrinsicTrans: [0.0, 0.0, 0.0]
  extrinsicRot: [1, 0, 0,
                  0, 1, 0,
                  0, 0, 1]
  extrinsicRPY: [1, 0, 0,
                 0, 1, 0,
                 0, 0, 1]
```

- Run

```bash
### LIO-SAM/config/params.yaml에 기록된 정보를 불러와 실행
roslaunch lio_sam run.launch
```

# FAST-LIO

- Download dependencies

```bash
cd <your workspace>/src
git clone https://github.com/Livox-SDK/livox_ros_driver.git
```

- Download package

```bash
cd <your workspace>/src
git clone https://github.com/hku-mars/FAST_LIO.git
cd FAST_LIO
git submodule update --init
cd ../..
catkin_make
```

- Edit config file
    - 사용하는 LiDAR에 따라 config file 수정
        - Ouster 64채널 : config/ouster64.yaml
        - Velodyne : config/velodyne.yaml

예시 ) config/ouster64.yaml

Pointcloud, IMU data의 토픽명 수정

```bash
common:
    lid_topic:  "pointcloud 토픽명 ex) /ouster/points"
    imu_topic:  "IMU data 토픽명 ex) /imu"
```

LiDAR, IMU의 위치관계를 나타내는 Extrinsic parameter 수정

수정방법은 LIO-SAM과 동일

```bash
mapping:
    acc_cov: 0.1
    gyr_cov: 0.1
    b_acc_cov: 0.0001
    b_gyr_cov: 0.0001
    fov_degree:    180
    det_range:     150.0
    extrinsic_est_en:  false      # true: enable the online estimation of IMU-LiDAR extrinsic
    extrinsic_T: [ 0.0, 0.0, 0.0 ]         <------------------- 거의 수정할필요 X
    extrinsic_R: [1, 0, 0,                 <------------------- Extrinsic parameter (수정할 parameter)
                  0, 1, 0,
                  0, 0, 1]
```

- Run

```bash
roslaunch fast_lio mapping_ouster64.launch
```
