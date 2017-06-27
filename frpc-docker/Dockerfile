# frpc for Dockerfile
FROM alpine:latest
MAINTAINER clangcn@gmail.com

ENV frpc_version=0.12.0 \
    frpc_DIR=/usr/local/frpc

RUN set -ex && \
    frpc_latest=https://code.aliyun.com/clangcn/frp/raw/master/v${frpc_version}/frp_${frpc_version}_linux_amd64.tar.gz && \
    frpc_latest_filename=frp_${frpc_version}_linux_amd64.tar.gz && \
    apk add --no-cache pcre bash && \
    apk add --no-cache  --virtual TMP wget tar && \
    [ ! -d ${frpc_DIR} ] && mkdir -p ${frpc_DIR} && cd ${frpc_DIR} && \
    wget --no-check-certificate -q ${frpc_latest} -O ${frpc_latest_filename} && \
    tar xzf ${frpc_latest_filename} && \
    mv frp_${frpc_version}_linux_amd64/frpc ${frpc_DIR}/frpc && \
    apk --no-cache del --virtual TMP && \
    rm -rf /var/cache/apk/* ~/.cache ${frpc_DIR}/${frpc_latest_filename} ${frpc_DIR}/frp_${frpc_version}_linux_amd64

ADD entrypoint.sh /entrypoint.sh
ADD start_frpc.sh /start_frpc.sh
RUN chmod +x /entrypoint.sh /start_frpc.sh
ENTRYPOINT ["/entrypoint.sh"]
