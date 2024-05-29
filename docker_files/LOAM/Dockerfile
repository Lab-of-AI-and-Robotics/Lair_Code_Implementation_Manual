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

     
# install dependence for ceres

RUN apt-get install -y cmake
RUN apt-get install -y libgoogle-glog-dev libgflags-dev
RUN apt-get install -y libatlas-base-dev
RUN apt-get install -y libeigen3-dev
RUN apt-get install -y libsuitesparse-dev

#Download ceres-solver and install

WORKDIR /catkin_ws/src
RUN git clone --depth 1 --branch 1.14.0 https://ceres-solver.googlesource.com/ceres-solver 
RUN cd ceres-solver && mkdir build && cd build && cmake .. && make -j16 all install
WORKDIR /catkin_ws/src
RUN rm -rf ceres-solver

#Build A-LOAM
WORKDIR /catkin_ws/src
RUN git clone https://github.com/HKUST-Aerial-Robotics/A-LOAM.git

WORKDIR /catkin_ws
RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make"
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc