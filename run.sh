#!/bin/bash

ulimit -n 4096

SECRET=${SECRET:-0123456789abcdef0123456789abcdef}
PORT=${PORT:-443}

exec /opt/MTProxy/objs/bin/mtproto-proxy \
  -u nobody \
  -H "${PORT}" \
  -p 8888 \
  -S "${SECRET}" \
  -C 256 \
  --aes-pwd /opt/MTProxy/proxy-secret /opt/MTProxy/proxy-multi.conf \
  --http-stats \
  -M 1