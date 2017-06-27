# frps for Dockerfile
FROM alpine:latest
MAINTAINER clangcn@gmail.com

ENV frps_version=0.12.0 \
    frps_DIR=/usr/local/frps

RUN set -ex && \
    frps_latest=https://code.aliyun.com/clangcn/frp/raw/master/v${frps_version}/frp_${frps_version}_linux_amd64.tar.gz && \
    frps_latest_filename=frp_${frps_version}_linux_amd64.tar.gz && \
    apk add --no-cache pcre bash && \
    apk add --no-cache  --virtual TMP wget tar && \
    [ ! -d ${frps_DIR} ] && mkdir -p ${frps_DIR} && cd ${frps_DIR} && \
    wget --no-check-certificate -q ${frps_latest} -O ${frps_latest_filename} && \
    tar xzf ${frps_latest_filename} && \
    mv frp_${frps_version}_linux_amd64/frps ${frps_DIR}/frps && \
    apk --no-cache del --virtual TMP && \
    rm -rf /var/cache/apk/* ~/.cache ${frps_DIR}/${frps_latest_filename} ${frps_DIR}/frp_${frps_version}_linux_amd64

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
