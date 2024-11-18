---
title: 'MacOS에서 캡스락 한영 전환 딜레이 및 씹힘 현상 해결하기'
date: 2024-11-18T09:31:05+09:00
comments: true
categories: ['강좌']
summary: ''
tags:
    - MacOS
---

macOS의 캡스락 한영 전환에 딜레이나 씹힘 현상이 발생하는 것은 오래 전부터 알려진 문제이지만,

macOS 14.0 소노마 업데이트 이후 새로운 입력 도구로 인해 매우 빠르게 입력하는 경우 일부 문자가 입력되지 않는 현상 또한 발생하고 있습니다.

구름입력기와 같은 외부 입력기를 사용하지 않는 한 100% 해결하지는 못하지만 개선할 수 있는 방법이 있습니다.

## 14.0 소노마 업데이트 이후 추가된 입력 도구 비활성화하기

![새로운 입력 도구](./images/new-input.png)

```bash
sudo mkdir -p /Library/Preferences/FeatureFlags/Domain
sudo /usr/libexec/PlistBuddy -c "Add 'redesigned_text_cursor:Enabled' bool false" /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

터미널에서 위 명령어를 실행한 후 재부팅을 하면 소노마 이전 입력 도구로 변경됩니다.

```bash
sudo rm -rf /Library/Preferences/FeatureFlags/Domain/UIKit.plist
```

만약 다시 소노마 입력 도구로 변경하고 싶다면 위 명령어를 실행하면 됩니다.

## 캡스락 딜레이 제거하기

```bash
sudo hidutil property --set '{"CapsLockDelayOverride":0}'
```

위 명령어를 실행하면 캡스락 딜레이가 제거됩니다.
