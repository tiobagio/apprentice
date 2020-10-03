drop user if exists 'tio'@'%';
create user 'tio'@'%' identified by 'R31nsta11@';
grant all privileges on *.* to 'tio'@'%' with grant option;

drop database if exists demodb;
CREATE DATABASE demodb;

drop database if exists test;
CREATE DATABASE test;

use test;

CREATE TABLE users (
        id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        firstname VARCHAR(30) NOT NULL,
        lastname VARCHAR(30) NOT NULL,
        email VARCHAR(50) NOT NULL,
        age INT(3),
        location VARCHAR(50),
        date TIMESTAMP
);

CREATE TABLE random (
        id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        age INT(3)
);

INSERT INTO users (firstname, lastname, email, age, location) values ('tio', 'bagio', 'tio.bagio@gmail.com', 17, 'SG'); 

INSERT INTO random (age) values (88);
INSERT INTO random (age) values (6);
INSERT INTO random (age) values (21);

commit;
flush privileges;
