# install dependencies
# realsense-sdk (2.50.0)
sudo apt-get install git libssl-dev libusb-1.0-0-dev libudev-dev pkg-config libgtk-3-dev -y
cd ~/
## clone realsense sdk
git clone https://github.com/IntelRealSense/librealsense.git
cd librealsense
git checkout v2.50.0
## install
bash scripts/setup_udev_rules.sh  
mkdir build
cd build
cmake .. -DBUILD_EXAMPLES=true -DCMAKE_BUILD_TYPE=release -DFORCE_RSUSB_BACKEND=false -DBUILD_WITH_CUDA=true && make -j$(($(nproc)-1)) && sudo make install

# ros driver
## workdir
mkdir -p ~/realsense_ws/src
cd ~/realsense_ws/src
## clone ros1 driver
git clone https://github.com/IntelRealSense/realsense-ros.git -b ros1-legacy
cd ~/realsense_ws
## install
catkin_make -DCATKIN_ENABLE_TESTING=False -DCMAKE_BUILD_TYPE=Release
echo "source ~/realsense_ws/devel/setup.bash" >> ~/.bashrc
