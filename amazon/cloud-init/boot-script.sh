#!/bin/bash
vhost='/path/to/vhost/vhost.conf'
yum update -y
service httpd start
chkconfig httpd on
OUTPUT="$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
sed -i "s/%PRIV%/$OUTPUT/g" $vhost
