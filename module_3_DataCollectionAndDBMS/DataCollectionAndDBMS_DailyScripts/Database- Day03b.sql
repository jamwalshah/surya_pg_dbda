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



###################
-- Database- Day03b
###################

-- run hr.sql script
USE hr;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

DESC countries;
DESC departments;
DESC employees;
DESC job_history;
DESC jobs;
DESC locations;
DESC regions;

SHOW COLUMNS FROM countries;

USE hr;
SHOW TABLES;	#SHOW table

SHOW TABLE STATUS;
SHOW DATABASES;		#SHOW DATABASE
#SHOW DATABASES LIKE %hr%;		#works in different version


SELECT * FROM employees;
SELECT FIRST_NAME, LAST_NAME FROM employees;
SELECT * FROM employees WHERE LAST_NAME='King';
SELECT first_name, LAST_NAME FROM employees WHERE LAST_NAME='King';

-- ALIASES
#	COLUMN ALIAS
SELECT FIRST_NAME FROM employees;	#original column
SELECT FIRST_NAME AS fname FROM employees;	#ALIAS using AS

#	TABLE ALIAS
SELECT e.FIRST_NAME FROM employees e;	#ALIAS of table used to display column

#	SHORTHAND
SELECT FIRST_NAME fname FROM employees;	#SHORTHAND, ALIAS without using AS, 

# created temporary view
SELECT FIRST_NAME AS fname, salary*10 increment, salary FROM employees;

