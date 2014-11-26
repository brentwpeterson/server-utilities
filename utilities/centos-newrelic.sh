rpm -Uvh http://download.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm
yum install newrelic-sysmond
echo "Enter your licese key  followed by [ENTER]:"
read key
nrsysmond-config --set license_key=$key
/etc/init.d/newrelic-sysmond start
