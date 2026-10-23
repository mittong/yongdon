#!/bin/bash
# 맥/리눅스용 미리보기 실행 파일 (터미널에서 ./start.command)
cd "$(dirname "$0")"
PORT=8080
echo "Preview: http://localhost:$PORT/preview.html  (Ctrl+C to stop)"
(sleep 1; open "http://localhost:$PORT/preview.html" 2>/dev/null || xdg-open "http://localhost:$PORT/preview.html" 2>/dev/null) &
python3 -m http.server $PORT
