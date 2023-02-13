---
title: "우분투 CD 미러서버 구축하기"
summary: "미러서버를 구축하고 공식 미러로 등록해보자"
categories: ["강좌", "리눅스"]
date: 2022-11-26T19:25:29+09:00
comments: true
tags:
    - Ubuntu
    - CD Mirror
    - Mirror
---

대한민국에는 대표적인 우분투 CD 미러 서버로 [카카오 미러와](https://mirror.kakao.com/ubuntu-releases/) [카이스트 미러](https://ftp.kaist.ac.kr/ubuntu-cd/)가 있습니다.

이러한 미러 서버를 직접 구축해보고자 합니다.

우분투 미러에는 APT 미러와 CD 미러가 있는데, APT 미러를 개인이 구축하기엔 조금 부담스러운 용량이 필요하기에 CD 미러를 구축해 보았습니다.

APT 미러를 구축하려면 최소 200GB 이상의 용량이 필요하지만, CD 미러는 30~40GB 정도면 충분합니다.

## 필요한 페키지 설치

### NGINX 웹서버 설치

우분투 미러를 HTTP 프로토콜로 서비스 하기 위해서는 웹서버가 필요합니다.

```sh
sudo apt update && sudo apt install nginx
```

NGINX 웹서버를 설치합니다.

```sh
sudo nano /etc/nginx/sites-available/default
```

```nginx
server {
    listen 80;
    listen [::]:80;

    # 미러 서버의 도메인
    server_name mirror.example.com;

    # 미러 서버의 루트 디렉토리
    root /var/www/mirror;

    location / {
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
    }
}
```

NGINX 가상 호스트 파일을 열어, Virtual Host를 추가합니다.

```sh
sudo systemctl restart nginx
```

그런 다음, NGINX 웹서버를 재시작합니다.

### rsync 설치

rsync는 파일을 동기화하는데 사용되는 프로토콜입니다.

원본 미러 서버와 파일 동기화에 rsync를 사용하므로 rsync를 설치해 줍시다.

```sh
sudo apt update && sudo apt install rsync
```

## 동기화 스크립트 작성

```sh
mkdir ~/sync
nano ~/sync/ubuntu-cd-mirror-sync.sh
```

```sh
#/bin/dash

fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}

# 동기화할 원본 미러 서버
RSYNCSOURCE=rsync://kr.rsync.releases.ubuntu.com/releases

# 파일을 저장할 디렉토리
BASEDIR=/var/www/mirror

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --verbose --recursive --times --links --safe-links --hard-links \
  --stats --delete-after \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."

date -u > ${BASEDIR}/.trace/$(hostname -f)
```

저장할 폴더를 생성한 뒤 스크립트를 작성합니다.

주석을 참고하여 알맞게 수정해 줍니다.

`BASEDIR`에는 [여기서](#nginx-웹서버-설치) 설정한 루트 디렉토리를 입력합니다.

```sh
sudo chmod +x ~/sync/ubuntu-cd-mirror-sync.sh
bash /home/$USER/sync/ubuntu-cd-mirror-sync.sh
```

실행 권한을 부여하고, 스크립트를 실행해 봅시다.

원본 미러 서버에서 파일을 받아오는 것을 확인할 수 있습니다.

## 자동 동기화 설정

공식 미러로 등록되려면 최소 6시간마다 동기화를 해야 합니다.

자동으로 동기화를 해주기 위해 crontab 설정을 해줍시다.

```sh
crontab -e
```

```sh
0 4,10,16,22 * * * /home/$USER/sync/ubuntu-cd-mirror-sync.sh >> /home/$USER/sync/ubuntu-cd-mirror-sync.log 2>&1
```

매일 4시, 10시, 16시, 22시에 동기화를 진행하고, 로그를 `/home/$USER/sync/ubuntu-cd-mirror-sync.log`에 저장합니다.

`$USER`에는 동기화를 진행하는 사용자 이름을 입력합니다.

## 공식 미러 등록

공식 미러 리스트에 등록을 위해 [여기](https://launchpad.net/ubuntu/+cdmirrors)에 접속합니다.

우측 상단의 **Register a new mirror**를 클릭합니다.

{{< img src="/posts/setup-ubuntu-cd-mirror-server/images/image01.png" title="Register a new mirror 클릭" >}}

미러 서버에 대한 정보를 입력하고 하단의 **Register Mirror**를 클릭합니다.

{{< img src="/posts/setup-ubuntu-cd-mirror-server/images/image02.png" title="미러 서버 정보 입력" >}}

몇일 후 확인해보면 공식 미러 리스트에 등록된 것을 확인할 수 있습니다.

{{< img src="/posts/setup-ubuntu-cd-mirror-server/images/image03.png" title="대한민국 공식 미러 리스트" >}}

> 미러 서버에 접속이 불가능하거나, 동기화가 정상적으로 이루어지지 않는다고 판단되면 미러 리스트에서 제외될 수 있습니다.

> 그럴 경우 재등록을 할 필요 없이 문제가 해결되면 자동으로 미러 리스트에 다시 등록됩니다.
