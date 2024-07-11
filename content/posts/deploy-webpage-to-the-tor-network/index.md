---
title: "Tor 네트워크에 웹페이지 배포하기"
date: 2024-03-12T00:36:55+09:00
comments: true
categories: ["강좌"]
summary: "🧅 양파망에 웹 서비스를 배포해보자"
tags:
    - "Tor"
    - "Onion"
    - "Hidden Service"
    - "Web Server"
cover:
    image: "./images/deploy-webpage-to-the-tor-network.jpg"
    relative: true
---

## Tor 네트워크란

딥웹 또는 토르망, 양파망 이라고도 부르는 Tor 네트워크는 온라인 상에서의 검열을 피하고 익명성을 보장받기 위해 사용되는 네트워크입니다.

Tor의 주된 기능으로는 사용자의 트래픽을 여러 노드를 거쳐 전송함으로써 사용자의 실제 IP 주소를 숨기는 것이 있습니다.

## Tor 네트워크에 웹페이지 배포하기

먼저 웹 서버를 구동할 서버가 필요합니다. 이 글에서는 Nginx가 설치된 리눅스(Arch / Debian)를 대상으로 설명하겠습니다.

### Nginx 설치 및 시작

```bash
sudo pacman -S nginx # Arch Linux
sudo apt install nginx # Ubuntu / Debian

sudo systemctl start nginx
sudo systemctl enable nginx
```

Nginx가 정상적으로 설치되었는지 확인하기 위해 웹 브라우저에서 `http://localhost`로 접속해보면 Nginx의 기본 페이지가 나타납니다.

### Tor 설치 및 시작

앞서 설치했던 Nginx는 잠시 미뤄두고, 서버가 Tor 네트워크에 접속할 수 있도록 Tor 페키지를 설치합니다.

```bash
sudo pacman -S tor # Arch Linux
sudo apt install tor # Ubuntu / Debian

sudo systemctl start tor
sudo systemctl enable tor
```

### Tor Hidden Service 설정

현재 로컬호스트에서만 접속할 수 있는 웹 서버를 Tor 네트워크에 배포하려면 설정 파일을 수정해줘야 합니다.

에디터로 설정 파일을 열어줍니다.

```bash
sudo nano /etc/tor/torrc
```

파일의 상단 두 줄의 주석을 제거하고 아래와 같이 수정해줍니다.

`127.0.0.1:80` 부분은 현재 로컬에서 실행되고 있는 Nginx 웹서버의 주소입니다.

```conf
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:80
```

저장하고 나온 뒤, Tor를 재시작합니다.

```bash
sudo systemctl restart tor
```

### Tor Hidden Service 주소 확인

`/var/lib/tor/hidden_service/` 디렉토리에 `hostname` 파일이 생성되었습니다.

`xxxxxxxxxxxx.onion` 형태의 주소가 나타나는데, Tor 브라우저를 통해 해당 주소로 접속할 수 있습니다.

```bash
sudo su
cat /var/lib/tor/hidden_service/hostname
```
