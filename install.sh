#!/bin/bash

set -xu

# install deps
echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib
deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib
deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" > /etc/apt/sources.list
sh -c 'printf "deb http://deb.debian.org/debian jessie-backports main\n" > /etc/apt/sources.list.d/jessie-backports.list'
sh -c 'printf "deb http://deb.debian.org/debian jessie-backports-sloppy main" >> /etc/apt/sources.list.d/jessie-backports.list'
apt-get update
apt-get install -y --no-install-recommends build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake wget

# install simple-obfs
apt-get install -y git
git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
make install

# install shadowsocks
apt -t jessie-backports-sloppy install -y shadowsocks-libev

# install tcptun
wget -O tcptun.tar.gz https://github.com/xtaci/kcptun/releases/download/v20180305/kcptun-linux-amd64-20180305.tar.gz
tar -vxzf tcptun.tar.gz
