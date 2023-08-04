###################
-- Database- Day02
###################
create user user12apr@localhost identified by 'mysql';
create user seconduser@localhost identified by 'mysql', thirduser@localhost identified by 'mysql';
select user from mysql.user;



###################
-- Database- Day03a
###################
-- List users in your database

select user from mysql.user;

show grants for seconduser@localhost;
-- this '*.*' means that user seconduser
-- can only login to the databaseserver
-- and have no other privilege

-- --------------------------------
-- password change in user
-- this can be done using 3 commands (update, alter, set)
-- 1. using SET
#set PASSWORD for 'seconduser'@'localhost'=PASSWORD('abc');		# for older version
set PASSWORD for 'seconduser'@'localhost'='abc';

-- 2. using ALTERz
alter user 'thirduser'@'localhost' identified by 'abc';

-- 3. using Update
use mysql;
#update user set password=password('xyz') where user='seconduser' and host='localhost';		#for older version
#update user set seconduser=password('xyz') where user='seconduser' and host='localhost';
#update user set authentication_string=password('xyz') where user='seconduser' and host='localhost';	#shows error
#flush privileges;

-- renamea a user
rename user 'seconduser'@'localhost' to 'dusrauser'@'localhost';
select user from mysql.user;

-- drop user (to remove user from database)
drop user 'dusrauser'@'localhost';
select user from mysql.user;

-- Grant (giving permisison to the user)
grant all privileges on *.* to thirduser@localhost;
show grants for thirduser@localhost;

-- grant only select privilege
grant select on *.* to thirduser@localhost;
show grants for thirduser@localhost;



###################
-- Database- Day03b
###################
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
#SHOW DATABASES LIKE %hr%; #works in different version

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

# WHERE clause
# Relational Operators
# Greater than
SELECT * FROM employees WHERE SALARY>8000; # prints employees with salary more than 8000
# Less than
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
-- avg
SELECT avg(SALARY) FROM employees;
SELECT avg(SALARY) AS average FROM employees;
-- sum
SELECT sum(SALARY) FROM employees;
SELECT sum(SALARY) AS sum FROM employees;
-- count
SELECT count(*) FROM employees;
SELECT count(*) AS employee_count FROM employees;
-- min, max
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
-- if the employee is working in IT dept, and earns more than 10,000 then add bonus of 50%
-- 
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM employees employees WHERE DEPARTMENT_ID IN (20, 40, 60);
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY , 
CASE
	WHEN SALARY>10000 THEN SALARY*0.5
    WHEN SALARY<6000 THEN SALARY*0.05
    WHEN SALARY<5000 THEN SALARY*0.06
    ELSE 1
END AS bonus
FROM employees WHERE DEPARTMENT_ID IN (20, 40, 60);
-- 
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




###################
-- Database- Day05
###################
use hr;
SELECT * FROM employees;
SELECT count(EMPLOYEE_ID) count_emp FROM employees ORDER BY EMPLOYEE_ID;
SELECT FIRST_NAME, SALARY+1000 increment FROM employees ORDER BY increment;

SELECT SALARY, EMPLOYEE_ID FROM employees ORDER BY SALARY ASC, EMPLOYEE_ID DESC;
#RENAME table_name TO new_table_name
#ALTER TABLE old_table RENAME new_table
#ALTER table_name ADD  column_name data_type;
#UPDATE table_name SET column = VALUE WHERE condition

SELECT * FROM employees WHERE EMPLOYEE_ID=110;
UPDATE employees SET SALARY = 100000 WHERE EMPLOYEE_ID=110;
SELECT * FROM employees WHERE EMPLOYEE_ID=110;

ALTER TABLE employees ADD age int(60);
DESC employees;
SHOW TABLES;
SELECT * FROM regions;
SELECT * FROM employees;

#ALTER TABLE table_name MODIFY column_name new_data_type;
ALTER TABLE employees MODIFY age int(70);
DESC employees;

-- 
CREATE DATABASE check1;
USE check1;
--
-- Table structure for table `regions`
CREATE TABLE IF NOT EXISTS `regions` (
  `REGION_ID` decimal(5,0) NOT NULL,
  `REGION_NAME` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`REGION_ID`),
  UNIQUE KEY `sss` (`REGION_NAME`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `regions`
INSERT INTO `regions` (`REGION_ID`, `REGION_NAME`) VALUES
('1', 'Europe\r'),
('2', 'Americas\r'),
('3', 'Asia\r'),
('4', 'Middle East and Africa\r');

SELECT * FROM regions;
-- delete
DELETE FROM regions WHERE REGION_ID=4;# deletes specific record as per condition in WHERE
SELECT * FROM regions;
-- truncate
TRUNCATE TABLE regions; # leaves emplty table
SELECT * FROM regions;
-- drop
DROP TABLE regions; # removes entire table object
SELECT * FROM regions;

USE hr;
#SELECT SALARY FROM employees WHERE SALARY >avg(SALARY); # throws error as aggregate functions not allowed with grouping

SELECT count(*) FROM employees WHERE DEPARTMENT_ID=80;
SELECT DEPARTMENT_ID, count(*) num_of_employees
FROM employees GROUP BY DEPARTMENT_ID;
SELECT DEPARTMENT_ID, count(*) num_of_employees
FROM employees WHERE DEPARTMENT_ID=50 GROUP BY DEPARTMENT_ID;

-- probelm / challenge find the number of employees hired in each year
SELECT * FROM employees;
SELECT YEAR(HIRE_DATE) FROM employees;
SELECT YEAR(HIRE_DATE), count(*) emp_count FROM employees GROUP BY year(HIRE_DATE);

-- write a query to find total salary paid to each department
-- and order the resujlt in descending order of total salary paid
SELECT * FROM employees;
SELECT SALARY , DEPARTMENT_ID FROM employees WHERE DEPARTMENT_ID=30;
SELECT DEPARTMENT_ID, sum(SALARY) total_sal_to_dept
FROM employees GROUP BY DEPARTMENT_ID ORDER BY total_sal_to_dept DESC;

-- find the department with highest total salary being paid
SELECT max(SALARY) max_total_sal_to_dept
FROM employees GROUP BY DEPARTMENT_ID ORDER BY max_total_sal_to_dept DESC;

-- HAVING
SELECT DEPARTMENT_ID, sum(SALARY) total_sal_to_dept 
FROM employees GROUP BY DEPARTMENT_ID HAVING sum(SALARY)<6000;

-- write a query to get average salary to all the depts who have employees more tham 10
SELECT DEPARTMENT_ID, avg(SALARY) avg_salary, count(*) emp_count
FROM employees GROUP BY DEPARTMENT_ID HAVING count(DEPARTMENT_ID)>10;

SELECT JOB_ID, sum(SALARY) FROM employee GROUP BY JOB_ID, DEPARTMENT_ID;

-- JOIN
SELECT * FROM employees;
SELECT * FROM departments;

-- Equi Join
SELECT EMPLOYEE_ID, e.DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees e, departments d	# using alias for table
WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID;

SELECT EMPLOYEE_ID, employees.DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees , departments	# using actal table names
WHERE employees.DEPARTMENT_ID=departments.DEPARTMENT_ID;

-- Inequi Join
SELECT * FROM employees;
SELECT * FROM departments;

-- using JOIN & ON keyword, with table alias
SELECT FIRST_NAME, LAST_NAME, EMPLOYEE_ID, e.DEPARTMENT_ID
FROM employees e JOIN departments d
ON e.EMPLOYEE_ID=d.DEPARTMENT_ID AND d.DEPARTMENT_NAME!='hr';
-- using JOIN & ON keyword, without table alias
SELECT FIRST_NAME, LAST_NAME, EMPLOYEE_ID, employees.DEPARTMENT_ID
FROM employees JOIN departments 
ON employees.EMPLOYEE_ID=departments.DEPARTMENT_ID AND departments.DEPARTMENT_NAME!='hr';

SELECT FIRST_NAME, LAST_NAME, e.DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees e, departments d # using WHERE & AND keyword
WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID
AND d.DEPARTMENT_ID_NAME!='IT';

SELECT FIRST_NAME, LAST_NAME, EMPLOYEE_ID, e.DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees e, departments d	# using alias for table
WHERE e.DEPARTMENT_ID!=d.DEPARTMENT_ID;

SELECT FIRST_NAME, LAST_NAME, EMPLOYEE_ID, employees.DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees , departments	# using actal table names
WHERE employees.DEPARTMENT_ID=departments.DEPARTMENT_ID;


-- waq to find who has scored higher than 80 marks

-- Cartesian Join
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_NAME
FROM employees, departments;

-- LEFT JOIN
SELECT e.DEPARTMENT_ID, DEPARTMENT_NAME # cannot show proper left join due to schema of tables employees, departments
FROM employees e LEFT JOIN departments d
ON e.DEPARTMENT_ID=d.DEPARTMENT_ID;

SELECT s.NAME, c.COURSE_ID
FROM student s LEFT JOIN course c
ON c.ROLL_NO=s.ROLL_NO;

-- RIGHT JOIN
SELECT e.DEPARTMENT_ID, DEPARTMENT_NAME
FROM employees e RIGHT JOIN departments d
ON e.DEPARTMENT_ID=d.DEPARTMENT_ID;

SELECT s.NAME, c.COURSE_ID
FROM student s RIGHT JOIN course c
ON c.ROLL_NO=s.ROLL_NO;


-- WAQ to find the addresses(location_id, street_address, city, state_province, country_name) of all the departments
SELECT * FROM countries;
SELECT * FROM locations;
SELECT * FROM departments;
SELECT DEPARTMENT_ID, DEPARTMENT_NAME 
FROM departments;




###################
-- Database- Day06
###################

use week2;
SELECT * FROM student;
SELECT * FROM course_detail;

-- cartesion Join
SELECT s.STUDENT_ID,  c.COURSE_ID
FROM student s, course_detail c;

-- INNER JOIN / EQUI JOIN / NATURAL JOIN
-- using JOIN keyword
SELECT s.STUDENT_ID, c.COURSE_ID
FROM student s JOIN course_detail c
ON s.STUDENT_ID=c.STUDENT_ID; 
-- using INNER JOIN keyword
SELECT s.STUDENT_ID, c.COURSE_ID
FROM student s INNER JOIN course_detail c
ON s.STUDENT_ID=c.STUDENT_ID;
-- using WHERE keyword
SELECT s.STUDENT_ID, c.COURSE_ID
FROM student s, course_detail c
WHERE s.STUDENT_ID=c.STUDENT_ID;

-- LEFT JOIN
SELECT s.STUDENT_ID, c.COURSE_ID
FROM student s LEFT JOIN course_detail c
ON s.student_ID=c.STUDENT_ID;

-- RIGHT JOIN
SELECT s.STUDENT_ID, c.COURSE_ID
FROM student s RIGHT JOIN course_detail c
ON s.student_ID=c.STUDENT_ID;

-- SELF JOIN
SELECT s1.STUDENT_ID, s2.COURSE_ID
FROM student s1 JOIN student s2
ON s1.COURSE_ID=s2.COURSE_ID;

-- OUTER JOIN
-- cannot implement FULL JOIN in MySQL
-- SELECT s.COURSE_ID, c.COURSE_ID
-- FROM student s FULL JOIN course_detail c
-- ON s.COURSE_ID=c.COURSE_ID;
-- FULL JOIN implemented in MySQL using UNION of LEFT JOIN & RIGHT JOIN
SELECT s.STUDENT_ID, c.COURSE_ID
FROM student s LEFT JOIN course_detail c
ON s.student_ID=c.STUDENT_ID
UNION
SELECT s.STUDENT_ID, c.COURSE_ID
FROM student s RIGHT JOIN course_detail c
ON s.student_ID=c.STUDENT_ID;

SELECT * FROM student;
SELECT * FROM course_detail;


USE hr;
SELECT * FROM departments;
SELECT * FROM employees;
-- find number of employees in each department
SELECT count(EMPLOYEE_ID), DEPARTMENT_ID FROM employees
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM departments) GROUP  BY DEPARTMENT_ID ;
SELECT DEPARTMENT_ID FROM departments;

-- find the average salary of employees in IT dept
SELECT avg(SALARY) avg_sal_of_IT FROM employees WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_NAME='IT');
SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_NAME='IT';

-- find the total no of employees working in finance dept
SELECT count(EMPLOYEE_ID) FROM employees WHERE DEPARTMENT_ID=(SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_NAME='Finance');
SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_NAME='Finance';

-- find the names of employees, who work in same dept of Steven king
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID
FROM employees 
WHERE DEPARTMENT_ID=(
SELECT DEPARTMENT_ID 
FROM employees 
WHERE FIRST_NAME='Steven' AND LAST_NAME='King');
SELECT DEPARTMENT_ID FROM employees WHERE FIRST_NAME='Steven' AND LAST_NAME='King';

-- find the dept where no employees earn more than 4000
SELECT DEPARTMENT_NAME, DEPARTMENT_ID
FROM departments
WHERE DEPARTMENT_ID IN (
SELECT DEPARTMENT_ID
FROM employees
WHERE SALARY<4000);
SELECT SALARY, DEPARTMENT_ID FROM employees WHERE SALARY<4000;

-- interview challange/problem
--  find out the employee with second highest salary
SELECT * FROM employees WHERE SALARY =(SELECT SALARY FROM employees ORDER BY SALARY DESC LIMIT 1 OFFSET 1);
SELECT SALARY FROM employees ORDER BY SALARY DESC LIMIT 1 OFFSET 1;

--  find out the employee with third highest salary
SELECT * FROM employees WHERE SALARY =(SELECT SALARY FROM employees ORDER BY SALARY DESC LIMIT 1 OFFSET 2);
SELECT SALARY FROM employees ORDER BY SALARY DESC LIMIT 1 OFFSET 1;


-- Views
# create view
CREATE VIEW sal_emp AS SELECT FIRST_NAME, SALARY, DEPARTMENT_ID FROM employees WHERE SALARY>10000;
# select view
SELECT * FROM sal_emp;

CREATE VIEW no_emp_dept AS
SELECT DEPARTMENT_ID, count(*) FROM employees GROUP BY DEPARTMENT_ID;
SELECT * FROM no_emp_dept;

CREATE VIEW join_view1 AS
SELECT e.FIRST_NAME, d.DEPARTMENT_NAME, e.SALARY
FROM employees e JOIN departments d
ON e.DEPARTMENT_ID=d.DEPARTMENT_ID;
SELECT * FROM join_view1;

CREATE VIEW sub_examp AS
SELECT max(SALARY) FROM employees
WHERE SALARY<(SELECT max(SALARY) FROM employees);
SELECT * FROM sub_examp;

SELECT * FROM sal_emp; 
UPDATE sal_emp SET FIRST_NAME="John" WHERE SALARY=24000 AND DEPARTMENT_ID=90 AND FIRST_NAME="Steven"; # updates name of Steven to John
SELECT * FROM employees; # shows updated name as John

SELECT * FROM employees; # show record of John in table employees
DELETE FROM sal_emp WHERE SALARY=24000 AND DEPARTMENT_ID=90 AND FIRST_NAME='John'; # deletes record of John with salary 24000, dept id 90
SELECT * FROM employees; # does not show record of John

SELECT * FROM sal_emp; #  shows view sal_emp
DROP VIEW sal_emp; # drops view sal_emp
SELECT * FROM sal_emp; # throws error as sal_emp does not exist anymore



###################
-- Database- Day07
###################

USE hr;
CREATE VIEW sal_emp AS SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID FROM employees
WHERE SALARY>10000;
SELECT * FROM sal_emp;

ALTER VIEW sal_emp AS 
SELECT FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE FROM employees WHERE SALARY>5000;

SELECT * FROM sal_emp;
SELECT * FROM employees;

-- hashed index
select * from employees where salary=10000;
select first_name from employees_B_Single where salary=10000;

EXPLAIN select * from employees where salary=10000;
EXPLAIN select first_name from employees_B_Single where salary=10000;




-- hashed index
select * from employees where salary=10000;
select first_name from employees_B_Single where salary=10000;

select first_name, department_id salary from employees_B_Multiple where salary>10000 AND department_id=90;
select first_name, department_id salary from employees where salary>10000 AND department_id=90;

explain select first_name, department_id salary from employees_B_Multiple where salary>10000 AND department_id=90;
explain select first_name, department_id salary from employees where salary>10000 AND department_id=90;

-- create index
CREATE INDEX index_manager_id ON employees(MANAGER_ID);
-- show index
SHOW INDEX FROM employees;
SHOW INDEX FROM employees_B_Single;
SHOW INDEX FROM employees_B_Multiple;
SHOW INDEX FROM employees_Hash;

select first_name, manager_id from employees_Hash where manager_id=100;
explain select first_name, manager_id from employees_Hash where manager_id=100;




###################
-- Database- Day08
###################

CREATE DATABASE student_management;
USE student_management;

CREATE TABLE students(
S_ID INT PRIMARY KEY,
S_NAME VARCHAR(10),
DOB DATE,
MARKS INT,
COURSE_ID INT,
FOREIGN KEY(COURSE_ID) REFERENCES courses(COURSE_ID)
);
CREATE TABLE courses(
COURSE_ID INT PRIMARY KEY,
COURSE_NAME VARCHAR(10)
);
CREATE TABLE students(
S_ID INT PRIMARY KEY,
S_NAME VARCHAR(10),
AGE INT,
EMAIL VARCHAR(20) UNIQUE,
DOB DATE,
MARKS INT,
GENDER CHAR(1),
COURSE_ID INT,
FOREIGN KEY(COURSE_ID) REFERENCES courses(COURSE_ID),
CHECK(AGE>18),
CHECK(GENDER IN ('M', 'F', 'O'))
);

DESC students;
EXPLAIN students;
DESC courses;
SHOW TABLE STATUS ;
SHOW CREATE TABLE students;

INSERT INTO students(S_ID, S_NAME, AGE, EMAIL, DOB, MARKS, GENDER, COURSE_ID) VALUES
-- (101, 'abc', 2, 'abc@gmail.com', '2020-05-12', 25, 'b', 10) -- age 2 <18
-- (101, 'abc', 20, 'abc@gmail.com', '2020-05-12', 25, 'b', 10) -- gender 'b' NOT IN ('M', 'F', 'O')
-- (101, 'abc', 20, 'abc@gmail.com', '2020-05-12', 25, 'M', 10) -- need to add in refrenced column first

(101, 'abc', 20, 'abc@gmail.com', '2020-05-12', 25, 'M', 12)
-- (101, 'abc', 20, 'abc@gmail.com', '2020-05-12', 25, 'M', 10)
;

INSERT INTO courses(course_id, course_name) VALUES
-- (100, "course_name")
(12, "cs")
;

SELECT * FROM students;
SELECT * FROM courses;

DROP  TABLE students, courses;




-- -------------------------------------------------------
USE hr;
SHOW TABLES;

SELECT * FROM employees;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS 'full name', SALARY FROM employees WHERE SALARY>10000;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS 'full name', SALARY FROM employees WHERE SALARY=17000 AND DEPARTMENT_ID=90;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS 'full name', SALARY FROM employees WHERE MANAGER_ID=100 OR DEPARTMENT_ID=100;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS 'full name', SALARY FROM employees WHERE SALARY BETWEEN 10000 AND 50000;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS 'full name', HIRE_DATE FROM employees WHERE HIRE_DATE BETWEEN '1987-04-18' AND '1987-06-23';
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS 'full name', DEPARTMENT_ID FROM employees WHERE DEPARTMENT_ID IN (90, 60, 30, 100);
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS 'full name', DEPARTMENT_ID FROM employees WHERE DEPARTMENT_ID=ANY(90, 60, 30, 100);

SELECT * FROM employees;
DELETE FROM employees WHERE EMPLOYEE_ID=101;
TRUNCATE table employees;
SELECT * FROM employees;
DROP TABLE employees;
SHOW TABLES;

-- CREATE TABLE employees;
-- INSERT INTO employees;

SELECT * FROM employees;
UPDATE employees SET SALARY=40000 WHERE EMPLOYEE_ID=100;
UPDATE employees SET SALARY=40000, COMMISSION_PCT=.4 WHERE EMPLOYEE_ID=101;
SELECT * FROM employees;
ALTER TABLE employees RENAME COLUMN PHONE_NUMBER TO CONTACT_NUMBER;
SELECT * FROM employees;
ALTER TABLE employees DROP COLUMN EMAIL;
ALTER TABLE employees MODIFY COLUMN SALARY INT;
ALTER TABLE employees ADD COLUMN AGE INT AFTER HIRE_DATE;
ALTER TABLE employees ADD CONSTRAINT fsk_manager FOREIGN KEY(MANAGER_ID) REFERENCES DEPARTMENT_ID(MANAGER_ID);
ALTER TABLE employees DROP CONSTRAINT fsk_manager;
ALTER TABLE employees ADD CONSTRAINT age_check CHECK(AGE>18);
DESC employees;







SELECT now();
SELECT curdate();


