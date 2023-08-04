###################
-- Database- Day02
###################
CREATE USER user12apr@localhost IDENTIFIED BY 'mysql';
CREATE USER seconduser@localhost IDENTIFIED BY 'mysql', thirduser@localhost IDENTIFIED BY 'mysql';
SELECT USER FROM mysql.user;



###################
-- Database- Day03a
###################
-- List users in your database
SELECT USER FROM mysql.user;

-- SHOW GRANTS command
SHOW GRANTS FOR seconduser@localhost;
-- this '*.*' means that USER seconduser
-- can only login to the databaseserver
-- and have no other privilege

-- --------------------------------
-- password change in user
-- this can be done using 3 commands (UPDATE, ALTER, SET)

-- 1. using SET
#SET PASSWORD FOR 'seconduser'@'localhost'=PASSWORD('abc');		# for older version
SET PASSWORD FOR 'seconduser'@'localhost'='abc';

-- 2. using ALTER
ALTER user 'thirduser'@'localhost' IDENTIFIED BY 'abc';

-- 3. using UPDATE
USE mysql;
#UPDATE user SET password=password('xyz') WHERE user='seconduser' AND host='localhost';		#for older version
UPDATE user SET seconduser=password('xyz') WHERE user='seconduser' AND host='localhost';
#UPDATE user SET authentication_string=password('xyz') WHERE user='seconduser' AND host='localhost';	#shows error
FLUSH PRIVILEGES;

-- RENAME a user
RENAME user 'seconduser'@'localhost' TO 'dusrauser'@'localhost';
SELECT user FROM mysql.user;

-- DROP user (to remove user from database)
DROP user 'dusrauser'@'localhost';
SELECT user FROM mysql.user;

-- GRANT (giving permisison to the user)
GRANT ALL PRIVILEGES ON *.* TO thirduser@localhost;
SHOW GRANTS FOR thirduser@localhost;

-- GRANT only 'SELECT' command PRIVILEGE
GRANT SELECT ON *.* TO thirduser@localhost;
SHOW GRANTS FOR thirduser@localhost;
