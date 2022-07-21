# How to implement velodyne_visualization

[유튜브 영상 설명 참고 링크](https://youtu.be/QtChxWFEVlk) <br/>
[위키로스 벨로다인 설명 링크](http://wiki.ros.org/velodyne/Tutorials/Getting%20Started%20with%20the%20Velodyne%20VLP16) <br/>
[루미솔 라이다 설명링크](http://www.lumisol.co.kr/sub/reference/lidar.asp?mode=view&bid=4&s_type=&s_keyword=&s_cate=&idx=212&page=1) <br/>



0. ipconfig 써야하는데 인식 못하면 명령어 로 설치해준다
```
$ sudo apt-get install net-tools
```


1. 패키지 다운해준다. (멜로딕, 키네틱, 등등 상황에 맞게해야함) 유튜브는 키네틱이지만, 우리실험실은 멜로딕 깔아서 멜로딕 해줌
```
$ sudo apt-get install ros-melodic-velodyne
```

2. mkdir명렁어로 폴더 catkin_ws/src 2개를 만들어준다
```
$ mkdir -p /catkin_ws/src
```

3. src폴더에서 git clone 명렁어로 다운해준다.
```
$ git clone https://github.com/ros-drivers/velodyne.git
```


4. 그후 src가 아닌 catkin_ws폴더로 이동한다.
```
$ cd ..
```


5. catkin_ws 폴더에서 빌드해준다 
```
$ catkin_make
```


<br/>

6. 그후 이더넷과 로컬 랜선 해제하고 벨로다인이랑 로컬이랑 랜선으로 연결해준다.


7. 명령어를 입력하여 벨로다인과 로컬이 잘 연결되었나 확인한다 (enp5s0은 라이더마다 가진 고유의 이름으로 랜선 연결후 `sudo ipconfig`로 이름을 확인할수 있다.) (연결확인전에 로컬에서 통신위한 ip를 설정해줘야 하는데, 네트워크 설정 들어가서 ipv4들어가고 수동으로 설정해서 입력할수 있게한다. 주소 192.168.1 까지는 동일하게 그뒤는 동일하지 않게 해준다. 네트마스크는 255.255.255.0 로 게이트웨이는 0.0.0.0으로 해준다 )
```
$ sudo ifconfig enp5s0 192.168.1.201
```

8. 브라우져를 통해 연결을 확인할수 있는데 주소창에 192.168.1.201를 입력하여 창에 들어갈수 있다. <br/>


9. 그후 새로운 터미널을 열고 catkin_ws/src에 들어 roslaunch를 한다 (띄워쓰기 주의 points.launch임)
```
$ cd src
$ roslaunch velodyne_pointcloud VLP16_points.launch
```

10. 새터미널을 띄워서 시각화툴 띄우는 명령어를 입력 (만약 안될경우 다른 터미널 열어서 roscore 또는 roslaunch 실행 해준다음 명령어 치면 된다)
```
$ rosrun rviz rviz -f velodyne
```

11. rviz를 이것저것 만지면서 관찰해본다 (실험실 데이터를 받아와 시각화가 잘 진행된것을 확인할수 있다)
![first_test](https://user-images.githubusercontent.com/79103625/178249246-bdf1a14a-b2d3-4f05-b640-4d9282d6a996.png)
