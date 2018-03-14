#!/bin/bash

set -u

echo "------starting running service------"

if [ $# -gt 0 ]
then 
    if [ ${#1} -gt 5 ]
    then
        echo "starting running service shadowsocks with custom password" 
        service shadowsocks-libev start -c /ss-config.json -u -k $1
    else
        echo "the length of password can't less than 6"
        echo "starting running service shadowsocks with default password"
        service shadowsocks-libev start -c /ss-config.json -u
    fi
else
    echo "starting running service shadowsocks with default password"
    service shadowsocks-libev start -c /ss-config.json -u
fi
echo "starting running service kcptun"
server_linux_amd64 -c /kt-config.json 
echo "-----services have all started------"
