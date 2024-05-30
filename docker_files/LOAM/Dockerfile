FROM osrf/ros:melodic-desktop-full
ARG DEBIAN_FRONTEND=noninteractive

#Default Settings
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y curl wget gedit
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
WORKDIR /
RUN mkdir -p catkin_ws/src

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
RUN git clone --depth 1 --branch 1.14.0 https://ceres-solver.googlesource.com/ceres-solver 
RUN cd ceres-solver && mkdir build && cd build && cmake .. && make -j16 all install
WORKDIR /catkin_ws/src
RUN rm -rf ceres-solver
## git clone A-LOAM
WORKDIR /catkin_ws/src
RUN git clone https://github.com/Lab-of-AI-and-Robotics/A-LOAM_ouster64ch.git

# Ouster ros driver
# ## Dependencies
# RUN apt-get install -y build-essential libjsoncpp-dev libspdlog-dev libcurl4-openssl-dev
# ## git clone
# RUN git clone --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git


RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make"
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Download Demo data
WORKDIR /
RUN mkdir dataset
WORKDIR /dataset
RUN wget -O ouster_64.bag "https://data.ouster.io/sample-data-1.13/OS1-64/OS1-64_freeway2.bag"

# 

WORKDIR /