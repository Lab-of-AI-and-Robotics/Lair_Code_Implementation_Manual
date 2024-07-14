# Modified base img
FROM osrf/ros:noetic-desktop-full
ARG ROS_DISTRO=noetic
RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y gnupg2 curl lsb-core vim wget python3-pip libpng16-16 libjpeg-turbo8 libtiff5 nano net-tools
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

RUN apt-get install -y \
        # Base tools
        cmake \
        build-essential \
        git \
        unzip \
        pkg-config \
        python3-dev \
        # OpenCV dependencies
        python3-numpy \
        # Pangolin dependencies
        libgl1-mesa-dev \
        libglew-dev \
        libpython3-dev \
        libeigen3-dev \
        apt-transport-https \
        ca-certificates\
        software-properties-common

RUN curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
RUN add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
RUN apt update
RUN apt install -y sublime-text

RUN apt-get install -y python3-dev python3-numpy 
RUN apt-get install -y python-dev python-numpy
RUN apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get install -y libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
RUN apt-get install -y libgtk-3-dev

RUN cd /tmp && git clone https://github.com/opencv/opencv.git && \
    cd opencv && \
    git checkout 4.4.0 && \
    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release -D BUILD_EXAMPLES=OFF  -D BUILD_DOCS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_TESTS=OFF -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j$nproc && make install && \
    cd / && rm -rf /tmp/opencv

## Build Pangolin
RUN cd /tmp && git clone https://github.com/stevenlovegrove/Pangolin && \
    cd Pangolin && git checkout v0.6 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 .. && \
    make -j$nproc && make install && \
    cd / && rm -rf /tmp/Pangolin

# realsense driver
WORKDIR /
RUN apt-get install git libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev ros-noetic-ddynamic-reconfigure -y
RUN git clone https://github.com/IntelRealSense/librealsense.git
WORKDIR /librealsense
RUN git checkout v2.50.0
RUN mkdir build
WORKDIR /librealsense/build
RUN cmake .. -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=release -DFORCE_RSUSB_BACKEND=false -DBUILD_WITH_CUDA=false && make -j$(($(nproc)-1)) && sudo make install
RUN mkdir -p /realsense_ws/src
WORKDIR /realsense_ws/src
RUN git clone https://github.com/IntelRealSense/realsense-ros.git -b ros1-legacy
WORKDIR /realsense_ws
RUN /bin/bash -c ". /opt/ros/noetic/setup.bash; cd /realsense_ws; catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release"

WORKDIR /
RUN git clone https://github.com/Lab-of-AI-and-Robotics/ORB_SLAM3.git
RUN echo "export ROS_PACKAGE_PATH=/opt/ros/noetic/share:PATH:/ORB_SLAM3/Examples_old/ROS" >> ~/.bashrc
WORKDIR /ORB_SLAM3
# build dependencies and ORB-SLAM3
RUN ./build.sh
# build ros version
## symbolic link
RUN rm /usr/bin/python && ln -s /usr/bin/python3.8 /usr/bin/python
## build
RUN /bin/bash -c ". /opt/ros/noetic/setup.bash && export ROS_PACKAGE_PATH=/opt/ros/noetic/share:PATH:/ORB_SLAM3/Examples_old/ROS && ./build_ros.sh"
RUN echo "source /ORB_SLAM3/Examples_old/ROS/ORB_SLAM3/build/devel/setup.bash" >> ~/.bashrc
RUN echo "source /realsense_ws/devel/setup.bash" >> ~/.bashrc
# # download demo dataset
RUN mkdir /dataset
RUN wget -O /dataset/test.bag http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_02_easy/MH_02_easy.bag
