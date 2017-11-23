#!bin/bash
#You must have JQ installed on your host machine
FOO='Name=tag:Name,Values='$1'*'
REMOTEPATH=$2
OUTPUT="$(aws ec2 describe-instances --filters $FOO | jq -r '.Reservations[].Instances[].PrivateIpAddress')"
ssh "${OUTPUT}" 'bash -s' < $REMOTEPATH/clear-cache.sh
