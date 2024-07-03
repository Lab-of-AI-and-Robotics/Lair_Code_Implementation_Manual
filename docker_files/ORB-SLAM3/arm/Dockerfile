# Modified base img
FROM arm64v8/ros:noetic-ros-base
ARG ROS_DISTRO=noetic
RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y gnupg2 curl lsb-core vim wget python3-pip libpng16-16 libjpeg-turbo8 libtiff5 nano git
RUN apt-get install -y ros-noetic-desktop-full
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

# # Build Pangolin
RUN cd /tmp && git clone https://github.com/stevenlovegrove/Pangolin && \
    cd Pangolin && git checkout v0.6 && mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS=-std=c++11 .. && \
    make -j$nproc && make install && \
    cd / && rm -rf /tmp/Pangolin

RUN git clone https://github.com/Lab-of-AI-and-Robotics/ORB_SLAM3.git
RUN echo "export ROS_PACKAGE_PATH=/opt/ros/noetic/share:PATH:/ORB_SLAM3/Examples_old/ROS" >> ~/.bashrc
WORKDIR /ORB_SLAM3
# build dependencies and ORB-SLAM3
RUN ./build.sh
# build ros version
## symbolic link
RUN rm /usr/bin/python && ln -s /usr/bin/python3.8 /usr/bin/python
## build
RUN /bin/bash -c ". /opt/ros/noetic/setup.bash; export ROS_PACKAGE_PATH=/opt/ros/noetic/share:PATH:/ORB_SLAM3/Examples_old/ROS; ./build_ros.sh"
RUN echo "source /ORB_SLAM3/Examples_old/ROS/ORB_SLAM3/build/devel/setup.bash" >> ~/.bashrc

# # download demo dataset
RUN mkdir /dataset
RUN wget -O /dataset/test.bag http://robotics.ethz.ch/~asl-datasets/ijrr_euroc_mav_dataset/machine_hall/MH_02_easy/MH_02_easy.bag
