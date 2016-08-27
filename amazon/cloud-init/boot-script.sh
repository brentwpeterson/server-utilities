#!/bin/bash
vhost='path/to/vhost'
yum update -y
chkconfig httpd on
OUTPUT="$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
sed -i "s/%PRIV%/$OUTPUT/g" $vhost
service httpd restart
