---
title: "Altstore을 사용해서 IPA 파일 설치하기 (탈옥 X)"
date: 2023-07-16T17:30:16+09:00
categories: ["강좌"]
tags:
    - IPA
    - Altstore
---

Altstore는 **탈옥 없이** 사용자의 애플ID를 이용해서 iOS앱(ipa 파일)을 사이드 로딩 해주는 앱이다.

앱스토어에 등록되지 않은 앱을 설치하려면 탈옥할 수도 있지만, 이러한 Altstore을 사용하면 탈옥 없이 앱스토어에 등록되지 않은 비공식 앱들을 설치할 수 있습니다.

탈옥하지 않음으로 여러 부분에서 안전하고 편리한 방법입니다.

**준비물**

-   Windows 또는 macOS 컴퓨터
-   iPhone
-   Lightning 케이블

## 윈도우

만약 macOS 사용자라면 [여기](#macos)를 눌러 이동해 주세요.

### 1. iTunes 설치

최신 버전의 iTunes와 iCloud를 설치해 주어야 합니다.

만약 Microsoft Store에서 설치한 iTunes와 iCloud가 있다면 삭제 후 다시 설치해 주세요.

> iTunes 설치 파일 다운로드 링크
>
> 64비트: https://www.apple.com/itunes/download/win64
>
> 32비트: https://www.apple.com/itunes/download/win32

> iCloude 설치 파일 다운로드 링크
>
> 64비트 / 32비트: https://updates.cdn-apple.com/2020/windows/001-39935-20200911-1A70AA56-F448-11EA-8CC0-99D41950005E/iCloudSetup.exe

### 2. Altstore 다운로드

[Altstore 웹사이트](https://altstore.io/)에 접속해서 운영체제에 맞게 설치 파일을 다운로드 해주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/altstore-download.png" title="Altstore 다운로드" >}}

다운로드 한 `AltInstaller.zip` 파일을 압축 해제한 뒤 `Setup.exe`를 실행해서 설치해주세요.

설치가 모두 끝났다면, 윈도우 검색창에 `AltServer`를 검색한 뒤 **관리자 권한으로 실행**을 눌러주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/altstore-run.png" title="Altstore 실행" >}}

### 3. iPhone 연결

iPhone과 컴퓨터를 케이블을 사용해서 연결하고 잠금 해제해 주세요.

iTunes를 실행하고 하단의 Wi-Fi를 통해 이 기기 동기화를 체크해 줍니다.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/itunes-wifisync.png" title="iTunes 실행" >}}

### 4. iPhone에 Altstore 설치

작업표시줄의 Altstore 아이콘을 우클릭한 뒤 설치할 기기를 선택해주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/install-altstore-on-iphone.png" title="iPhone에 Altstore 설치" >}}

사용하고 있는 애플ID로 로그인 해주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/install-altstore-on-iphone-2.png" title="iPhone에 Altstore 설치" >}}

이제 잠시 기다리면 Altstore가 설치됩니다.

### 5. iPhone 설정

Altstore가 설치되었다면 설정 - 일반 - 프로파일 및 기기 관리 메뉴에 들어간 뒤 신뢰를 눌러주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/iphone-setting.png" title="iPhone 설정" >}}

만약 iOS 16 이상을 사용중이라면 설정 - 개인정보 보호 및 보안 - 개발자 모드를 활성화해 준 뒤 아이폰을 재부팅 해주세요.

이제 Altstore 설치가 끝났습니다.

다음 글에서는 이번에 설치한 Altstore을 활용해서 유튜브 광고 제거 등 유용한 앱들을 설치하는 방법에 대해 다뤄보도록 하겠습니다.

## macOS

### 1. Altstore 다운로드

[Altstore 웹사이트](https://altstore.io/)에 접속해서 운영체제에 맞게 설치 파일을 다운로드 해주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/altstore-download.png" title="Altstore 다운로드" >}}

다운로드 한 `altserver.zip` 파일을 압축 해제한 뒤 `AltServer.app`을 애플리케이션 폴더로 이동해 주세요.

설치된 AltServer을 실행하면 상단바에 아이콘이 나오는 것을 확인할 수 있습니다.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/altstore-run-mac.png" title="Altstore 실행" >}}

### 2. iPhone 연결

iPhone과 컴퓨터를 케이블을 사용해서 연결하고 잠금 해제해 주세요.

파인더를 실행한 뒤 좌측 메뉴에서 아이폰을 클릭하고 하단의 Wi-Fi를 통해 이 기기 동기화를 체크해 줍니다.

### 3. 메일 플러그인 설치

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/altstore-run-mac.png" title="Altstore 실행" >}}

상단바의 AltServer 아이콘을 클릭한 뒤 Install Mail Plug-in을 클릭합니다.

설치 버튼을 누른 다음 macOS 비밀번호를 입력해 주세요.

메일 앱을 실행해주세요. 만약 이미 실행 중이라면 종료한 뒤 다시 실행합니다.

`command(⌘) + ,`를 눌러 설정을 열은 다음 하단에 플러그인 관리를 클릭해 주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/mail-1.png" title="메일 플러그인 설정" >}}

`AltPlugin.mailbundle`을 활성화해 주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/mail-2.png" title="메일 플러그인 활성화" >}}

팝업이 나오면 매일 앱을 재시작 해주세요.

### 4. iPhone에 Altstore 설치

상단 메뉴의 Altstore 아이콘을 우클릭한 뒤 설치할 기기를 선택해 주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/install-altstore-on-iphone-mac-2.png" title="iPhone에 Altstore 설치" >}}

사용하고 있는 애플ID로 로그인 해주세요.

{{< img src="/posts/install-ipa-on-iphone-without-jailbreaking/images/install-altstore-on-iphone-mac.png" title="iPhone에 Altstore 설치" >}}

이제 잠시 기다리면 Altstore가 설치됩니다.

### 5. iPhone 설정

이 단계는 [여기](#5-iphone-설정) 방법을 따라해 주세요.

이제 Altstore 설치가 끝났습니다.

다음 글에서는 이번에 설치한 Altstore을 활용해서 유튜브 광고 제거 등 유용한 앱들을 설치하는 방법에 대해 다뤄보도록 하겠습니다.
