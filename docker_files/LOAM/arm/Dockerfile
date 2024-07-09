FROM arm64v8/ros:noetic-ros-base
ARG DEBIAN_FRONTEND=noninteractive

#Default Settings
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y curl wget gedit git net-tools
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
WORKDIR /
RUN mkdir -p catkin_ws/src

# full ros
RUN apt-get install -y ros-noetic-desktop-full

# A-LOAM
## Ceres
### dependencies
RUN apt-get install -y cmake
RUN apt-get install -y libgoogle-glog-dev libgflags-dev
RUN apt-get install -y libatlas-base-dev
RUN apt-get install -y libeigen3-dev
RUN apt-get install -y libsuitesparse-dev
### Download ceres-solver and install
WORKDIR /catkin_ws/src
RUN git clone --depth 1 --branch 2.2.0 https://ceres-solver.googlesource.com/ceres-solver 
RUN cd ceres-solver && mkdir build && cd build && cmake .. && make -j16 all install
WORKDIR /catkin_ws/src
RUN rm -rf ceres-solver
## git clone A-LOAM
WORKDIR /catkin_ws/src
RUN git clone https://github.com/Lab-of-AI-and-Robotics/A-LOAM_ouster64ch.git

# Ouster ros driver
RUN git clone https://github.com/Lab-of-AI-and-Robotics/Ouster_driver.git

# Build ROS packages
RUN /bin/bash -c ". /opt/ros/noetic/setup.bash; cd /catkin_ws; catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release"
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Download Demo data
WORKDIR /
RUN mkdir dataset
WORKDIR /dataset
RUN wget -O ouster_64.bag "https://data.ouster.io/sample-data-1.13/OS1-64/OS1-64_freeway2.bag"

# init
WORKDIR /
