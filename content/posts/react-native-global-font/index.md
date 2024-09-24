---
title: 'React Native 전역 폰트 설정하기'
date: 2024-09-24T10:22:41+09:00
comments: true
categories: ['강좌']
summary: ''
tags:
    - React Native
---

React Native에서 전역 폰트를 설정하는 방법을 알아보겠습니다.

## React Native Global Props 사용

필요한 라이브러리를 설치합니다.

```bash
yarn add react-native-global-props
```

`App.tsx` 또는 `index.js` 파일에서 전역 폰트를 설정합니다.

```jsx
import { setCustomText } from 'react-native-global-props';

setCustomText({
	style: {
		fontFamily: 'Pretendard',
	},
});
```

## 커스텀 Text 컴포넌트 만들기

라이브러리를 사용하는 방법 외에도 커스텀 Text 컴포넌트를 만들어 사용할 수 있습니다.

이는 React Native 공식 문서에서도 권장하는 방법입니다.

```jsx
// components/CustomText.tsx

import React from 'react';
import { Text, TextProps } from 'react-native';

const CustomText: React.FC<TextProps> = ({ children, style, ...props }) => {
	return (
		<Text style={[{ fontFamily: 'Pretendard' }, style]} {...props}>
			{children}
		</Text>
	);
};

export default CustomText;
```

```jsx
// App.js

import CustomText from './components/CustomText';

const App = () => {
	return <CustomText>Hello, World!</CustomText>;
};
```

### Default Props 설정하기

`App.tsx` 또는 `index.js` 파일에서 전역으로 설정할 수 있습니다.

```jsx
Text.defaultProps = Text.defaultProps || {};
Text.defaultProps.style = { fontFamily: 'Pretendard' };
```
