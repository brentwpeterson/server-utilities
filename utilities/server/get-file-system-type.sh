df -P -T $1 | tail -n +2 | awk '{print $2}'
