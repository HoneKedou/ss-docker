FROM alpine

LABEL maintainer="beilunyang <786220806@qq.com>"

WORKDIR /home

ARG SS_VERSION=v3.2.0
ARG OBFS_VERSION=v0.0.5
ARG KCPTUN_VERSION=20180316

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV PASSWORD iamyourfather
ENV METHOD aes-256-cfb
ENV TIMEOUT 300
ENV DNS_ADDR 8.8.8.8
ENV PLUGIN obfs-server
ENV PLUGIN_OPTS obfs=http 

RUN set -ex \
  # use deps mirror
  && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
  && apk update \
  # install common deps
  && apk add --no-cache \
    git \
    autoconf \
    automake \
    libev-dev \
    libtool \ 
    linux-headers \
    gcc \
    g++ \
  # install shadowsocks
  && apk add --no-cache \
    build-base \
    c-ares-dev \
    libsodium-dev \
    mbedtls-dev \
    pcre-dev \
  && git clone https://github.com/shadowsocks/shadowsocks-libev.git \
  && cd shadowsocks-libev \
  && git checkout ${SS_VERSION} \
  && git submodule update --init --recursive \ 
  && ./autogen.sh \
  && ./configure --prefix=/usr --disable-documentation \
  && make install \
  && apk add --no-cache \
    rng-tools \
    $(scanelf --needed --nobanner /usr/bin/ss-* \
    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
    | sort -u) \
  # install simple-obfs
  && apk add --no-cache \
    zlib-dev \
    openssl \ 
    asciidoc \
    xmlto \
    libpcre32 \ 
  && git clone https://github.com/shadowsocks/simple-obfs.git \
  && cd simple-obfs \
  && git checkout ${OBFS_VERSION} \
  && git submodule update --init --recursive \
  && ./autogen.sh \
  && ./configure && make \
  && make install \
  # install kcptun
  && wget https://github.com/xtaci/kcptun/releases/download/v${KCPTUN_VERSION}/kcptun-linux-amd64-${KCPTUN_VERSION}.tar.gz \
  && tar -zxvf kcptun-linux-amd64-${KCPTUN_VERSION}.tar.gz
ENTRYPOINT []
EXPOSE 8388






