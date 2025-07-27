# Orbbec Femto Mega

last update 2025.07.27 by Seongbo Ha. <br>

## ROS2 driver
- clone ros2 driver (available on foxy, humble)
```bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
git clone https://github.com/orbbec/OrbbecSDK_ROS2.git
```
- install dependencies
```bash
sudo apt install libgflags-dev nlohmann-json3-dev  \
ros-$ROS_DISTRO-image-transport  ros-${ROS_DISTRO}-image-transport-plugins ros-${ROS_DISTRO}-compressed-image-transport \
ros-$ROS_DISTRO-image-publisher ros-$ROS_DISTRO-camera-info-manager \
ros-$ROS_DISTRO-diagnostic-updater ros-$ROS_DISTRO-diagnostic-msgs ros-$ROS_DISTRO-statistics-msgs \
ros-$ROS_DISTRO-backward-ros libdw-dev
```

- launch udev rules.
```bash
cd  ~/ros2_ws/src/OrbbecSDK_ROS2/orbbec_camera/scripts
sudo bash install_udev_rules.sh
sudo udevadm control --reload-rules && sudo udevadm trigger
```

- build
```bash
cd ~/ros2_ws
colcon build
```

## Run
- TODO: parameters
```bash
ros2 launch orbbec_camera femto_mega.launch.py
```