#!/bin/bash
# count_em - count files in all subdirectories under current directory.
echo 'echo $(ls -a "$1" | wc -l) $1' >/tmp/count_em_$$
chmod 700 /tmp/count_em_$$
find . -mount -type d -print0 | xargs -0 -n1 /tmp/count_em_$$ | sort -n
rm -f /tmp/count_em_$$
