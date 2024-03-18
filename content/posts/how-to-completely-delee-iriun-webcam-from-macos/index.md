---
title: "MacOS에서 Iriun Webcam 완전히 삭제하기"
date: 2024-03-18T09:36:45+09:00
comments: true
categories: ["강좌"]
summary: "MacOS에서 시스템 확장을 수동으로 삭제하는 법"
tags:
    - MacOS
    - Iriun Webcam
    - System Extension
draft: false
---

Iriun Webcam은 모바일 기기를 웹캠으로 사용할 수 있게 해주는 프로그램 입니다.
이 프로그램은 MacOS에서 시스템 확장을 설치하게 되는데, 삭제하더라도 완전히 삭제되지 않는 경우가 있습니다.

앱을 삭제했음에도 불구하고, 여전히 카메라 목록에 Iriun Webcam이 표시됩니다.

{{< img src="/posts/how-to-completely-delee-iriun-webcam-from-macos/images/iriun-webcam.png" >}}

이런 경우에는 시스템 확장을 수동으로 삭제해야 합니다.

## 시스템 확장 삭제하기

현재 설치된 시스템 확장 목록을 확인합니다.

```fish
systemextensionsctl list
```

{{< img src="/posts/how-to-completely-delee-iriun-webcam-from-macos/images/systemextensionsctl-list.png" title="시스템 확장 목록" >}}

bundleID가 `com.iriun.macwebcam.extension`인 확장을 삭제하면 됩니다.

`systemextensionsctl uninstall <TEAM ID> <bundleID>` 명령어를 사용하여 시스템 확장을 삭제합니다.

```fish
systemextensionsctl uninstall R84MX49LQY com.iriun.macwebcam.extension
```

만약 아래와 같은 에러와 함께 삭제가 되지 않는다면, SIP를 비활성화 해야 합니다.

```text
At this time, this tool cannot be used if System Integrity Protection is enabled.
This limitation will be removed in the near future.
Please remember to re-enable System Integrity Protection!
```

## SIP 비활성화하기

SIP를 비활성화 하려면 복구 모드에서 `csrutil disable` 명령어를 실행해야 합니다.

Apple Slicon Mac 기준으로 복구 모드로 진입하는 방법은 다음과 같습니다.

Intel Mac은 [이 링크](https://support.apple.com/ko-kr/guide/mac-help/mchl338cf9a8/mac)를 참고하세요.

1. Mac을 종료합니다.
2. 복구 메뉴 로딩 메세지가 나타날 때까지 전원 버튼을 누르고 있습니다.
3. 옵션을 눌러 계속을 클릭합니다.
4. 상단 메뉴에서 유틸리티 > 터미널을 클릭합니다.

SIP를 비활성화 합니다.

```fish
csrutil disable
```

이제 Mac을 재부팅하고, 시스템 확장을 삭제합니다.

## SIP 활성화하기

보안을 위해서 SIP를 다시 활성화 해주는 것이 좋습니다.

터미널에서 다음 명령어를 실행합니다.

````fish
sudo csrutil clear
```
````

그 다음 Mac을 재부팅합니다.
