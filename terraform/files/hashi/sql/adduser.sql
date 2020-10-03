drop user if exists 'tio'@'%';

create user 'tio'@'%' identified by 'R31nsta11@';

grant all privileges on *.* to 'tio'@'%' with grant option;

exit
