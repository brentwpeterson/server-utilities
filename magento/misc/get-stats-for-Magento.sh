echo 'Enter name of file you want for output text'
FILE=$1

## MySQL is not always on the same server
#mysql -e "show global status"
#mysql -e "show global variables"

echo '========== VMSTAT ============' >> $FILE
vmstat 1 10 >> $FILE
echo '========== NETSTAT ============' >> $FILE
netstat -nap >> $FILE
echo '========== DMESG ============' >> $FILE
dmesg >> $FILE
echo '========== FEE MEM ============' >> $FILE
free -mo >> $FILE
echo '========== UPTIME ============' >> $FILE
uptime >> $FILE
echo '========== PHP VERSION ============' >> $FILE
php -v >> $FILE
echo '========== PHP MODULES ============' >> $FILE
php -m >> $FILE
echo '========== IO STATS ============' >> $FILE
iostat -dx 3 >> $FILE


