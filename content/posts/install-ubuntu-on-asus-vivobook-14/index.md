---
title: "Asus 비보북 14 우분투 설치기"
summary: "설치 후 내 노트북에서만 발생하는 문제 해결"
categories: ["문제 해결", "리눅스"]
date: 2021-12-04
tags:
    - Ubuntu
    - Laptop
---

시작하기에 앞서, 이 글은 **우분투 설치법에 대한 글이 아닙니다.**

단지 제 노트북인 **Asus 비보북14** 에서 발생하는 문제 해별법을 설명해둔 글입니다.

**이 글은 계속 업데이트될 예정입니다.**

## No Wifi Adapter Found 문제

노트북(Asus 비보북 14)에 우분투를 설치하고 보니, 아래와 같이 **No Wifi Adapter Found** 라는 메세지와 함께 와이파이 어댑터를 찾지 못하고 있었습니다.

{{< img src="/posts/install-ubuntu-on-asus-vivobook-14/images/ubuntu-no-wifi.png" title="No Wifi Adapter Found" >}}

이 문제를 해결하기 위해 몇 주 동안 삽질을 해보았지만 결국 해결하지 못해서 할 수 없이 다이소에서 산 5,000원짜리 USB형 WiFi 동글을 사용해 인터넷을 사용하던 중이었습니다.

~~오늘도 어김없이~~ 와이파이 문제에 대해 구글링을 하고 있던 와중에 **윈도우에서 빠른 시작을 비활성화**하면 해결된다는 한 게시물을 발견했습니다.

혹시 몰라 한번 시도해 봤더니 문제가 바로 해결되었습니다.

이 문제는 어이없을 정도로 간단하게 해결할 수 있습니다.

윈도우와 우분투를 듀얼부팅으로 사용 중인 겅우, 윈도우 설정에서 빠른 시작 옵션을 비활성화해주면 됩니다.

**제어판 > 전원 옵션 > 전원 단추 작동 설정** 순으로 들어간 다음에

현재 사용할 수 없는 설정 변경을 클릭하고, 종료 설정에 빠른 시작 켜기 체크를 해제합니다.

{{< img src="/posts/install-ubuntu-on-asus-vivobook-14/images/windows-setting.png" title="윈도우 빠른시작 비활성화" >}}

이제 다시 우분투로 부팅하면 와이파이가 작동합니다.

## 충전기 연결 시 밝기 초기화 문제

충전기를 연결 / 해제시 노트북의 **밝기가 0으로 초기화**되는 문제가 있습니다.

아래 명령어를 실행해서 관련 서비스를 종료시키면 해결됩니다.

```sh
sudo systemctl stop systemd-backlight@backlight:acpi_video1.service
sudo systemctl disable systemd-backlight@backlight:acpi_video1.service
```

재부팅 시 종료시킨 서비스가 다시 살아남으로 시작 프로그램에 등록해 둡시다.

## 배터리 충전 제한

이건 문제 해결법은 아니지만, 인터넷에 제대로된 방법이 나와있지 않아 추가합니다.

배터리 수명을 늘리기 위해 80% 충전 제한을 설정하는 기능입니다.

```sh
sudo crontab -e
```

Crontab에 다음 명령어를 추가합니다.

```sh
@reboot echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold
```

## 키보드 FN키 동작 문제

일부 키보드에서 FN(F1 ~ F12) 키가 화면 밝기 조절 등 단축키로만 작동해서 FN 키를 사용할 수 없는 문제가 있습니다.

간단하게 아래 명령어 실행으로 해결됩니다.

```sh
echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo "options hid_apple fnmode=0" | sudo tee -a /etc/modprobe.d/hid_apple.conf
```
