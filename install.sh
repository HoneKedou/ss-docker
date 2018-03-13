#!/bin/bash

set -xu

# install deps
apt-get update
apt-get install -y --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake wget git

# install shadowsocks
apt-get install -y --no-install-recommends shadowsocks-libev

# install simple-obfs
git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
make install

# install tcptun
wget -O tcptun.tar.gz https://github.com/xtaci/kcptun/releases/download/v20180305/kcptun-linux-amd64-20180305.tar.gz
tar -vxzf tcptun.tar.gz
