FROM osrf/ros:melodic-desktop-full
ARG DEBIAN_FRONTEND=noninteractive

# Default settings
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y curl wget gedit
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
WORKDIR /
RUN mkdir -p catkin_ws/src
## realsense driver
RUN apt-get install -y ros-melodic-realsense2-camera

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
## build
WORKDIR /catkin_ws
RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make"
# RUN catkin_make
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc
## get test dataset
WORKDIR /
RUN mkdir dataset
WORKDIR /dataset
RUN wget -O vins_test.bag "https://star-center.shanghaitech.edu.cn/seafile/d/0ea45d1878914077ade5/files/?p=/Normal.bag&dl=1"
RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; rosbag decompress vins_test.bag"
RUN rm vins_test.orig.bag
WORKDIR /