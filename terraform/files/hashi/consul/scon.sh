#!/bin/bash

SCENARIO=$1
echo "scenario $SCENARIO"

sql_pid=`ps -ef |grep 'sidecar-for mysql' |grep -v grep |awk '{print $2}'`
if [ "$sql_pid" != "" ]; then 
	echo "SQL pid is $sql_pid"
#	sudo kill -9 $sql_pid
fi

php_pid=`ps -ef |grep 'sidecar-for php' |grep -v grep |awk '{print $2}'`
if [ "$php_pid" != "" ]; then 
	echo "PHP pid is $php_pid"
#	sudo kill -9 $php_pid
fi
