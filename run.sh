#!/bin/bash

set -xu

echo "------starting running service------"

if [$1 -a ${#1} -gt 5]
then
    echo "starting running service shadowsocks with custom password" 
    service shadowsocks-libev start -c /ss-config.json -u -k $1
else
    if [$1] 
    then
        echo "the length of password can't < 6"
    else
        echo "starting running service shadowsocks with default password"
    fi
    service shadowsocks-libev start -c /ss-config.json -u
fi
echo "starting running service kcptun"
server_linux_amd64 -c /kt-config.json 
echo "-----services have all started------"
