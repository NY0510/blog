---
title: 'NGINX 디렉터리 기반 동적 라우팅 설정'
date: 2025-06-23T11:42:34+09:00
comments: true
categories: ['강좌']
summary: ''
tags:
  - Nginx
  - Linux
---

Nginx를 사용하여 디렉터리 기반 동적 라우팅 설정을 해보자. 최종적으로 설정 후 아래와 같은 라우팅 구성이 가능해진다.

- https://example.com → `example.com/index.html`
- https://sub1.example.com → `sub2.example.com/index.html`
- https://sub2.example.com → `sub1.example.com/index.html`
- https://asdf.example.com → 404 Not Found

```bash
├── example.com
│   └── index.html
├── sub1.example.com
│   └── index.html
└── sub2.example.com
    └── index.html
```

## 폴더 생성

먼저 HTML 파일들을 저장할 폴더를 생성해 주어야 한다. 이 글에서는 `~/nginx` 폴더를 사용하겠다.

## Nginx 설정

```nginx
server {
    listen 443 ssl;
    server_name *.example.com example.com;

    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    ssl_certificate     /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_trusted_certificate /etc/letsencrypt/live/example.com/chain.pem;

    set $custom_root "/home/ny64/nginx/$host";

    if (!-d $custom_root) {
        return 404;
    }

    root $custom_root;
    index index.html;
    charset utf-8;

    location / {
        try_files $uri $uri/index.html =404;
    }
}
```

위 설정 파일을 자신에 시스템 환경에 알맞게 수정하여 Nginx의 Root Server(가장 첫 번째 Server) 블록으로 지정해주면 된다.
