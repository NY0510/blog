---
title: "나만의 '평생' 무료 서버 만들기"
summary: "오라클 클라우드 무료티어를 사용해 나만의 '평생' 무료 VPS를 만들어보자 [1]"
categories: ["강좌", "오라클 클라우드", "리눅스"]
date: 2022-01-31
comments: true
tags:
    - Ubuntu
    - Oracle Cloud
    - Cloud
    - Server
---

오라클에서는 평생 무료 이용 가능한 서버를 제공하고 있습니다.

**Google Cloud**의 평생 무료 서버와 비교해보면 아래와 같습니다.

**오라클 클라우드**가 CPU, RAM, Disk, Network Outbound 같은 측면에서 **구글 클라우드**보다 훨씬 우위에 있습니다.

VM 개수는 **오라클 클라우드**에선 2개까지 무료이고, **구글 클라우드**는 개수 제한은 없으나 VM의 사용시간 총합이 월 744시간 까지만 무료입니다. 이는 1개의 VM을 1달 동안 24시간 사용하는 시간과 동일합니다.

웹 서버로 운영하기 위해선 고정IP가 필요한데 **오라클 클라우드**는 무료로 고정IP를 할당할 수 있고, **구글 클라우드는** 사용 시간에 비례하여 유료로 제공합니다.

결과적으로 **오라클 클라우드** 성능적인 면과 사용성 모두 좋은 편입니다.

| 비교 대상       | 오라클 클라우드             | 구글 클라우드                       |
| --------------- | --------------------------- | ----------------------------------- |
| VM 종류         | E2.1.Micro                  | f1-micro                            |
| CPU             | **CPU 1/8**                 | vCPU 1                              |
| RAM             | **1GB**                     | 614MB                               |
| Disk            | **최대 100GB**              | 30GB 까지 무료                      |
| Network Out     | **10TB**                    | 1GB                                 |
| 사용 기간       | **평생**                    | 744시간/월                          |
| VM 지역         | **지역 제한 없음**          | us-west1, us-central1, us-east1     |
| 공인 IP         | **고정IP 무료**             | 고정 IP 유료                        |
| OS              | Linux 배포판 무료           | =                                   |
| 관련 문서       | 구글에 비해 빈약함          | **_풍부_**                          |
| 기술 지원       | **실시간 채팅 가능 (영어)** | 불가능                              |
| Cloud UI 사용성 | Web UI                      | **_Web UI (오라클에 비해 직관적)_** |

## Oracle Cloud 평생 무료 VPS 만들기

먼저, 이 글을 작정하는 시점인 **2022년 1월 기준** [Oracle Cloud 홈페이지](https://www.oracle.com/kr/cloud/free/)에 게시된 무료 조건은 아래와 같습니다.

~~AWS를 비교 대상으로 삼고 있네요~~

{{< img src="/posts/create-your-own-lifetime-free-server-using-oracle-cloud/images/oracle-cloud-main-img.png" title="오라클 클라우드 무료 조건" >}}

### Oracle Cloud 계정 생성

먼저 [여기](https://signup.cloud.oracle.com/)에서 계정을 만들어줘야 합니다.

게정 생성 시 본인인증을 위한 **신용카드 등록**이 필요하며, 유효성을 확인하기 위해 1원 결제 후 바로 취소가 됩니다.

유료 VM을 사용하지 않는 한 결제가 되는 일은 없습니다.

계정 생성시 선택하는 VM Region은 **한번 선택**하면 **변경할 수 없으니** 신중하게 선택해야 합니다.

> 저는 서울은 사용자가 너무 많을 거 같아 **대한민국/춘천**으로 선택했습니다.

### VM Instance 생성

회원가입을 완료한 뒤, [Oracle Cloud](https://cloud.oracle.com/)에 접속해 **VM 인스턴스 생성**을 클릭합니다.

{{< img src="/posts/create-your-own-lifetime-free-server-using-oracle-cloud/images/make-vm.jpg" title="오라클 클라우드 메인 페이지" >}}

다음과 같이 **VM 인스턴스를** 생성합니다.

1. VM 이름 입력
2. OS 선택 (Oracle Linux 기본, Ubuntu 선택 가능)
3. SSH 키 저장

{{< img src="/posts/create-your-own-lifetime-free-server-using-oracle-cloud/images/make-vm-2.jpg" title="VM Instance 생성" >}}

## 생성 확인 및 SSH 접속

VM 생성이 완료되었다면 [여기](https://cloud.oracle.com/compute/instances)에서 VM 정보를 확인할 수 있습니다.

{{< img src="/posts/create-your-own-lifetime-free-server-using-oracle-cloud/images/vm-info.png" title="VM 정보 확인" >}}

VM Instance를 생성할 때 다운받았던 **SSH 키**를 이용해 **인스턴스 엑세스 항목**에 있는 IP로 접속합니다.

```sh
ssh -i '다운받은 Private KEY' ubuntu@IP주소
```

아래와 같이 **1GB의 RAM**과 `/dev/sda1`에 마운트된 **50GB 스토리지**를 확인할 수 있습니다.

```sh
ubuntu@OracleVM:~$ free -h
              total        used        free      shared  buff/cache   available
Mem:          972Mi       141Mi        98Mi       1.0Mi       732Mi       698Mi
Swap:         4.0Gi       1.0Mi       4.0Gi

ubuntu@OracleVM:~$ df
Filesystem     1K-blocks    Used Available Use% Mounted on
udev              473868       0    473868   0% /dev
tmpfs              99548    1000     98548   2% /run
/dev/sda1       47156192 5928456  41211352  13% /
tmpfs             497736       0    497736   0% /dev/shm
tmpfs               5120       0      5120   0% /run/lock
tmpfs             497736       0    497736   0% /sys/fs/cgroup
/dev/loop0         56832   56832         0 100% /snap/core18/2253
/dev/loop1         59520   59520         0 100% /snap/oracle-cloud-agent/26
/dev/loop2         43264   43264         0 100% /snap/snapd/14066
/dev/sda15        106858    5321    101537   5% /boot/efi
/dev/loop3         56960   56960         0 100% /snap/core18/2284
/dev/loop4         44544   44544         0 100% /snap/snapd/14549
/dev/loop5         59904   59904         0 100% /snap/oracle-cloud-agent/30
tmpfs              99544       0     99544   0% /run/user/1001
```
