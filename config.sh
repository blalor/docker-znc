#!/bin/bash

set -e -x -u

cd /tmp/src

groupadd -g 600 znc
useradd -g znc -u 600 -r znc

yum install -y znc

mv program-znc.conf /etc/supervisor.d/

mkdir -p /var/lib/znc/configs
mv znc.conf /var/lib/znc/configs/znc.conf

chown -R znc:znc /var/lib/znc

## because lazy
runuser -s /bin/bash znc -c "znc --datadir /var/lib/znc --makepem"

## cleanup
cd /
yum clean all
rm -rf /var/tmp/yum-root* /tmp/src
