FROM alpine

LABEL maintainer="beilunyang <786220806@qq.com>"

WORKDIR /home

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
  cd simple-obfs \
  git submodule update --init --recursive \
  ./autogen.sh \
  ./configure && make \
  make install \
  # install kcptun
  && apk add --no-cache go \
  && go get -u github.com/xtaci/kcptun/server

EXPOSE 23333:8388






