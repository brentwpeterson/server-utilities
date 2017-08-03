#!bin/bash
echo 'You need to run this as root to see all'

for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l; done
