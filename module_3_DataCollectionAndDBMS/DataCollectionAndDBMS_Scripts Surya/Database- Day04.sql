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



###################
-- Database- Day04
###################
USE hr;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS EmployeeName From employees; # concat() will conatenate two columns data into one column
# 

-- WHERE clause
SELECT EMPLOYEE_ID, SALARY FROM employees WHERE SALARY>5000;

-- Relational Operators
-- Greater than
SELECT * FROM employees WHERE SALARY>8000; # prints employees with salary more than 8000
-- Less than
SELECT * FROM employees WHERE SALARY<10000; # prints employees with salary less than 10000
-- Not Equal to
SELECT * FROM employees WHERE SALARY!=17000; # prints employees with salary not equal to 17000
SELECT * FROM employees WHERE SALARY<>17000; # prints employees with salary not equal to 17000

-- logical NOT , similar to Not Equal to
SELECT * FROM employees WHERE NOT SALARY=17000; # prints employees with salary not equal to 17000
-- equal to , Greater than , logical AND 
SELECT * FROM employees WHERE DEPARTMENT_ID=100 AND SALARY>6000; # print empolyees who work
-- BETWEEN.. AND operator
SELECT * FROM employees WHERE SALARY BETWEEN 10000 AND 12000; # print employee whose salary is between 10k to 12k

-- AND operator
SELECT * FROM employees WHERE department_id=100 AND SALARY>6000; # print employee whose dept ID is 100 and salary greater than 6000
-- OR operator
SELECT * FROM employees WHERE department_id=100 OR SALARY>6000; # print employee whose dept ID is 100 or salary greater than 6000

-- Write a query where employee works for
-- dept whose ID is 60 or 30 and have salary of 13000
SELECT * FROM employees	# Query 1, works as expected for above problem
WHERE (DEPARTMENT_ID=60 OR DEPARTMENT_ID=20)
AND SALARY=13000;
SELECT * FROM employees # Query 2
WHERE DEPARTMENT_ID=60 OR DEPARTMENT_ID=20 AND SALARY=13000;

SELECT * FROM employees # Query 2
WHERE DEPARTMENT_ID=60 OR DEPARTMENT_ID=20;

-- IN operator
SELECT * FROM employees	# IN operator
WHERE DEPARTMENT_ID IN (10, 20,30);
SELECT * FROM employees	# NOT IN operator combination
WHERE SALARY NOT IN (24000, 17000);

-- ANY operator
SELECT * FROM employees; # observer output
SELECT * FROM DEPARTMENTS; # observe output, as it is being used in sub-query
# matches all values of DEPARTMENT_ID from departments table in table employees to print DEPARTMENT_IS & FIRST_NAME
SELECT DEPARTMENT_ID, FIRST_NAME FROM employees	
WHERE DEPARTMENT_ID =
ANY (SELECT DEPARTMENT_ID FROM departments);

SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_ID IN (10, 20);  # observe output, as it is being used in sub-query
# matches DEPARTMENT_ID 10, 20 from departments table in table employees to print DEPARTMENT_IS & FIRST_NAME
SELECT DEPARTMENT_ID, FIRST_NAME FROM employees
WHERE DEPARTMENT_ID =
ANY (SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_ID IN (10, 20));

SELECT SALARY FROM employees WHERE SALARY BETWEEN  9000 AND 12000;
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY FROM employees
WHERE SALARY =
ANY (SELECT SALARY FROM employees WHERE SALARY BETWEEN 9000 AND 12000);

-- ALL operator
SELECT DEPARTMENT_ID FROM departments; # observe output, as it is being used in sub-query
SELECT * from employees	# returns NULL as none of the condition is specified using WHERE clause
WHERE DEPARTMENT_ID=
ALL (SELECT DEPARTMENT_ID FROM departments); 

SELECT DEPARTMENT_ID FROM departments  WHERE DEPARTMENT_ID=90; # observe output, as it is being used in sub-query
SELECT * from employees	# returns records from employees who have DEPARTMENT_ID=90
WHERE DEPARTMENT_ID=
ALL (SELECT DEPARTMENT_ID FROM departments  WHERE DEPARTMENT_ID=90);

# comaprarison of ANY, ALL outputs
SELECT * from employees	# returns same output as previous query with ALL operator
WHERE DEPARTMENT_ID=
ANY (SELECT DEPARTMENT_ID FROM departments  WHERE DEPARTMENT_ID=90); 

#
SELECT FIRST_NAME fname, SALARY, SALARY*12 annual_salary FROM employees;
SELECT * FROM employees;

-- String Function
-- concat()
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS EmployeeName FROM employees;
-- instr()
SELECT instr(FIRST_NAME, 'ar') AS pos_of_ar FROM employees;
SELECT instr(FIRST_NAME, 'ar') AS pos_of_ar, FIRST_NAME FROM employees;
-- length in bytes
SELECT length(FIRST_NAME) as len_bytes FROM employees;
SELECT length(FIRST_NAME) as len_bytes, FIRST_NAME FROM employees;
-- length in character
SELECT char_length(FIRST_NAME) as length_chars FROM employees;
SELECT char_length(FIRST_NAME) as length_chars, FIRST_NAME FROM employees;
-- left
SELECT left(FIRST_NAME, 3) FROM employees;
SELECT left(FIRST_NAME, 3), FIRST_NAME FROM employees;
-- right
SELECT right(FIRST_NAME, 3) FROM employees;
SELECT right(FIRST_NAME, 3), FIRST_NAME FROM employees;
-- lower
SELECT lower(FIRST_NAME) AS fname FROM employees;
SELECT lower(FIRST_NAME) AS fname, FIRST_NAME FROM employees;
-- upper
SELECT upper(FIRST_NAME) AS fname FROM employees;
SELECT upper(FIRST_NAME) AS fname, FIRST_NAME FROM employees;
-- lpad
SELECT lpad(FIRST_NAME, 10, '*') FROM employees;
SELECT lpad(FIRST_NAME, 10, '*') AS fname, FIRST_NAME FROM employees;
-- rpad
SELECT rpad(FIRST_NAME, 10, '*') FROM employees;
SELECT rpad(FIRST_NAME, 10, '*') AS fname, FIRST_NAME FROM employees;
-- substring
SELECT substring(FIRST_NAME, 3, 2) FROM employees;
SELECT substring(FIRST_NAME, 3, 2), FIRST_NAME FROM employees;
SELECT FIRST_NAME FROM employees;
SELECT substring(FIRST_NAME, 3) FROM employees;
SELECT substring(FIRST_NAME, 3), FIRST_NAME FROM employees;
SELECT substr(FIRST_NAME, 3), FIRST_NAME FROM employees; # works same as substring() function
-- string_
SELECT STREET_ADDRESS FROM locations;
SELECT substring_index(STREET_ADDRESS, ' ', -1) AS street FROM locations;
SELECT substring_index(STREET_ADDRESS, ' ', -1) AS street, STREET_ADDRESS FROM locations;
-- intcap
SELECT intcap(FIRST_NAME) FROM employees;
SELECT concat(upper(substr(FIRST_NAME, 1, 1)), lower(substr(FIRST_NAME, 2))) AS intcap, FIRST_NAME FROM employees; # turns it into capital case
-- replace
SELECT replace(FIRST_NAME, 'a', 'Y') FROM employees;
SELECT replace(FIRST_NAME, 'a', 'Y') AS replaced_str, FIRST_NAME FROM employees;
-- reverse
SELECT reverse(FIRST_NAME) FROM employees;
SELECT reverse(FIRST_NAME) AS reversed_name, FIRST_NAME FROM employees;
-- locate
SELECT locate('ell', FIRST_NAME) FROM employees;
SELECT locate('ell', FIRST_NAME) AS position_of_ell, FIRST_NAME FROM employees;
-- find_in_set
SELECT DEPARTMENT_ID FROM departments
WHERE find_in_set('IT', DEPARTMENT_NAME);
SELECT find_in_set() FROM employees;

use hr;
-- avg()
SELECT avg(SALARY) FROM employees;
SELECT avg(SALARY) AS average FROM employees;
-- sum()
SELECT sum(SALARY) FROM employees;
SELECT sum(SALARY) AS sum FROM employees;
-- count()
SELECT count(*) FROM employees;
SELECT count(*) AS employee_count FROM employees;
-- min(), max()
SELECT min(SALARY), max(SALARY) FROM employees;
SELECT min(SALARY) AS min_salary, max(SALARY) AS max_salary FROM employees;

-- isnull()
SELECT FIRST_NAME FROM employees WHERE isnull(SALARY);
SELECT FIRST_NAME AS null_in_fname FROM employees WHERE isnull(SALARY);
-- least()
SELECT least(SALARY, 7000) FROM employees;
SELECT least(SALARY, 7000) AS salary_atmost_7k FROM employees;
-- greatest()
SELECT greatest(SALARY, 7000) FROM employees;
SELECT greatest(SALARY, 7000) AS salary_atleast_7k FROM employees;
-- NULL
SELECT SALARY FROM employees WHERE SALARY=NULL;
SELECT SALARY AS null_salaries FROM employees WHERE SALARY=NULL;

-- LIKE
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE 's%'; # searches  for starting with 's'
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%a'; # searches  for ending with 'a'
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%a%'; # searches  for containing  'a'
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '_a%'; # searches  where second character is 'a'

--  CASE statement
SELECT FIRST_NAME, LAST_NAME, SALARY,
CASE
	WHEN SALARY<=6000 THEN SALARY*.10
    WHEN SALARY<=10000 THEN SALARY*.20
    WHEN SALARY<=20000 THEN SALARY*.30
    ELSE SALARY*.5
END AS bonus
FROM employees;

-- Problem / challange
-- write a query to show bonus of employees who are working in a particular dept
-- if the employee is working in marketing dept and earns less than 6000, then add bonus of 5%
-- if the employee is working in hr department and have salary less than 5000 than add bonus of 6%
-- if the employee is working in IT dept, and earns more than 10,000 then add bonus of 10%
-- 
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM employees employees WHERE DEPARTMENT_ID IN (20, 40, 60);
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY, 
CASE
	WHEN SALARY<=6000 AND DEPARTMENT_ID=20 THEN SALARY*0.05 # marketing dept
    WHEN SALARY<=5000 AND DEPARTMENT_ID=40 THEN SALARY*0.06 # HR dept
    WHEN SALARY>=10000 AND DEPARTMENT_ID=60 THEN SALARY*0.5 # IT dept
END AS bonus
FROM employees WHERE DEPARTMENT_ID IN (20, 40, 60);
# WHERE DEPARTMENT_ID IN (20, 40, 60)
-- 
select first_name,last_name,salary,
case
when salary <=6000 and department_id = 20 then salary*.05
when salary <=5000 and department_id = 40 then salary*.06
when salary >=10000 and department_id = 60 then salary*.10
end as bonus
from employees;

SELECT FIRST_NAME, LAST_NAME, SALARY, 
CASE
	WHEN DEPARTMENT_ID=60 AND SALARY>10000 THEN SALARY*0.50
    WHEN DEPARTMENT_ID=20 AND SALARY<6000 THEN SALARY*0.050
    WHEN DEPARTMENT_ID=40 AND SALARY<5000 THEN SALARY*0.060
    ELSE 1
END AS bonus
FROM employees WHERE DEPARTMENT_ID IN (20, 40, 60);
-- problem / challange
-- write a query for student table considering that equal students have scored marks
--  below 8 then fail
-- below 16 in lab then
-- in lab between 35-40 then score is very good

-- LIMIT
SELECT * FROM employees LIMIT 10;
-- OFFSET
SELECT * FROM employees LIMIT 2 OFFSET 10;
-- distinct
SELECT distinct(FIRST_NAME) FROM employees;
-- ORDER BY
SELECT SALARY FROM employees ORDER BY SALARY;
SELECT SALARY FROM employees ORDER BY SALARY DESC;

