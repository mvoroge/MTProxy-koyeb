#!/bin/bash

ulimit -n 4096

SECRET=${SECRET:-0123456789abcdef0123456789abcdef}
PORT=${PORT:-443}
MAX_CONNECTIONS=${MAX_CONNECTIONS:-128}
HTTP_PORT=${HTTP_PORT:-8888}


# ---- HTTP HEALTH SERVER ----
while true; do
  echo -e "HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK" | nc -l -p "$HTTP_PORT" -q 1
done &

exec /opt/MTProxy/objs/bin/mtproto-proxy \
  -u nobody \
  -p 0.0.0.0:$PORT \
  -S "${SECRET}" \
  -C 256 \
  -c "${MAX_CONNECTIONS}" \
  --aes-pwd /opt/MTProxy/proxy-secret /opt/MTProxy/proxy-multi.conf \
  --http-stats \
  -M 1