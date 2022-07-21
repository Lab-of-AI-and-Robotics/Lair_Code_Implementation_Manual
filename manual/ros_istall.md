# How to install ros

[참고 링크](http://wiki.ros.org/melodic/Installation/Ubuntu) <- 우분투에 ros melodic 설치방법

1. sources.list 설정

```
$ sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```

<br/>

2. keys 설정

```
$ sudo apt install curl # if you haven't already installed curl
$ curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```

<br/>

3. 설치전 apt 업데이트

```
$ sudo apt update
```

<br/>

4. Desktop full 설치 (권장) -> ROS, rqt,rviz,robot-generic libraries, 2D/3D simulators and 2D/3D perception

```
$ sudo apt install ros-melodic-desktop-full
```

<br/>

5. 환경 세팅
  * 로스 환경변수 자동 추가해주는 세팅 (새로운 쉘 실행될때마다)
  
  ```
  $ echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
  $ source ~/.bashrc
  ```
  <br/>
  
  * 현재쉘에서 환경변수 수정 원하면 
  
  ```
  $ source /opt/ros/melodic/setup.bash
  ```
  <br/>
  
  * bash 대신 zsh사용하기 원하면
  
  ```
   $ echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
   $ source ~/.zshrc
   ```
   
<br/>
   
 6. 패키지 빌딩을 위한 의존성
   * too 또는 다른 로스패키지 빌딩 dependencies 설치하려면
   
   ```
   $ sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
   ```
   <br/>
   
   * ROS사용전 초기화 해줘야함
   
   ```
   $ sudo apt install python-rosdep
   ```
   ```
   $ sudo rosdep init
   $ rosdep update
   ```
   
   
## ros 설치후 테스트하기 (turtlesim)
<br/>

1. roscore 실행
   터미널을 열고 roscore 명령어를 실행한다. 그러면 ros 시스템을 관할하는 roscore가 실행된다 <br/>
   ```
   $ roscore
   ```

2. turtlesim 패키지의 turtlesim_node 실행
   **새로운 터미널**을 열고 다음 명령어를 실행한다. 그러면 info 들이 터미널에 출력되며, 파란색 배경에 거북이가 한마리 나온다 <br/>
   ```
   $ rosrun turtlesim turtlesim_node
   ```
   
3. turtlesim 패키지의 turtle_teleop_key 실행   
   **새로운 터미널**을 열고 다음 명령어를 실행한다. 그리고 터미널에서 방향키 움직이면 거북이가 움직인다. <br/>
   ```
   $ rosrun turtlesim turtle_teleop_key
   ```


<br/><br/>
위의 1~3이 잘 작동한다면 설치가 잘 완료된 것이다.

   <br/><br/>
   **이는 참고하여 적은것임으로 추후 수정이 필요할수 있음**
  
