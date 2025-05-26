# Unitree Go2
2025.05.26, updated by Seongbo Ha.

# Custom Cyclone DDS
- When call ros2 topic on external PC, one might get like below errors.
    ```bash
    dog1@dog1:~/ros2_ws$ ros2 topic list
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    bad_alloc caught: std::bad_alloc
    ```

- This is because unitree uses their custom cyclone dds for communicating ros topics, so we have to install related packages.
- Follow this repo (https://github.com/unitreerobotics/unitree_ros2)

# time sync
- master pc (jetson, 192.168.123.18)
    - install chrony
        ```bash
        sudo apt-get install chrony
        ```
    - settings
        ```bash
        sudo gedit /etc/chrony/chrony.conf
        ```
        In my case, I set master pc's ip as 192.168.123.18 (jetson pc)
        ```bash
        pool <master pc's ip> iburst maxsources 1
        ```
    - restart chrony
        ```bash
        sudo systemctl restart chronyd.service
        sudo systemctl restart chrony.service
        ```
- slave pc (external pc)
    - install chrony
        ```bash
        sudo apt-get install chrony
        ```
    - settings
        ```bash
        sudo gedit /etc/chrony/chrony.conf
        ```
        In my case, I set master pc's ip as 192.168.123.18 (jetson pc)
        ```bash
        pool <master pc's ip> iburst maxsources 1
        ```
    - restart chrony
        ```bash
        sudo systemctl restart chrony.service
        ```
    
