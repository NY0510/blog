---
title: "Swap 설정 및 Nginx서버 설치"
summary: "오라클 클라우드 무료티어를 사용해 나만의 '평생' 무료 VPS를 만들어보자 [2]"
categories: ["강좌", "오라클 클라우드", "리눅스"]
date: 2022-02-16
comments: true
tags:
    - Ubuntu
    - Oracle Cloud
    - Cloud
    - Server
    - Nginx
    - Swap
---

[지난번](https://blog.ny64.kr/posts/create-your-own-lifetime-free-server-using-oracle-cloud/)에 만든 오라클 평생 무료 서버에 SWAP 설정과 Nginx설치 및 방화벽 설정을 해 봅시다.

```sh
ssh -i 'Private KEY' ubuntu@IP주소
```

서버에 SSH 접속을 합니다.

## SWAP 설정

우리가 만든 평생 무료 서버는 **1GB**의 RAM을 가지고 있어, 램이 부족한 상황을 예방하기 위해 **4GB**의 SWAP을 생성해 줍시다.

이전에 SWAP에 대해 다룬 적이 있기 때문에 이 글에서는 자세한 설명은 생략하겠습니다.

명령어별 자세한 설명을 원한다면 [이 글](https://blog.ny64.kr/posts/setting-up-swap-on-raspberry-pi/)을 참고하시기 바랍니다.

아래 명령어를 차례대로 실행합니다.

```sh
sudo fallocate -l 4G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

그리고 나서 서버를 재시작해도 설정값이 유지되도록 `/etc/fstab`을 수정해 줍시다.

```sh
sudo nano /etc/fstab
```

제일 하단에 아래 내용을 추가하고 저장합니다.

```sh
/swapfile swap swap defaults 0 0
```

이제 `free -h` 명령어를 사용해 보시면 우리가 설정한 **4GB**의 SWAP이 잘 잡혀있는걸 확인할 수 있습니다.

```sh
ubuntu@OracleVM:~$ free -h
              total        used        free      shared  buff/cache   available
Mem:          972Mi       281Mi       107Mi       0.0Ki       583Mi       553Mi
Swap:         4.0Gi       118Mi       3.9Gi
```

## Nginx 설치

24시간 가동되는 오라클 서버에 간단한 웹 서버를 설치해 봅시다.

업데이트 후 Nginx 웹서버를 설치합니다.

```sh
sudo apt-get update
sudo apt-get install nginx -y
```

Nginx 서비스가 정상 작동 중인 것을 확인할 수 있습니다.

```sh
ubuntu@OracleVM:~$ systemctl status nginx
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2022-01-31 13:44:32 KST; 2 weeks 2 days ago
       Docs: man:nginx(8)
   Main PID: 16284 (nginx)
      Tasks: 3 (limit: 1110)
     Memory: 3.1M
     CGroup: /system.slice/nginx.service
             ├─16284 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             ├─16285 nginx: worker process
             └─16286 nginx: worker process

Jan 31 13:44:32 OracleVM systemd[1]: Starting A high performance web server and a reverse proxy server...
Jan 31 13:44:32 OracleVM systemd[1]: Started A high performance web server and a reverse proxy server.
```

혹시나 설치 후 서비스 자동 시작이 안되는 경우는 아래 명령어를 실행해 주세요.

```sh
sudo systemctl enable nginx
sudo systemctl start nginx
```

## 방화벽 설정

지금 이 상태에서는 80번 포트가 열려있지 않아 웹 서버에 접속할 수 없습니다.

[오라클 클라우드](https://cloud.oracle.com/)에 접속한 뒤

컴퓨트 > 인스턴트 > 자신의 인스턴트 상세페이지로 이동한 다음 서브넷을 클릭합니다.

{{< img src="/posts/oracle-cloud-swap-setup-and-nginx-installation/images/image01.png" title="인스턴트 상세페이지" >}}

그런 다음 보안 목록을 클릭합니다.

{{< img src="/posts/oracle-cloud-swap-setup-and-nginx-installation/images/image02.png" title="서브넷 상세페이지" >}}

80번 포트에 대한 수신 규칙을 추가합니다.

| 값             | 키        |
| -------------- | --------- |
| 소스 CIDR      | 0.0.0.0/0 |
| IP 프로토콜    | TCP       |
| 소스 포트 범위 | 80        |
| 대상 포트 범위 | 80        |

{{< img src="/posts/oracle-cloud-swap-setup-and-nginx-installation/images/image03.png" title="수신규칙 추가" >}}

이제 클라우드 웹 패널에서 할 작업은 모두 끝났고, SSH로 돌아가 아래 명령어로 80번 포트를 열어줍시다.

```sh
sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
```

방화벽 설정이 정상적으로 적용되었는지 확인을 위해 오라클 클라우드 IP를 주소창에 입력해서 접속해 보세요.

아래처럼 Nginx 기본 페이지가 나오면 성공입니다.

{{< img src="/posts/oracle-cloud-swap-setup-and-nginx-installation/images/image04.png" title="Welcome to the nginx!" >}}

서버에 설치된 Nginx 웹서버를 파일서버, 정적 웹서버, 프록싱 서버 등 다양한 용도로 활용할 수 있습니다.
