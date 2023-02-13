---
title: "Jekyll 블로그에 카카오 애드핏 적용하기"
summary: "카카오 애드핏 적용과 1일 광고 수익"
categories: ["강좌", "Jekyll"]
date: 2022-02-25
comments: true
tags:
    - AdFit
    - AdSense
    - Jekyll
    - Blog
---

Jekyll 블로그에 카카오 애드핏을 적용하는 방법과 1일 광고 수익에 대해 알아보겠습니다.

## 카카오 애드핏에 사이트 등록하기

먼저 [카카오 애드핏 웹사이트](https://adfit.kakao.com/ad/media)에 접속해 블로그를 등록해야 합니다.

**새 매체**를 눌러, 사이트를 등록합니다.

{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/kakao-adfit.png" title="카카오 애드핏" >}}
{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/add-site.png" title="사이트 추가" >}}

입력란을 채운 후, 광고단위 등록 버튼을 클릭합니다.

그럼 카카오에 심사 요청이 완료됩니다.

카카오 애드핏은 구글 애드센스와는 다르게 웬만하면 심사가 승인되는 편입니다.

심사 완료까지는 1~3일이 소요됩니다.

만약 심사가 보류되었다면, 블로그에 포스트 수가 너무 적어서 그런 경우가 대부분이니, 포스트를 좀 더 채운 후 심사를 요청해보세요.

## 블로그에 광고 추가하기

매체 심사가 승인되었다면, 추가한 매체 설정에 들어가 **새 광고단위**를 클릭합니다.

{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/new-ad.png" title="새 광고단위" >}}

그럼 아래와 같은 화면이 나오는데, 광고 단위명을 입력하고 사이즈를 선택합니다.

**조금이라도 수익을 올리고 싶다면 새로 고침 빈도를 30초로 설정해, 30초마다 새로운 광고가 나오게 하는 것이 좋습니다.**

{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/image01.png" title="새 광고단위 설정" >}}

어떤 기기로 접속하냐에 따라 광고 사이즈를 다르게 보여줘야 하므로, **728x90**과 **300x250** 사이즈로 각각 광고단위를 만들어 줍니다.

**스크립트/SDK 발급** 버튼을 누르면 아래와 같이 광고단위 코드와 JS 코드가 나옵니다.
{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/image02.png" title="스크립트/SDK 발급" >}}

접속하는 기기의 화면 크기에 따라 동적으로 광고를 보여주기 위해 아래의 코드를 복사해서

`_includes/adfit.html` 파일을 만든 다음 붙여넣어 줍니다.
{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/image03.png" title="adfit.html 파일 생성" >}}

```javascript
<script>
	if (window.matchMedia("( min-width: 1024px )").matches == true) {
		document.write(
			'<ins class="kakao_ad_area" style="display:none;" data-ad-unit="728x90 광고단위 코드" data-ad-width="728" data-ad-height="90"></ins><script type="text/javascript" src="//t1.daumcdn.net/kas/static/ba.min.js" async><\/script>'
		);
	}
	if (window.matchMedia("( max-width: 768px )").matches == true) {
		document.write(
			'<ins class="kakao_ad_area" style="display:none;" data-ad-unit="300x250 광고단위 코드"" data-ad-width="300" data-ad-height="250"></ins><script type="text/javascript" src="//t1.daumcdn.net/kas/static/ba.min.js" async><\/script>'
		);
	}
</script>
```

광고를 포스트 페이지 하단에 표시하기 위해서 `_layouts\page.html` 파일 하단에 `% include adfit.html %}` 를 추가해 줍니다.

## 광고 적용 확인

다시 블로그에 접속해보면, 포스트 페이지 하단마다 광고가 잘 나오는 것을 확인할 수 있습니다.
{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/ad.png" title="광고 적용 확인" >}}

## 광고 적용한 뒤 하루 수익

{{< img src="/posts/apply-kakao-adfit-to-jekyll-blog/images/image04.png" title="adfit.html 하루 수익" >}}

블로그에 광고를 추가한 뒤 하루 수익입니다.

72원!

~~그래도 없는거 보다는 좋으니까.. 뭐..~~

카카오 애드핏은 **5만원** 이상이 모여야 출금이 가능합니다
