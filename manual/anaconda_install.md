# anaconda install
============================
## 1. 아나콘다 설치방법

  1.  아나콘다 공식 홈페이지 접속
  [https://www.anaconda.com/](https://www.anaconda.com/)
  <br/>

  2. 아나콘다 설치 파일 다운로드
  **Anaconda3-2022.05-Linux-x86_64.sh** 파일 다운로드
  파일명이 다를수 있으니 주의
  <br/>

  3. 터미널 창을 연 뒤, 해당 명령어 입력
  이때 다운로드 받은 설치파일에 맞게 이름을 변경하여 명령어 입력
  ```
  $ cd ~/Downloads
  $ chmod 777 Anaconda3-**-Linux-**.sh
  $ ./Anaconda3-**-Linux-**.sh
  ```

  4. 이후 터미널창의 명령에 따라 진행
  (ENTER 혹은 y 입력)
  <br/>

  5. 설치 완료 후 새로운 터미널 창을 열때 다음과 같이 출력되면 설치 완료
  ```
  (base) user@user:~$
  ```

============================

## 2. 아나콘다 사용 명령어

1. 아나콘다 가상환경 생성
  ```
  $ conda create -n 가상환경이름 python=설치할 파이썬 버전
  ```

2. 아나콘다 가상환경 활성화
  ```
  $ conda activate 가상환경이름
  ```
3. 아나콘다 가상환경 비활성화
  ```
  $ conda deactivate
  ```

4. 아나콘다 의존성 패키지 설치 및 제거
```
$ conda install 패키지명
```
  - 의존성 패키지를 삭제할때는 다음 명령어 입력
  ```
  $ conda uninstall 패키지명
  ```
  - 혹은 pip을 이용하여 설치 가능

5. 설치하고자 하는 패키지 버전 검색
```
$ conda search 패키지명
```
- 예시) 딥러닝을 하기위한 CUDA 설치 시
```
$ conda create -n test_env python=3.9.15
$ conda activate test_env
$ conda search cudatoolkit
$ conda install cudatoolkit=쿠다버젼
```

7. 아나콘다 가상환경 삭제
```
$ conda env remove -n 가상환경이름
```
