# How to implement Depth Camera

last update 2022 10.31 by Minjae Lee. <br>


<br>

[Official link](https://www.intelrealsense.com/get-started-depth-camera/) <br/>


### There are two types of install (Ubuntu, Windows) -> i install at Ubuntu enviroment


0. Register the server's public key
```
$ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
```


1. Add the server to 
```
$ sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
```

2. Install the libraries
```
$ sudo apt-get install librealsense2-dkms
$ sudo apt-get install librealsense2-utils
```

3. Optionally install the developer and debug packages:
```
$ sudo apt-get install librealsense2-dev
$ sudo apt-get install librealsense2-dbg
```


4. check version 
```
$ modinfo uvcvideo | grep "version:"
```

5. implement the viewer
```
$ realsense-viewer
```

<br/>

6. I tested in my laboratory. (Depth mode)

<img width="30%" src="https://user-images.githubusercontent.com/79103625/199165367-cf179213-219c-485d-a115-f4f5d1913416.png"/>
<img width="30%" src="https://user-images.githubusercontent.com/79103625/199165420-4800a14d-fe85-406a-911b-9799251ab723.png"/>