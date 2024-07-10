---
title: "Swap 설정하기"
summary: "메모리가 부족하다면 디스크를 메모리처럼 사용하자"
categories: ["강좌"]
date: 2021-07-24
comments: true
tags:
    - Raspberry PI
    - Swap
---

이번 포스트에서는 라즈베리파이에 Swap 설정을 해보겠습니다.

## Swap?

메모리가 부족한 경우 메모리의 일부 내용을 디스크로 Swap 하는 것을 말합니다.

**Windows**의 가상 메모리와 같이 디스크 일부를 메모리처럼 사용하게 됩니다.

## 스왑 파일/파티션 존재 여부 화인

스왑 파일을 생성하기 전에 이미 스왑 파일이나 파티션이 있는지 먼저 확인합니다.

아래 두 명령어를 입력했을때 **Swap관련 내용**이 보이지 않으면 스왑이 설정되지 않은 것 입니다.

```sh
sudo free -m
sudo swapon -s
```

## 스왑 파일 생성

스왑 파일 및 파티션이 존재하지 않는 것을 확인한 뒤 아래 명령어로 스왑 용도로 사용할 파일을 생성합니다.

아래 명령어는 루트 디렉터리에 **4GB**의 파일을 생성한다는 뜻입니다.

```sh
sudo fallocate -l 4G /swapfile
```

아래와 같이 **4GB**의 `swapfile`이 생성된 것을 확인할 수 있습니다.

```sh
NY@RPI:~$ ls -al /
total 4194532
...
drwxr-xr-x   9 root root       4096 Jul  3 20:24 snap
drwxr-xr-x   2 root root       4096 Feb  1 20:02 srv
-rw-------   1 root root 4294967296 Jun  2 17:55 swapfile
dr-xr-xr-x  12 root root          0 Jan  1  1970 sys
...
```

## 스왑 활성화

이제 생성한 파일을 스왑으로 동작하도록 설정해 줘야 합니다.

생성된 파일의 권한을 수정합니다.

```sh
sudo chmod 600 /swapfile
```

해당 파일이 스왑으로 동작하도록 설정합니다.

```sh
sudo mkswap /swapfile
```

마지막으로 아래 명령어를 입력해서 스왑을 활성화 해줍니다.

```sh
sudo swapon /swapfile
```

라즈베리파이를 재부팅 해도 계속 사용하기 위해서 `/etc/fstab`를 수정해 줍시다.

```sh
sudo nano /etc/fstab
```

그리고 제일 하단에 아래와 같이 한 줄을 추가합니다.

```sh
/swapfile swap swap defaults 0 0
```

## 스왑 파일 삭제

스왑 파일은 삭제하려면, 아래 명령어로 먼저 스왑을 비활성화 합니다.

```sh
sudo swapoff -v /swapfile
```

스왑 파일을 생성할때 `/etc/fstab`에 추가한 내용을 삭제합니다.

```sh
sudo nano /etc/fstab
```

아래의 라인을 삭제해줍니다.

```sh
/swapfile swap swap defaults 0 0
```

마지막으로 생성했던 `swapfile`을 삭제해주면 됩니다.

```sh
sudo rm /swapfile
```
