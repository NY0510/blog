---
title: "Apple Game Porting Toolkit을 사용해서 M1 맥북에 원신 설치하기"
summary: "윈도우용 원신을 맥북에서 돌려보자"
date: 2023-06-13T10:46:25+09:00
categories: ["강좌", "macOS"]
comments: true
tags:
    - Apple Game Porting Toolkit
    - macOS Sonoma
---

지난 6월 5일에 개최된 애플의 [WWDC 2023](https://youtu.be/GYkq9Rgoj8E)에서 `Apple Game Porting Toolkit`이 공개되었다.

Valve에서 개발한 Proton과 비슷한 역할을 하는 번역 프레임워크이다.

Wine과 애플 자체의 D3DMetal을 결합하여 윈도우의 DirectX 11 / 12를 Metal로 번역해 실리콘 맥에서 실행되도록 번역해줍니다.

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/gamming-mac-meme.png" title="게이밍 맥" >}}

> ~~맥 사용자들의 오랜 숙원이었던 게임 부분에 대한 지원이 드디어 이루어졌네요~~
>
> 비전 프로의 게임 지원을 위해서 개발한게 아닐까 하는 생각이..

## 요구사항

macOS Ventura 이상이면 지원이 되긴 하지만, 스팀 로그인과 관련해서 문제가 있어 macOS Sonoma를 사용하는 것을 추천드립니다.

만약 스팀을 사용하지 않을 것 이라면 macOS Ventura 또한 괜찮습니다.

### Command Line Tools for Xcode 15 beta

[Apple Developer Downloads 웹 페이지](https://developer.apple.com/downloads)에서 **Command Line Tools for Xcode 15 beta**를 다운로드 한 후 설치합니다.

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/command-line-tools-for-xcode-15-beta-download.png" title="Command Line Tools for Xcode 15 beta 다운로드" >}}

만약 Xcode 14와 같이 이전 버전의 Xcode가 설치되어 있다면 제거해야 합니다.

### Game Porting Toolkit beta

**Game Porting Toolkit beta**를 다운로드 한 후 `.dmg` 파일을 연 다음 `.pkg` 파일을 실행합니다.

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/game-porting-toolkit-beta-downlnoad.png" title="Game Porting Toolkit beta 다운로드" >}}

### Homebrew

#### Rosetta 2 설치

아래 명령어를 실행해 Rosetta 2를 설치해줍니다.

```bash
softwareupdate --install-rosetta
```

#### x86_64 쉘 진입

앞으로 실행하는 모든 터미널 명령어들은 x86_64 쉘에서 실행되어야 합니다.

아래 명령어로 x86_64 쉘에 진입합니다.

```bash
arch -x86_64 zsh
```

#### x86_64 버전의 Homebrew 설치

기존에 이미 ARM64 버전의 Homebrew가 설치되어 있더라도 x86_64 버전의 Homebrew를 설치해주어야 합니다.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Path 설정

Homebrew를 Path에 등록해줍시다.

`nano ~/.zshrc` 명령어로 `.zshrc` 파일을 열은 뒤 아래 내용을 가장 마지막에 추가해줍니다.

```bash
if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi
```

## Game Porting Toolkit 설치하기

> _다시 한번 말하지만, 아래 명령어들은 `arch -x86_64 zsh`명령어를 사용하여 진입한 x86_64 쉘에서 실행되어야 합니다._

### Apple Tab 설치

```bash
brew tap apple/apple http://github.com/apple/homebrew-apple
```

### Game Porting Toolkit 설치

아래 명령어는 직접 소스를 다운로드 한 뒤 컴파일하므로 사용하는 기기에 따라 최대 1시간 이상까지 걸릴 수 있습니다.

(MBA M1 16GB 기준 약 50분 소요)

```bash
brew -v install apple/apple/game-porting-toolkit
```

만약 설치 중 `Error: game-porting-toolkit: unknown or unsupported macOS version: :dunno”`와 같은 오류가 발생한다면,
현재 HomeBrew 버전이 macOS Sonoma를 지원하지 않는 것입니다.

아래 명령어로 HomeBrew를 업데이트한 뒤 다시 실행해줍시다.

```bash
brew update brew -v install apple/apple/game-porting-toolkit
```

[여기서](#command-line-tools-for-xcode-15-beta) 다운로드 한 Game Porting Toolkit dmg 파일이 마운트 되어있는지 확인한 뒤

아래 명령어를 실행합니다.

```bash
ditto /Volumes/Game\ Porting\ Toolkit-1.0/lib/ `brew --prefix game-porting-toolkit`/lib/
```

그런 다음 dmg 파일을 언마운트 하더라도 사용이 가능하게 아래 명령어로 dmg 파일 안 스크립트들을 `/usr/local/bin/` 폴더로 복사해줍니다.

```bash
cp /Volumes/Game\ Porting\ Toolkit*/gameportingtoolkit* /usr/local/bin
```

### Wine Prefix 설정

Wine의 가상 C 드라이브로 사용할 경로로 아래 명령어의 경로를 수정한 뒤 실행해서 Wine 설정을 열어줍니다.

```bash
WINEPREFIX=~/Wine `brew --prefix game-porting-toolkit`/bin/wine64 winecfg
```

하단의 윈도우 버전을 윈도우 10으로 설정한 뒤 OK를 눌러 저장합니다.

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/winecfg.png" title="Wine 설정창" width=300px >}}

## 원신 설치

이제 드디어 원신을 설치해 봅시다!

먼저 [윈도우용 원신 설치파일](https://sg-public-api.hoyoverse.com/event/download_porter/link/ys_global/genshinimpactpc/default)을 다운받아 줍니다.

아래 명령어로 다운로드한 파일을 실행합니다.

실행하기 전 Wine 경로를 앞서 설치한 경로로 바꿔주세요.

```bash
gameportingtoolkit ~/Wine 경로 ~/Downloads/GenshinImpact_install_*.exe
```

설치가 끝난 뒤 아래 명령어로 실행할 수 있습니다.

```bash
gameportingtoolkit ~/Wine 경로 'C:\Program Files\Genshin Impact\Genshin Impact game\GenshinImpact.exe'
```

만약 우측 상단에 표시되는 FPS 및 기타 모니터링 오버레이를 사용하지 않으려면 명령어의 `gameportingtoolkit`을 `gameportingtoolkit-no-hud`으로 변경해주세요.

### 바로가기 만들기

매번 명령어로 실행하는 건 귀찮기 때문에 런치패드에 바로가기를 추가해줍시다.

오토메이터(Automator) 앱을 실행한 뒤 응용 프로그램(Application)을 선택합니다.

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/automator-1.png" title="Automator 실행 및 새로운 응용 프로그램 생성" width=300px >}}

좌측 상단 검색창에 셸 스크립트 실행(Run Shell Script)를 검색한 뒤 오른쪽 공간으로 드래그해준 뒤 아래 내용을 붙여넣기 합니다.

```bash
#!/bin/zsh

export PATH="/usr/local/bin:${PATH}"
arch -x86_64 gameportingtoolkit ~/Wine 경로 'C:\Program Files\Genshin Impact\Genshin Impact game\GenshinImpact.exe'
```

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/automator-2.png" title="쉘 스크립트 실행 추가" width=300px >}}

마지막으로 `Command + S`를 눌러 응용 프로그램(Application) 폴더에 저장해줍니다.

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/automator-3.png" title="응용 프로그램 폴더에 저장" width=300px >}}

런치패드를 열어보면 잘 추가된 것을 볼 수 있습니다.

{{< img src="/posts/installing-genshin-impact-on-the-m1-macbook-using-thea-apple-game-porting-toolkit/images/automator-4.png" title="저장된 파일" width=300px >}}

## 문제 해결

### 앱이 갑자기 중지된 뒤 실행되지 않음

모든 와인 스레드를 종료한 뒤 다시 시도해보세요.

```bash
killall -9 wineserver && killall -9 wine64-preloader
```

### 계단현상이 일어남

게임 화면에 계단현상이 일어나거나 해상도가 낮게 제한된 경우에는 Retina(고해상도) 모드를 활성화해보세요.

활성화

```bash
WINEPREFIX=~/Wine 경로 `brew --prefix game-porting-toolkit`/bin/wine64 reg add 'HKEY_CURRENT_USER\Software\Wine\Mac Driver' /v RetinaMode /t REG_SZ /d 'Y' /f
```

비활성화

```bash
WINEPREFIX=~~/Wine 경로 `brew --prefix game-porting-toolkit`/bin/wine64 reg add 'HKEY_CURRENT_USER\Software\Wine\Mac Driver' /v RetinaMode /t REG_SZ /d 'N' /f
```
