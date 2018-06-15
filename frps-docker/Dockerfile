# frps for Dockerfile
#frps_version=0.20.0
FROM alpine:latest
MAINTAINER clangcn@gmail.com

RUN set -ex && \
    apk add --no-cache pcre bash && \
    [ ! -d /usr/local/frps ] && mkdir -p /usr/local/frps && cd /usr/local/frps
COPY frps /usr/local/frps/frps

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh /usr/local/frps/frps
ENTRYPOINT ["/entrypoint.sh"]
