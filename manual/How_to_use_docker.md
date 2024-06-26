# How to Use Docker
last update 2023.10.11 by Seongbo Ha. <br>


# Environment
Ubuntu 20.04

<br>
<br>

# Install

### Install docker
```bash
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
```
설치 확인
```bash
docker --version
```

### Docker without sudo
```bash
sudo usermod -aG docker ${USER}
# reboot
```

### To use gui in docker environment
```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

<br>
<br>

# How to use
### Docker system
<img width="70%" src="https://github.com/Lab-of-AI-and-Robotics/Lair_Code_Implementation_Manual/blob/main/images/docker_1.png"/>
<br>
Container : 도커를 통해 생성한 가상환경 <br>
Image : 가상환경을 만들기 위한 것, 컨테이너 실행에 필요한 파일과 설정값들을 포함<br>
Image는 직접 만들 수도 있고, 누군가 만들어둔 것을 가져와 사용하는 것도 가능
<br>

### Docker image
##### pull
Todo
##### Import image from file
```bash
docker import [이미지 파일 경로] [태그:이름]
# ex)
docker import melodic.tar ros:melodic
```
##### Export image from current container
컨테이너를 파일 형태의 이미지로 저장
```bash
docker export [컨테이너 이름] > [출력할 파일 경로]
# ex)
docker export melodic > melodic.tar
```
##### Check images
저장된 이미지들 확인
```bash
docker images
```

##### Remove image
```bash
docker rmi [이미지 id]
```


<br>

### Docker container

```bash
docker run -it -v [공유할 디렉토리:대상 디렉토리] --name [컨테이너 이름] [태그명:이미지명] /bin/bash
```
-v
  - 원래 컴퓨터의 디렉토리와 컨테이너(가상환경)의 디렉토리를 공유하고자 하는 경우 사용
  - 공유할 디렉토리
    - 원래 컴퓨터에서 컨테이너와 공유하고자 하는 디렉토리 주소 입력
  - 대상 디렉토리
    - 원래 컴퓨터의 "공유할 디렉토리"를 컨테이너(가상환경)의 어느 경로와 연결할지 정의
  - 예시
    - -v ~/dataset:/home/dataset 으로 사용한 경우
      - 원래 컴퓨터의 ~/dataset 폴더와 컨테이너(가상환경)의 /home/dataset 폴더가 연결된다


##### Run container with GUI
컨테이너에서 GUI를 사용하려면 컨테이너를 실행할 때 별도의 옵션을 사용해야 한다.

```bash
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -e USER=$USER -e runtime=nvidia -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_VISIBLE_DEVICES=all --net host --gpus all --privileged --name [컨테이너 이름] [태그명:이미지명] /bin/bash
```
이후 컨테이너에서 GUI를 사용할 때 권한 문제가 생기면 원래 컴퓨터 터미널에서
```bash
xhost +
```

##### Check containers
현재 실행중인 컨테이너 목록 확인
```bash
docker ps
```
"docker ps"는 현재 "실행중"인 컨테이너의 목록만 출력함 <br>
실행중이지 않은 컨테이너 포함, 모든 컨테이너 목록을 확인하려면
```bash
docker ps -a
```

##### 실행된 컨테이너에 접근
"docker run~~" 명령어로 컨테이너 생성 및 실행
이미 실행된 컨테이너에 접근하기 위해서는 "run" 명령어가 아닌 "exec" 명령어 사용
```bash
docker exec -it [container name] /bin/bash
```


##### Remove container
```bash
docker rm [컨테이너 id]
```

<br>
<br>

# ROS with Docker
Todo