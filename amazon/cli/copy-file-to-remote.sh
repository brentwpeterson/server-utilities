FOO='Name=tag:Name,Values='$1'*'
REMOTEUSER='ec2-user'
OUTPUT="$(aws ec2 describe-instances --filters $FOO | jq -r '.Reservations[].Instances[].PrivateIpAddress')"
scp $2  $REMOTEUSER@"${OUTPUT}":~/
