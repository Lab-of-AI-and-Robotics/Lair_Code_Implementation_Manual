# A loam 사용방법
============================
## 1. A-loam 설치 및 실행

  1. 미리 설치해야하는 것들
  - **ROS** : ROS 설치 Document 참조
  - **Ceres Solver** : [http://ceres-solver.org/installation.html](http://ceres-solver.org/installation.html)
  설치를 위해 터미널창을 열고 다음 명령어를 입력한다.
  ```
  # ceres를 설치하기위해 의존성 패키지를 입력한다.

  sudo apt-get install cmake
  sudo apt-get install libgoogle-glog-dev libgflags-dev
  sudo apt-get install libatlas-base-dev
  sudo apt-get install libeigen3-dev
  sudo apt-get install libsuitesparse-dev

  # ceres-solver를 github에서 다운로드 및 설치한다.

  git clone https://ceres-solver.googlesource.com/ceres-solver
  mkdir ceres-bin
  cd ceres-bin
  cmake ../ceres-solver
  make -j3
  make test

  # make test를 통해 ceres solver가 제대로 작동하는지 확인한다.
  # 경우에 따라서 1~2개 정도 실패하는 test가 존재할 수 있다.
  # 이상이 없는경우 ceres solver를 설치한다.

  sudo make install
  ```

  - **~~PCL~~** : ROS를 설치할 경우 1.8버전 PCL이 자동으로 설치
  <br/>

  2. A-loam 다운로드 및 설치
  터미널에 다음 명령어를 입력한다.
  ```
  cd ~/catkin_ws/src
  git clone https://github.com/HKUST-Aerial-Robotics/A-LOAM.git
  cd ../
  catkin_make
  source ~/catkin_ws/devel/setup.bash
  ```
  <br/>

  3. 설치 완료 후 실행 (Velodyne VLP_16으로 테스트)
  ```
  # 터미널창에 다음 명령어 입력
  roslaunch aloam_velodyne aloam_velodyne_VLP_16.launch

  # 새로운 터미널 창을 열고 Velodyne VLP_16을 실행 (Velodyne 실행 Document 참조)
  roslaunch velodyne_pointcloud VLP16_points.launch
  ```

============================
## 2. kitti data set을 이용한 A-loam 실행

  1. KITTI data set을 다운로드 한다. [KITTI data](http://www.cvlibs.net/datasets/kitti/eval_odometry.php)
  이때, **odometry data set (grayscale, 22 GB)**, **odometry data set (velodyne laser data, 80 GB)**
  해당하는 2개의 파일을 다운로드한다.
  <br/>

  2. KITTI data set 압축 해제 및 dataset 폴더 이동
  KITTI data set을 aloam에 사용하기 위해서는 a loam패키지의 kitti_helper.launch를 실행해야 한다.
  kitti_helper는 dataset이 특정 구조를 가져야 읽을 수 있으므로 아래와 같은 과정을 거치도록 한다.
   - 먼저 data_odometry_velodyne.zip를 압축 해제하도록 한다. data라는 폴더에 압축 해제시 파일 구조는 다음과 같다.
  ```
  data
  └── dataset
     └── sequences
        ├── 00
        ├── 01
        ├── 02
          ...
        ├── 19
        ├── 20
        └── 21
  ```
  - 이때 dataset을 velodyne으로 이름을 변경한다.
  ```
  data
  └── velodyne
     └── sequences
        ├── 00
        ├── 01
        ├── 02
          ...
        ├── 19
        ├── 20
        └── 21
  ```
  - 이후 data_odometry_gray.zip를 압축 해제하도록 한다. Downloads에 압축 해제시 파일 구조는 다음과 같다.
  ```
  data
  ├── velodyne
  │  └── sequences
  │     ├── 00
  │     ├── 01
  │     ├── 02
  │       ...
  │     ├── 19
  │     ├── 20
  │     └── 21
  └── dataset
     └── sequences
        ├── 00
        ├── 01
        ├── 02
          ...
        ├── 19
        ├── 20
        └── 21
  ```
  - velodyne폴더를 dataset 폴더 안으로 이동시킨다. 이동 후 파일 구조는 다음과 같다. 이와 같은 구조를 가져야 kitti_helper가 파일을 읽을 수 있다.
  ```
  data
  └── dataset
     ├── sequences
     │   ├── 00
     │   ├── 01
     │   ├── 02
     │     ...
     │   ├── 19
     │   ├── 20
     │   └── 21
     └── velodyne
         └── sequences
             ├── 00
             ├── 01
             ├── 02
               ...
             ├── 19
             ├── 20
             └── 21
  ```

  5. kitti helper launch file 수정
  - 터미널에 다음 명령어를 입력한다.
  ```
  cd ~/catkin_ws/src/A-LOAM/launch
  gedit kitti_helper.launch
  ```
  - kitti_helper.launch이 gedit으로 열리게되면, \<param name="dataset_folder" type="string" value="/data/KITTI/odometry/" />에서 value를 수정한다. 이때, value의 값을 이전에 압축해제한 dataset폴더위치/dataset/으로 하도록 한다.
  ex) \<param name="dataset_folder" type="string" value="~/data/dataset/" />
  <br/>
  
  - **수정 전**
  ```
  <launch>
      <node name="kittiHelper" pkg="aloam_velodyne" type="kittiHelper" output="screen">
          <param name="dataset_folder" type="string" value="/data/KITTI/odometry/" /> # 해당 명령어의 value 수정
          <param name="sequence_number" type="string" value="00" />
          <param name="to_bag" type="bool" value="false" />
          <param name="output_bag_file" type="string" value="/tem/kitti.bag" />
          <param name="publish_delay" type="int" value="1" />
      </node>
  </launch>
  ```

  - **수정 후** (예시)
  ```
  <launch>
      <node name="kittiHelper" pkg="aloam_velodyne" type="kittiHelper" output="screen">
          <param name="dataset_folder" type="string" value="/home/user/data/dataset/" />
          # 해당 명령어의 value를 dataset폴더위치/dataset/ 로 지정

          <param name="sequence_number" type="string" value="00" />
          <param name="to_bag" type="bool" value="false" />
          <param name="output_bag_file" type="string" value="/tem/kitti.bag" />
          <param name="publish_delay" type="int" value="1" />
      </node>
  </launch>
  ```

  6. a_loam 실행 및 kitti_helper 실행
  - 터미널창에 다음 명령어를 입력한다.
  ```
  roslaunch aloam_velodyne aloam_velodyne_HDL_64.launch
  roslaunch aloam_velodyne kitti_helper.launch
  ```
