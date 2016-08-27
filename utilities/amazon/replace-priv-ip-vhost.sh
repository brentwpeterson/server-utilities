#!bin/sh
OUTPUT="$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
sed -i "s/%PRIV%/$OUTPUT/g" $1 
