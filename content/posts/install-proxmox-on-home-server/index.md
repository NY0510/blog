---
title: "가상화 OS Proxmox 설치하기"
date: 2023-04-19T16:12:05+09:00
summary: "24시간 돌아가는 나만의 서버! [2]"
categories: ["강좌", "홈서버", "리눅스", "홈서버 구축"]
comments: true
tags:
    - Proxmox
    - Home Server
cover:
    image: "/images/cover.jpg"
    relative: true
---

[지난번 포스트](https://blog.ny64.kr/posts/building-my-own-home-server/)에서 조립하였던 홈서버에 하이퍼바이저 OS인 Proxmox를 설치하여 보겠습니다.

## 그래서 Proxmox가 뭔데

Proxmox는 KVM 가상화와 LXC 컨테이너 기술을 기반으로 하는 하이퍼바이저 OS입니다.

가상 머신과 컨테이너를 웹 기반의 UI로 쉽게 관리할 수 있습니다.

또한 백업/복원, 스토리지 관리 등 다양한 기능을 제공하며, 가장 큰 장점인 오픈소스 라이선스로 누구나 무료로 사용할 수 있습니다.

## Proxmox 설치

이제 Proxmox를 서버에 설치해봅시다.

Proxmox VE 7.0 기준 최소 시스템 요구 사항은 아래와 같습니다.

-   64비트 프로세서
-   2Ghz 이상의 프로세서
-   4GB 이상의 램
-   32GB 이상의 디스크

### 이미지 굽기

먼저 [Proxmox 다운로드 페이지](https://www.proxmox.com/en/downloads)에 접속하여 ISO 파일을 다운받아 줍니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-iso-download.png" title="Proxmox ISO 다운로드" >}}

그다음 이미지 버닝 툴([Rufus](https://rufus.ie), [balenEetcher](https://www.balena.io/etcher) 등등..)을 사용해서 다운받은 ISO 파일을 USB에 구워줍니다.

### OS 설치

USB를 설치할 PC에 연결하고 부팅 순서를 변경하여 USB로 부팅해줍니다.

첫 번째 메뉴인 `Install Proxmox VE`를 선택합니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-install-1.png" title="부팅 첫 화면" >}}

Proxmox 이용약관에 동의해줍니다.

오른쪽 아래 `I agree`를 클릭해주세요.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-install-2.png" title="EULA 동의 화면" >}}

설치할 디스크 또는 파티션을 선택해줍니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-install-3.png" title="설치 디스크 선택 화면" >}}

사용할 타임존과 키보드 레이이웃을 선택해줍니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-install-4.png" title="타임좀 및 키보드 레이아웃 선택 화면" >}}

root 계정의 비밀번호를 입력합니다.

되도록 강력한 비밀번호를 사용해주세요.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-install-5.png" title="root 게정 비밀번호 입력 화면" >}}

최종 설정값을 한 번 더 확인한 뒤 `Install`을 눌러주세요.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-install-6.png" title="최종 설정값 확인 화면" >}}

설치를 하고 나면 아래와 같이 웹 콘솔에 로그인하라고 나옵니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-install-7.png" title="설치 완료 화면" >}}

## Proxmox 설정

`https://192.168.0.100`으로 접속해줍시다.

이 주소는 절대적인 값이 아니라 설정에 따라 바뀔 수 있으니, 설치 완료 후 나온 주소로 접속해주세요.

앞서 위에서 설정해주었던 계정으로 로그인해 줍니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-ve-1.png" title="Proxmox VE 로그인" >}}

### apt update 오류 해결

기본적으로 Proxmox는 오픈소스 이지만, 엔터프라이즈 라이선스의 경우에는 유료구독으로 지원을 받을 수 있습니다.

따라서 `apt update`를 실행했을 때 아래와 같이 오류 메세지가 나오게 됩니다.

```bash
E: Failed to fetch https://enterprise.proxmox.com/debian/pve/dists/bullseye/InRelease  401  Unauthorized [IP: 51.79.159.216 443]E: The repository 'https://enterprise.proxmox.com/debian/pve bullseye InRelease' is not signed.N: Updating from such a repository can't be done securely, and is therefore disabled by default.N: See apt-secure(8) manpage for repository creation and user configuration details.
```

하지만 우리는 유료 구독을 하지 않을 것임으로 엔터프라이즈 라이선스의 APT 레포지토리를 제거해 줘야 합니다.

웹 콘솔의 좌측 메뉴에서 데이터센터(Datacenter) -> 서버 호스트네임 -> 쉘(Shell) 메뉴로 들어갑니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-ve-2.png" title="웹 콘솔에서 쉘 접속" >}}

그다음 nano 편집기를 사용해 파일을 수정해줍니다.

```bash
nano /etc/apt/sources.list.d/pve-enterprise.list
```

아레와 같이 첫 번째 줄을 주석 처리 합니다.

```bash
#deb https://enterprise.proxmox.com/debian/pve bullseye pve-enterprise
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription
```

파일을 저장한 다음 다시 `apt update`를 실행하면 오류가 사라진 것을 볼 수 있습니다.

### 로그인 시 뜨는 팝업 제거

라이센스 구독을 하지 않으면 구독을 하라는 팝업이 로그인 할때마다 나오게 됩니다.

하지만 우리는 개인적으로 쓸 것이기 때문에 파일을 직접 수정해서 해당 팝업을 없애줍시다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-ve-3.png" title="라이센스 구독 팝업" >}}

직접 Proxmox의 파일을 수정하는 방법도 있겠지만 사용하기 쉽게 만들어진 쉘 스크립트를 사용하겠습니다.

아래 명령어를 실행하면 팝업이 제거됩니다.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/rickycodes/pve-no-subscription/main/no-subscription-warning.sh | sh
```

그런 다음 Proxmox 웹서비스를 재 시작해 줍니다.

```bash
systemctl restart pveproxy.service
```

### 마지막으로

업데이트!

```bash
apt update && apt dist-upgrade -y​
```

이제 Proxmox 설치와 기본 설정이 끝났습니다.

다음 글부터는 윈도우 / 리눅스 VM 생성과 RX 580을 이용한 GPU 패스쓰루에 대한 내용도 다뤄보려고 합니다.

{{< img src="/posts/install-proxmox-on-home-server/images/proxmox-ve-4.png" title="Proxmox VE 설치 완료" >}}
