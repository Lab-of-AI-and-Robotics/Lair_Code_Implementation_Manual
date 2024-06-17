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
RUN apt-get install -y libgtsam-dev libgtsam-unstable-dev

# LIO-SAM
WORKDIR /catkin_ws/src
RUN git clone https://github.com/Lab-of-AI-and-Robotics/LIO-SAM_ouster.git
# Ouster ros driver
RUN git clone https://github.com/Lab-of-AI-and-Robotics/Ouster_driver.git
# vn-200 ros driver
# RUN git clone https://github.com/dawonn/vectornav.git
# wit-motion(i) ros driver
RUN apt-get install -y libqt5serialport5-dev
RUN git clone https://github.com/Lab-of-AI-and-Robotics/witmotion_driver.git
# LiDAR-IMU calibration
## to tackle errors
RUN mv /usr/include/flann/ext/lz4.h /usr/include/flann/ext/lz4.h.bak
RUN mv /usr/include/flann/ext/lz4hc.h /usr/include/flann/ext/lz4.h.bak
RUN ln -s /usr/include/lz4.h /usr/include/flann/ext/lz4.h
RUN ln -s /usr/include/lz4hc.h /usr/include/flann/ext/lz4hc.h
RUN git clone https://github.com/chennuo0125-HIT/lidar_imu_calib.git

# build
# RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make"
RUN /bin/bash -c ". /opt/ros/melodic/setup.bash; cd /catkin_ws; catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release"
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc


WORKDIR /