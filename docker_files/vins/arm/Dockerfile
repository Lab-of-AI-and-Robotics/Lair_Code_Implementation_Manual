FROM arm64v8/ros:noetic-ros-base
ARG DEBIAN_FRONTEND=noninteractive

# Default settings
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y curl wget gedit git net-tools
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
WORKDIR /
RUN mkdir -p catkin_ws/src

# ros full pkg
RUN apt-get install -y ros-noetic-desktop-full

# realsense driver
## realsense-sdk
#RUN git clone https://github.com/IntelRealSense/librealsense.git
#WORKDIR /librealsense
#RUN git checkout v2.50.0
#RUN apt-get install git libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev -y
#RUN ./scripts/setup_udev_rules.sh  
#RUN mkdir build
#WORKDIR /librealsense/build
#RUN /bin/bash -c "cmake .. -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=release -DFORCE_RSUSB_BACKEND=false -#DBUILD_WITH_CUDA=true && make -j$(($(nproc)-1)) && sudo make install"
## ros driver
#RUN mkdir -p /realsense_ws/src
#WORKDIR /realsense_ws/src
#RUN git clone https://github.com/IntelRealSense/realsense-ros.git -b ros1-legacy
#WORKDIR /realsense_ws
#RUN catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
#RUN catkin_make install

# VINS-RGBD
## Ceres
WORKDIR /
RUN apt-get install -y libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev
RUN git clone --depth 1 --branch 1.14.0 https://ceres-solver.googlesource.com/ceres-solver
WORKDIR /ceres-solver
RUN mkdir build && cd build && cmake .. 
WORKDIR /ceres-solver/build
RUN make -j8 all install
WORKDIR /
RUN rm -rf /ceres-solver
## Sophus
RUN git clone https://github.com/demul/Sophus.git
WORKDIR /Sophus
RUN git checkout fix/unit_complex_eror
RUN mkdir /Sophus/build
WORKDIR /Sophus/build
RUN cmake .. && make -j8 install
WORKDIR /
RUN rm -rf /Sophus

## clone vins-rgbd repo
WORKDIR /catkin_ws/src
RUN git clone https://github.com/Lab-of-AI-and-Robotics/VINS-RGBD.git
# build
WORKDIR /catkin_ws
RUN /bin/bash -c ". /opt/ros/noetic/setup.bash; cd /catkin_ws; catkin_make"
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
## get test dataset
WORKDIR /
RUN mkdir dataset
WORKDIR /dataset
RUN wget -O vins_test.bag "https://star-center.shanghaitech.edu.cn/seafile/d/0ea45d1878914077ade5/files/?p=/Normal.bag&dl=1"
RUN /bin/bash -c ". /opt/ros/noetic/setup.bash; rosbag decompress vins_test.bag"
RUN rm vins_test.orig.bag
WORKDIR /
