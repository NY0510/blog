---
title: "GS반값택배 QR코드 얻기"
date: 2024-04-16T10:22:39+09:00
comments: true
categories: ["강의", "잡다한거"]
summary: ""
tags:
    - GS반값택배
    - 뻘짓
---

GS25 편의점 반값택배를 보내면 입력한 받는 사람 번호로 QR코드가 전송된다.

이 QR코드가 있어야 택배 수령이 가능한데, 어떠한 이유로 QR코드가 전송되지 않았을 때 QR코드를 얻어내는 방법을 알아보자.

## 웹페이지 분석

택배를 받으면 카카오톡 알림톡으로 QR코드가 포함된 링크가 전송된다.

이 링크는 `https://www.cvsnet.co.kr/qr/<문자열>` 형태로 이루어져 있다.

해당 웹페이지의 소스코드를 보면 다음과 같은 자바스크립트 코드가 있다.

```js
try {
	var invoiceNo = atob("<문자열>");
} catch (e) {}
$(document).ready(function () {
	$.get("/qr/valid/" + invoiceNo)
		.done(function () {
			$(".invoice-title").html("<h6>운송장 번호 : " + invoiceNo + "</h6>");
			$("#qr-image").attr("src", "/qr/pickups/" + invoiceNo + ".png");
		})
		.fail(function (data) {
			$("#qr-image").remove();
			$(".alert").text(data.responseText);
			$(".alert").addClass("show");
		});
});
```

코드의 `<문자열>` 부분은 URL의 있는 랜덤한 문자열이다.

## 코드 분석

코드를 분석해보자

먼저 `atob` 함수는 base64 문자열을 디코딩하는 함수이다. 디코딩한 문자열을 `invoiceNo` 변수에 저장하는걸 볼 수 있다.

실제로 해당 문자열을 디코딩해보면 12자리 숫자로 이루어진 운송장 번호가 나온다.

그리고 `/qr/valid/`로 GET 요청을 보낸다. 엔드포인트를 보면 이 요청은 운송장 번호가 올바른지 확인하는 요청으로 불 수 있다.

만약 응답이 200 OK라면 `/qr/pickups/<운송장 번호>/.png`에 있는 QR코드 이미지를 가져와 표시한다.

코드에 심각한 보안 취약점이 있어 운송장 번호만 있다면 아무나 QR코드를 얻을 수 있다.

## QR코드 얻기

따라서 [base64 디코딩 사이트](https://www.base64decode.org/) 등에서 URL 끝부분에 있는 문자열을 디코딩해서 나온 운송장 번호를

`https://www.cvsnet.co.kr/qr/pickups/<운송장 번호>.png` 링크에 넣고 접속하면 QR코드를 얻을 수 있다.
