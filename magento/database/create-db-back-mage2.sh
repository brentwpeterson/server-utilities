#!/bin/bash
#########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
# Ask for the app location
#########################

path="$1/app/etc/env.php"
if [ -e "$path" ]
then
echo "Name of file (letsdump-m2.sh is default, followed by [ENTER]:"
read file
#########################
# The path from ~/your_directory
#########################
echo "Do you want to change the name of your main backup directory? (mysql_backup is default), followed by [ENTER]:"
read backdir
backdir=${backdir:-mysql_backup}
file=${file:-letsdump-m2.sh}
#########################
# Collect data on Local.xml
#########################
IN=$(grep -m 1 "dbname" $path)
set -- "$IN" 
IFS="=>"; declare -a Array=($*) 
IN="${Array[2]}"
set -- "$IN" 
IFS="'"; declare -a Array=($*)
dbs="${Array[1]}"
#echo $dbs
IN=$(grep -m 1 "host" $path)
set -- "$IN" 
IFS="=>"; declare -a Array=($*) 
IN="${Array[2]}"
set -- "$IN" 
IFS="'"; declare -a Array=($*)
host="${Array[1]}"
#echo $host
IN=$(grep -m 1 "password" $path)
set -- "$IN" 
IFS="=>"; declare -a Array=($*) 
IN="${Array[2]}"
set -- "$IN" 
IFS="'"; declare -a Array=($*)
password="${Array[1]}"
#echo $password
IN=$(grep -m 1 "username" $path)
set -- "$IN" 
IFS="=>"; declare -a Array=($*) 
IN="${Array[2]}"
set -- "$IN" 
IFS="'"; declare -a Array=($*)
user="${Array[1]}"
#echo $user
IN=$(grep -m 1 "table_prefix" $path)
set -- "$IN" 
IFS="=>"; declare -a Array=($*) 
IN="${Array[2]}"
set -- "$IN" 
IFS="'"; declare -a Array=($*)
table_prefix="${Array[1]}"
#echo $table_prefix
#echo $path
#########################
# Check if path exists
#########################
if [ ! -d "$HOME/$backdir/update" ]; then
mkdir -p $HOME/$backdir/update
fi
checkfile="$HOME/$backdir/$file"
if [ -e "$checkfile" ]; then
mv $HOME/$backdir/$file $HOME/$backdir/$file-bak-$(date +%d%m%Y_%H%M).bak
else
echo $ile ' was created'
fi
touch $HOME/$backdir/$file
touch $HOME/$backdir/update/clean-log.sql
echo "MAGEFILE=\"$dbs-\$(date +%d%m%Y_%H%M).sql.gz\"" >> $HOME/$backdir/$file
#echo "mysql -p'$password' -u $user -h $host $dbs < update/clean-log.sql" >> $HOME/$backdir/$file
echo "mysqldump -p'$password' -u$user -h$host --single-transaction --quick $dbs | gzip > \$MAGEFILE" >> $HOME/$backdir/$file
echo "truncate "$prefix"dataflow_batch_import;truncate "$prefix"log_customer;truncate "$prefix"log_quote;truncate "$prefix"log_summary;truncate "$prefix"log_summary_type;truncate "$prefix"log_url;truncate "$prefix"log_url_info;truncate "$prefix"log_visitor;truncate "$prefix"log_visitor_info;truncate "$prefix"log_visitor_online;truncate "$prefix"report_viewed_product_index;truncate "$prefix"report_compared_product_index;truncate "$prefix"report_event;truncate "$prefix"sendfriend_log;" > $HOME/$backdir/update/clean-log.sql
else
 echo "You really screwed up on the path, dude try this again. Did you screw up on the path? -->  $path"
fi
