---
title: "우분투에서 디스코드 화면공유 문제 해결하기"
summary: "디스코드에서 전체화면 공유시 검은화면이 나오는 문제 해결하기"
categories: ["삽질"]
date: 2022-01-21
comments: true
tags:
    - Ubuntu
    - Discord
---

일부 환경에서 우분투에서 디스코드 화면공유를 하려고 하면 검은 화면만 나오는 문제가 있습니다.

**우분투 21.04** 이상의 **Wayland에서** 일부 프로그램들에 한해서 화면공유가 불가능한 문제입니다.

디스코드 측에서 업데이트를 해주기 전까진 아래 방법을 통해 **Wayland를** 비활성화해 해결할 수 있습니다.

## 문제 해결

GDM3 설정파일을 연 다음, `#WaylandEnable=false`의 주석을 제거하고 저장합니다.

```sh
sudo nano /etc/gdm3/custom.conf
```

```conf
# GDM configuration storage
#
# See /usr/share/gdm/gdm.schemas for a list of available options.

[daemon]
# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=false # Wayland 비활성화

# Enabling automatic login
#  AutomaticLoginEnable = true
#  AutomaticLogin = user1

# Enabling timed login
#  TimedLoginEnable = true
#  TimedLogin = user1
#  TimedLoginDelay = 10
...
```

설정파일 변경한것을 반영해줍니다.

```sh
sudo dpkg-reconfigure gdm3
```

이제 재부팅을 하거나 로그아웃 후 다시 로그인하면 문제가 해결됩니다.
