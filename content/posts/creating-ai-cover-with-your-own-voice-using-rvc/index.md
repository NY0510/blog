---
title: "RVC를 사용해서 내 목소리로 AI 커버 만들기"
date: 2024-02-03T22:56:17+09:00
comments: true
categories: ["강좌"]
draft: true
summary: "RVC(Retrieval-based Voice Conversion)를 사용하여 내 목소리로 AI 커버를 만들어보자."
tags:
    - AI
    - RVC
---

## RVC란

RVC(Retrieval-based Voice Conversion)는 AI를 사용한 음성 합성 기술입니다.

기존에 사용되던 Diff-SVC와 비슷하지만 음파 이미지를 생성해내는 방식이 아닌 기존의 음성 데이터를 이용한 일종의 음성 변조와 비슷한 기술을 사용합니다.

그래서 비교적 짧은 데이터로도 모델을 학습시킬 수 있다는 장점이 있습니다.

## 목소리 녹음하기

[Mimic-Recording-Studio](https://github.com/MycroftAI/mimic-recording-studio)를 사용해서 한국어 예문을 녹음하는 방법도 있지만, 이 글에서는 노래를 녹음하여 학습을 시켜보겠습니다.

먼저 녹음 및 오디오 편집을 위해 [Audacity](https://www.audacityteam.org/)를 설치합니다.

설치 후 녹음할 노래의 MR파일을 **드래그 앤 드롭** 또는 **파일 > 가져오기 > 오디오** 메뉴를 통해 불러옵니다.

{{< img src="/posts/creating-ai-cover-with-your-own-voice-using-rvc/images/audacity_main.png" title="Audacity 메인 화면" >}}

그런 다음 좌측 상단의 녹음 버튼을 누르면 녹음이 시작됩니다.

> 처음 파일을 불러오고 나면 해당 트랙이 선택되어 있는 상태입니다.
>
> 이 상태로 녹음을 시작하면 트랙의 맨 뒤에 녹음된 음성이 추가됩니다.
>
> 트랙 하단의 빈 공간을 클릭하여 선택을 해제한 후 녹음 버튼을 클릭하면 새로운 트랙에 녹음이 시작됩니다.

> 녹음을 할 때는 최대한 조용한 환경에서 녹음하는 것이 좋습니다.

{{< img src="/posts/creating-ai-cover-with-your-own-voice-using-rvc/images/audacity_recording.png" title="녹음 중인 Audacity 화면" >}}

녹음을 완료한 뒤 음성만 녹음된 두번째 트랙을 선택하고 **파일 > 오디오 내보내기**를 클릭합니다.

{{< img src="/posts/creating-ai-cover-with-your-own-voice-using-rvc/images/audacity_export.png" title="오디오 내보내기 화면" >}}

**모노 채널 44.1kHz 16비트 WAV** 형식으로 저장합니다.

## RVC 모델 학습하기

모델을 학습하기 위해서는 대용량의 VRAM과 고사양의 GPU가 필요합니다.

이 글에서는 대신 [Google Colab](https://colab.research.google.com/)을 사용하여 학습을 진행하겠습니다.
