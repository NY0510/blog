---
title: "라즈베리파이로 FM 라디오 방송국 만들기"
summary: "라즈베리파이를 FM 송신기로!"
categories: ["강좌", "라즈베리파이", "리눅스"]
date: 2021-12-18
comments: true
tags:
    - Raspberry PI
    - FM Radio
    - GPIO
---

라즈베리파이로 간단하게 FM 라디오 송신기를 만들어 보겠습니다.

**준비물**

-   라즈베리파이
-   점퍼선 1개 (암암 또는 암수)
-   라디오

## 점퍼선 연결

안테나 역할을 할 점퍼선을 **GPIO 4번핀**(7번째 핀) 에 연결합니다.
{{< img src="https://docs.microsoft.com/en-us/dotnet/iot/media/gpio-pinout-diagram.png" title="GPIO 핀맵" >}}
{{< img src="/posts/create-an-fm-radio-station-with-raspberry-pi/images/raspberrypi-gpio-pin.jpg" title="GPIO 핀 연결" >}}

## 프로그램 설치

점퍼선을 연결한 다음 이제 FM 송출을 할 수 있는 프로그램을 설치합시다.

만약 OS가 라즈비안이 아니라 우분투라면 `sudo apt-get install libraspberrypi-dev` 명령어를 추가로 실행해 주세요.

```sh
sudo apt-get update
sudo apt-get install make build-essential
sudo apt-get install sox libsox-fmt-mp3
```

깃허브에서 레파지토리를 클론한 다음, 실행 파일을 빌드해 줍시다.

```sh
git clone https://github.com/markondej/fm_transmitter
cd fm_transmitter
make
```

## 라디오 송출

라즈베리파이에 송출할 **무압축 WAV 형식** 파일을 라즈베리파이로 전송해 줍니다.

만약 MP3 파일이라면 아래 명령어를 사용해 변환해 주세요.

```sh
sox mp3파일.mp3 -r 22050 -c 1 -b 16 -t wav wav파일.wav
```

이제 아래 명령어로 FM 라디오를 송출을 시작합니다.

```sh
# 97.7 Mhz로 wav파일.wav 송출
sudo ./fm_transmitter -f 97.7 -r wav파일.wav
```

위처럼 실행한 다음 라디오로 주파수를 맞춰보면 라디오에서 음악이 재생되는 것을 확인할 수 있습니다.

{{< img src="/posts/create-an-fm-radio-station-with-raspberry-pi/images/radio_app.jpg" title="라디오 앱" >}}
