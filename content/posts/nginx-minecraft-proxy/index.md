---
title: "Nginx로 마인크래프트 프록시 서버 만들기"
date: 2024-07-12T13:57:38+09:00
comments: true
categories: ["강좌"]
summary: "Nginx TCP/UDP 포워딩"
tags:
    - Nginx
    - Minecraft
---

Nginx를 사용하여 마인크래프트 자바 에디션(TCP) 및 베드락 에디션(UDP) 서버를 프록시하는 방법을 알아보겠습니다.

`/etc/nginx/nginx.conf` 파일을 열어 아래 내용을 추가합니다.

자바 에디션은 기본적으로 TCP/25565, 베드락 에디션은 UDP/19132를 사용합니다.

### 자바 에디션 서버인 경우

```nginx
events {
    worker_connections 1024;
}

stream {
    upstream minecraft_java {
        server 실제 서버 주소:25565;
    }

    server {
        listen 40000;

        proxy_pass minecraft_java;
    }
}
```

### 베드락 에디션 서버인 경우

```nginx
events {
    worker_connections 1024;
}

stream {
    upstream minecraft_bedrock {
        server 실제 서버 주소:19132;
    }

    server {
        listen 40000 udp;

        proxy_pass minecraft_bedrock;
    }
}
```

저장하고 나서 `sudo nginx -s reload` 명령어로 Nginx를 재시작합니다.

이제 localhost:40000으로 접속하면 실제 서버로 연결됩니다.
