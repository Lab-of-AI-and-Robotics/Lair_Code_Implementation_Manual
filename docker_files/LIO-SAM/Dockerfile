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

# Dependencies
RUN apt-get install -y ros-melodic-navigation
RUN apt-get install -y ros-melodic-robot-localization
RUN apt-get install -y ros-melodic-robot-state-publisher
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:borglab/gtsam-release-4.0
RUN apt install -y libgtsam-dev libgtsam-unstable-dev

# LIO-SAM
## git clone
WORKDIR /catkin_ws/src
RUN git clone https://github.com/Lab-of-AI-and-Robotics/LIO-SAM_ouster.git
## build
WORKDIR /catkin_ws
RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make"
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc


WORKDIR /