# How to implement A loam

last update 2022 8.01 by kungsu kang. <br>

## 1. A-loam install and run

  1. install dependence
  - **ROS** : see ROS install Document
  - **Ceres-Solver** : [http://ceres-solver.org/installation.html](http://ceres-solver.org/installation.html)
  input command line in terminal
  ```
  # install dependence for ceres

  sudo apt-get install cmake
  sudo apt-get install libgoogle-glog-dev libgflags-dev
  sudo apt-get install libatlas-base-dev
  sudo apt-get install libeigen3-dev
  sudo apt-get install libsuitesparse-dev

  # Download ceres-solver and install

  cd / && git clone --depth 1 --branch 1.14.0 https://ceres-solver.googlesource.com/ceres-solver 
    cd ceres-solver && mkdir build && cd build && cmake .. 
    make -j16 
    make -j16 all install 
    cd / \
    rm -rf /ceres-solver

  - **~~PCL~~** : if you install ROS, PCL 1.8 is installed
  <br/>

  2. Download A-loam and install
  input command line in terminal
  ```
  cd ~/catkin_ws/src
  git clone https://github.com/HKUST-Aerial-Robotics/A-LOAM.git
  cd ../
  catkin_make
  source ~/catkin_ws/devel/setup.bash
  ```
  <br/>

  3. run after install complete (test Velodyne VLP_16)
  ```
  # input command line in terminal
  roslaunch aloam_velodyne aloam_velodyne_VLP_16.launch

  # run Velodyne VLP_16 in new terminal (see run Velodyne Document)
  roslaunch velodyne_pointcloud VLP16_points.launch
  ```

## 2. kitti dataset Example

  1. KITTI dataset Download [KITTI data](http://www.cvlibs.net/datasets/kitti/eval_odometry.php)
  Download **odometry data set (grayscale, 22 GB)**, **odometry data set (velodyne laser data, 80 GB)**
  <br/>

  2. KITTI data set unzip and dataset folder reconstruction
  If you want run a_loam using KITTI dataset, you must run kitti_helper.launch in a_loam.
  kitti_helper can be read only when the dataset has a specific structure. so, you change dataset structure
   - unzip data_odometry_velodyne.zip. if you unzip at folder called data, file structure is as follows
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
  - change name from dataset to velodyne
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
  - unzip data_odometry_gray.zip. file structure is as follows if unzip at folder called data
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
  - move velodyne into dataset folder. Such a structure is required so that the kitti_helper can read the file.
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

  5. kitti helper launch file change
  - input command line in terminal
  ```
  cd ~/catkin_ws/src/A-LOAM/launch
  gedit kitti_helper.launch
  ```
  - when kitti_helper.launch opens, change value in \<param name="dataset_folder" type="string" value="/data/KITTI/odometry/" />.
  The value set DATASET_FOLDER_LOCATION/dataset/
  ex) \<param name="dataset_folder" type="string" value="/home/user/data/dataset/" />
  <br/>

  - **before change**
  ```
  <launch>
      <node name="kittiHelper" pkg="aloam_velodyne" type="kittiHelper" output="screen">
          <param name="dataset_folder" type="string" value="/data/KITTI/odometry/" /> # chage this command line's value

          <param name="sequence_number" type="string" value="00" />
          <param name="to_bag" type="bool" value="false" />
          <param name="output_bag_file" type="string" value="/tem/kitti.bag" />
          <param name="publish_delay" type="int" value="1" />
      </node>
  </launch>
  ```

  - **after change** (ex)
  ```
  <launch>
      <node name="kittiHelper" pkg="aloam_velodyne" type="kittiHelper" output="screen">
          <param name="dataset_folder" type="string" value="/home/user/data/dataset/" />
          # set value DATASET_FOLDER_LOCATION/dataset/

          <param name="sequence_number" type="string" value="00" />
          <param name="to_bag" type="bool" value="false" />
          <param name="output_bag_file" type="string" value="/tem/kitti.bag" />
          <param name="publish_delay" type="int" value="1" />
      </node>
  </launch>
  ```

  6. run a_loam and run kitti_helper
  - input command line in terminal
  ```
  roslaunch aloam_velodyne aloam_velodyne_HDL_64.launch
  roslaunch aloam_velodyne kitti_helper.launch
  ```
