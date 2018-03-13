#!/bin/bash

set -xu

echo "------starting running service------"

if ["$1"];then 
    echo "starting service shadowsocks with custom password" 
    service shadowsocks-libev start -c /ss-config.json -u -k $1
else
    echo "starting service shadowsocks with default password"
    service shadowsocks-libev start -c /ss-config.json -u
fi
echo "starting service kcptun"
server_linux_amd64 -c /kt-config.json 
echo "-----services have all started------"
