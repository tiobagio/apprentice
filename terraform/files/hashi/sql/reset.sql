ALTER USER 'root'@'localhost' IDENTIFIED BY 'R31nsta11@';
flush privileges;
exit
update mysql.user set authentication_string=PASSWORD('B@bySit1') where user='root';
