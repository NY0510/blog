---
title: "Fail2ban으로 SSH 보안 강화하기"
summary: "자동 IP 차단으로 SSH 보안을 강화하자 / 리눅스 서버 보안설정 [1]"
categories: ["강좌"]
date: 2021-10-24
comments: true
tags:
    - Raspberry PI
    - Fail2ban
    - SSH
---

만약 라즈베리파이를 서버로 쓰고, 외부와 연결되어 있다면 혹시나 모를 **Brute-force** 혹은 **무차별 대입 공격**으로 인한 피해 사고를 예방하기 위해

Fail2ban의 설치와 사용법을 알아봅시다.

## Fail2ban의 필요성

설치에 앞서 먼저 Fail2ban의 필요성을 알아봅시다.

만약 라즈베리파이가 외부 네트워크에 연결되어 있다면 아래 명령어를 한번 실행해 보세요.

```sh
journalctl -f
```

{{< img src="/posts/setting-up-fail2ban-on-raspberry-pi/images/journalctl -f.png" title="journalctl -f 실행 결과" >}}

저는 이미 **Fail2ban**과 **OTP** 설정이 완료되어 있어 로그인 시도는 보이지 않지만, 이러한 보안 설정이 되어있지 않을 경우에는

`Failed password for XXX from X.X.X.X port XXX` 이러한 식으로 **무차별 대입 공격 시도**가 수없이 들어오는 것을 확인할 수 있습니다.

**~~글로벌한 내 서버!~~**

Fail2ban이 이러한 SSH 로그인 시도를 필터를 통해 걸러주고, 자동으로 차단 해주는 역할을 합니다.

## 설치

아래 명령어로 fail2ban을 설치해 줍니다.

```sh
sudo apt-get install fail2ban
```

설치가 완료되면 자동으로 서비스를 시작하지만 `sudo service fail2ban status` 명령어를 통해 실행 중인지 확인할 수 있습니다.

## 설정

아래 명령어를 통해 새로운 파일을 생성합니다

```sh
sudo nano /etc/fail2ban/jail.local
```

아래 내용을 보고 원하는 데로 수정한 후 저장합니다.

만약 SSH에서 22번이 아닌 다른 포트로 변경하였다면 마지막 부분에 port도 변경해 줘야 합니다.

```ini
[DEFAULT]
# findtime동안 maxretry의 로그인 시도가 있는 IP를 bantime만큼 차단
findtime = 1d

# 로그인 시도 허용 횟수
maxretry = 5

# 차단 기간 (-1은 영구차단)
bantime = 1w

backend = systemd

# 이메일 알림 설정
destemail =
sendername =
mta = sendmail

# IP 화이트리스트 (이 IP 대역은 절대 차단당하지 않음)
ignoreip = 127.0.0.1/8 192.168.0.0/24

[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/fail2ban-ssh.log
```

라즈베리파이를 재부팅 하거나, `sudo service fail2ban restart` 명령어를 통해 변경 사항을 적용해 줍니다.

## 사용법

이 포스트에서는 간단한 사용법만 소개하니, 더 자세한 사용법을 알고 싶으신 분들은 [여기](https://www.fail2ban.org/wiki/index.php/Main_Page)를 참고해 주시길 바랍니다.

### 차단된 IP 목록 보기

아래 명령어를 통해 sshd 필터에 차단된 IP들을 확인할 수 있습니다.

```sh
sudo fail2ban-client status sshd
```

### IP 차단 해제

아래 명령어로 차단된 IP를 수동으로 차단 해제할 수 있습니다.

```sh
sudo fail2ban-client set sshd unbanip <IP>
```

### IP 차단

아래 명령어를 통해 수동으로 IP를 차단할 수 있습니다.

```sh
sudo fail2ban-client set sshd banip <IP>
```

> 이렇게 SSH 보안을 강화하는 fail2ban을 설치해 보았습니다.
>
> 이제 공격에 완벽히 안전한 것은 아니지만 전세계에서 들어오는 브루투포스 공격을 어느 정도 막아낼 수 있게 되었습니다.
