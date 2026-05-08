FROM ubuntu:24.04

RUN apt update && \
    apt install -y git curl build-essential libssl-dev zlib1g-dev && \
    git clone https://github.com/TelegramMessenger/MTProxy.git /opt/MTProxy && \
    cd /opt/MTProxy && \
    make

WORKDIR /opt/MTProxy

RUN curl -s https://core.telegram.org/getProxySecret -o proxy-secret && \
    curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf

COPY run.sh /run.sh

RUN chmod +x /run.sh

EXPOSE 443

CMD ["/run.sh"]