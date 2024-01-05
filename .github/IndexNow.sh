#!/bin/bash

commit_message=$(git log -1 --pretty=format:"%s")

# 커밋 메시지가 'new post: '로 시작할 때만
if [[ $commit_message == "new post: "* ]]; then
  title=${commit_message#"new post: "}  # 'new post: ' 부분을 제거하여 제목만 추출

  curl -X POST -H "Content-Type: application/json" \
    -d '{
          "url": "https://blog.ny64.kr/posts/'"$title"'",
          "type": "URL_UPDATED"
        }' \
    "https://indexing.googleapis.com/v3/urlNotifications:publish?key=YOUR_API_KEY"
else
  echo "Not a new post. Do nothing."
fi