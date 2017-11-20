FOO='Name=tag:Name,Values=Shop'$1'*'
OUTPUT="$(aws ec2 describe-instances --filters $FOO | jq -r '.Reservations[].Instances[].PrivateIpAddress')"
ssh "${OUTPUT}"
