#!/bin/bash

SCENARIO=$1
echo "scenario $SCENARIO"

# cleanup previous side-car
#
sql_pid=`ps -ef |grep 'sidecar-for mysql' |grep -v grep |awk '{print $2}'`
if [ "$sql_pid" != "" ]; then 
	echo "SQL pid is $sql_pid"
	sudo kill -9 $sql_pid
fi

php_pid=`ps -ef |grep 'sidecar-for php' |grep -v grep |awk '{print $2}'`
if [ "$php_pid" != "" ]; then 
	echo "PHP pid is $php_pid"
	sudo kill -9 $php_pid
fi

case $SCENARIO in
base)
	echo "base scenario..."

	sudo cp ~/hashi/consul/php.json /etc/consul.d/php.json
	sudo cp ~/hashi/consul/mysql.json /etc/consul.d/mysql.json
	sudo cp ~/hashi/html/config.php /var/www/html/config.php
	sudo chown consul:consul /etc/consul.d/*.json
	consul reload
	sleep 3

	;;
mtls)
	echo "mtls scenario..."

        sudo cp ~/hashi/consul/php-scar.json /etc/consul.d/php.json
        sudo cp ~/hashi/consul/mysql-scar.json /etc/consul.d/mysql.json
        sudo cp ~/hashi/html/config5.php /var/www/html/config.php
        sudo chown consul:consul /etc/consul.d/*.json
        consul reload
        sleep 3

        consul connect proxy -sidecar-for mysql &
        consul connect proxy -sidecar-for php &
	;;
*)
	echo "wrong scenario!!"
esac
