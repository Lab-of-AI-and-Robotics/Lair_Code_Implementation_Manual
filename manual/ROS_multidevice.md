### Transporting messages between the local environment and a docker container
- To send/receive message between local environment and docker containers, we consider each environment as separate device.
- In ROS1, communication between different devices (environments) is managed by ROS Master that exists on one device. Therefore, the devices (environments) are devided into two categories:
  - ROS_master: The one device (environment) where the ROS Master is running
  - ROS_host: All other devices
- In this manual, we define the local environment as ROS_master, and the Docker containers as ROS_hosts.
#### For ROS_master (local environment)
- Check local environment's ip address
  - Type this command in the terminal of **local environment** to check ip address.
    ```bash
    ifconfig
    ```
  - Find IP address of "docker*". In this case, it is "172.17.0.1".
    ```
    docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
          inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
          inet6 fe80::42:5dff:fe72:2ca7  prefixlen 64  scopeid 0x20<link>
          ether 02:42:5d:72:2c:a7  txqueuelen 0  (Ethernet)
          RX packets 5897630  bytes 318353090 (318.3 MB)
          RX errors 0  dropped 0  overruns 0  frame 0
          TX packets 11605062  bytes 18200502772 (18.2 GB)
          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    eno1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
          ether c8:7f:54:57:e3:6e  txqueuelen 1000  (Ethernet)
          RX packets 92126  bytes 43317436 (43.3 MB)
          RX errors 0  dropped 0  overruns 0  frame 0
          TX packets 74982  bytes 10726528 (10.7 MB)
          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
          device memory 0xfc200000-fc2fffff  

    lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
          inet 127.0.0.1  netmask 255.0.0.0
          inet6 ::1  prefixlen 128  scopeid 0x10<host>
          loop  txqueuelen 1000  (Local Loopback)
          RX packets 7336513  bytes 114729434979 (114.7 GB)
          RX errors 0  dropped 0  overruns 0  frame 0
          TX packets 7336513  bytes 114729434979 (114.7 GB)
          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
    ```
- Specify IP address of ROS_master and ROS_host. (In this manual, we consider local environment as ROS_master, and docker environment as ROS_host)
  ```bash
  export ROS_MASTER_URI=http://172.17.0.1:11311
  export ROS_IP=172.17.0.1
  export ROS_HOSTNAME=$ROS_IP
  ```
#### For ROS_hosts (docker containers)
- Check docker container's ip address
  - Type this command in the terminal of **docker container**.
    ```bash
    ifconfig
    ```
  - Find IP address of "docker*". In this case, it is "172.17.0.2". (This ip address can be same as that of local environment.)
    ```
    docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.2  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:5dff:fe72:2ca7  prefixlen 64  scopeid 0x20<link>
        ether 02:42:5d:72:2c:a7  txqueuelen 0  (Ethernet)
        RX packets 5897630  bytes 318353090 (318.3 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11605062  bytes 18200502772 (18.2 GB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

    eno1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether c8:7f:54:57:e3:6e  txqueuelen 1000  (Ethernet)
        RX packets 92126  bytes 43317436 (43.3 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 74982  bytes 10726528 (10.7 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device memory 0xfc200000-fc2fffff
    ```
- Specify IP address of ROS_master and ROS_host. (In this manual, we consider local environment as ROS_master, and docker environment as ROS_host)
    ```bash
    export ROS_MASTER_URI=http://172.17.0.1:11311 # write local environment's ip address here
    export ROS_IP=172.17.0.2 # write docker container's ip address here
    export ROS_HOSTNAME=$ROS_IP
    ```