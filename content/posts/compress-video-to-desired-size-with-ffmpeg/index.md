---
title: "FFmpeg를 사용해서 영상을 원하는 크기로 압축하기"
date: 2024-03-13T07:42:50+09:00
comments: true
categories: ["강좌"]
summary: ""
tags:
    - FFmpeg
    - Video
    - Compression
---

메일에 영상을 첨부하거나, SNS등에 업로드 하기 위해 영상을 제한된 크기로 압축해야 할 때가 있습니다.

FFmpeg를 사용해서 화질의 열화는 최소화하면서 영상의 크기를 목표 크기로 압축하는 방법을 알아보겠습니다.

## FFmpeg 설치하기

```bash
sudo apt install ffmpeg # Ubuntu / Debian
sudo pacman -S ffmpeg # Arch Linux
```

## 쉘 스크립트

아래 명령어는 `input.mp4`라는 파일을 25MB로 압축하는 쉘 스크립트입니다.

```bash
file="input.mp4"
target_size_mb=25 # 목표 크기 (25MB)
target_size=$(( $target_size_mb * 1000 * 1000 * 8 )) # 목표 크기 (25MB -> 25 * 1000 * 1000 * 8 bit)
length=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file"`
length_round_up=$(( ${length%.*} + 1 ))
total_bitrate=$(( $target_size / $length_round_up ))
audio_bitrate=$(( 128 * 1000 )) # 128kbps 오디오
video_bitrate=$(( $total_bitrate - $audio_bitrate ))
ffmpeg -i "$file" -b:v $video_bitrate -maxrate:v $video_bitrate -bufsize:v $(( $target_size / 20 )) -b:a $audio_bitrate "${file}-${target_size_mb}mb.mp4"
```

116MB였던 영상이 목표 크기인 25MB를 넘지 않게 압축된 것을 확인할 수 있습니다.

{{< img src="/posts/compress-video-to-desired-size-with-ffmpeg/images/filesize.png" title="압축 전/후" >}}

이를 좀 더 사용하기 쉽도록 함수로 만들어 봅시다.

```bash
ffmpeg_resize () {
    file=$1
    target_size_mb=$2 # 목표 크기 (MB)
    target_size=$(( $target_size_mb * 1000 * 1000 * 8 )) # 목표 크기 (MB -> MB * 1000 * 1000 * 8 bit)
    length=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file"`
    length_round_up=$(( ${length%.*} + 1 ))
    total_bitrate=$(( $target_size / $length_round_up ))
    audio_bitrate=$(( 128 * 1000 )) # 128kbps 오디오
    video_bitrate=$(( $total_bitrate - $audio_bitrate ))
    ffmpeg -i "$file" -b:v $video_bitrate -maxrate:v $video_bitrate -bufsize:v $(( $target_size / 20 )) -b:a $audio_bitrate "${file}-${target_size_mb}mb.mp4"
}
```

이제 `ffmpeg_resize input.mp4 25`처럼 사용하면 input.mp4를 25MB로 압축할 수 있습니다.
