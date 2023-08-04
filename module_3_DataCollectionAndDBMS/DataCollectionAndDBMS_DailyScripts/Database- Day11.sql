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




###################
-- Database- Day09
###################

--  user 1 - root
-- 
CREATE USER jolly@localhost IDENTIFIED BY 'mysql';
GRANT ALL PRIVILEGES ON week2.student TO 'jolly'@'localhost';
FLUSH PRIVILEGES;
 
SELECT * FROM users;

USE week2;
SHOW tables;
SELECT * FROM student;
UPDATE student SET student_name='Johnny' WHERE student_id= 1;
-- USE hr;
-- START TRANSACTION;
SELECT * FROM student;
DESC student;
ALTER TABLE student ADD PRIMARY KEY(student_id);
SET AUTOCOMMIT=OFF;
-- --------------------------------------------------------------------
-- 
-- user2 -jolly
-- 
SET AUTOCOMMIT=OFF;
USE week2;
-- START TRANSACTION;
BEGIN;
SELECT * FROM student;

COMMIT;
-- --------------------------------------------------------------------

BEGIN;
SELECT * FROM student;
UPDATE student SET student_name='Rano' WHERE student_id= 1;
SELECT * FROM student;
COMMIT;
SELECT * FROM student;
-- --------------------------------------------------------------------
BEGIN;
SELECT * FROM student;
UPDATE student SET student_name='Rani' WHERE student_id= 1;
SELECT * FROM student;
SAVEPOINT a;
SELECT * FROM student;
DELETE FROM student WHERE student_id=1;
SELECT * FROM student;
ROLLBACK TO a;
SELECT * FROM student;
COMMIT;
SELECT * FROM student;
-- SHOW TRIGGERS FROM hr like 'employees';
-- --------------------------------------------------------------------
BEGIN;
SAVEPOINT a;
SELECT * FROM student;
UPDATE student SET student_name='Derek' WHERE student_id=3;
SELECT * FROM student;
SAVEPOINT b;
ROLLBACK TO a;
SELECT * FROM student;
ROLLBACK TO b; # throws error, as when we rollbacked to 'a', savepoint 'b' also got deleted
SELECT * FROM student;
-- --------------------------------------------------------------------



USE hr;
SELECT * FROM employees;
SELECT MANAGER_ID FROM employees GROUP BY MANAGER_ID;
SELECT avg(SALARY), DEPARTMENT_ID FROM employees GROUP BY DEPARTMENT_ID;
SELECT @@sql_mode;

-- find the number of employees with same salary in each department
SELECT SALARY, DEPARTMENT_ID, count(SALARY) FROM employees GROUP BY SALARY, DEPARTMENT_ID;

-- show the number of employees in each department who earns more than the average salary of their department
SELECT DEPARTMENT_ID, avg(SALARY), count(*) FROM employees GROUP BY DEPARTMENT_ID;
SELECT DEPARTMENT_ID, count(*) FROM employees WHERE SALARY>(SELECt avg(SALARY) FROM employees) GROUP BY DEPARTMENT_ID ;
SELECT DEPARTMENT_ID, count(EMPLOYEE_ID) FROM employees WHERE SALARY> (SELECT avg(SALARY) FROM employees) GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, count(EMPLOYEE_ID) FROM employees GROUP BY 
CASE 
	WHEN DEPARTMENT_ID=10 THEN 10
	ELSE  0
END
;

-- stored function
/*
CREATE FUNCTION function_name(arg0, arg1, arg2)
RETURNS return_type
BEGIN
	function_body
END;

*/
USE hr;
DELIMITER \\
CREATE FUNCTION get_emp_name(emp_id INT)
RETURNS VARCHAR(50)
BEGIN
	DECLARE emp_name VARCHAR(50);
    
    SELECT FIRST_NAME INTO emp_name FROM employees 
    WHERE EMPLOYEE_ID=emp_id;
    
    RETURN emp_name;
END;
\\
DELIMITER ;
-- SET GLOBAL log_bin_trust_function_creators=1;
-- SELECT get_emp_name_name(110);







###################
-- Database- Day09
###################

-- SET GLOBAL log_bin_trust_function_creators=1;

-- find total salary of all employees who reports to a specific manager
-- total salary - sum(SALARY) -- RETURN TYPE (INT/FLOAT)
-- MANAGER_ID INT

DROP FUNCTION GET_TOTAL_SALARY_MANAGER;

DELIMITER //
CREATE FUNCTION GET_TOTAL_SALARY_MANAGER(M_ID INT)
RETURNS DECIMAL(10,2)
-- DETERMINISTIC
BEGIN
	DECLARE TOT_SAL DECIMAL(10,2);
    SELECT SUM(SALARY) INTO TOT_SAL FROM employees
    WHERE MANAGER_ID=M_ID;
    RETURN TOT_SAL;
    
END;
//
DELIMITER ;



-- return SALARY of employees whose firstname & lastname passed in args matches
DROP FUNCTION fetch_salary;
DELIMITER $$
CREATE FUNCTION fetch_salary(fname VARCHAR(15), lname VARCHAR(15))
RETURNS FLOAT
BEGIN
	DECLARE sal FLOAT;
    SELECT SALARY INTO sal FROM employees
    WHERE FIRST_NAME=fname AND LAST_NAME=lname;
    RETURN sal;
END;
$$
DELIMITER ;

SELECT * FROM employees;

-- retrieve dept_name with highest average salary
-- departments(DEPARTMENT_NAME)
-- employees(SALARY)
-- JOIN, DEPARTMENT_ID
-- VARCHAR, DEPARTMENT_NAME
DROP  FUNCTION high_avg_sal;
DELIMITER $$
CREATE FUNCTION high_avg_sal()
RETURNS VARCHAR(30)
BEGIN
	DECLARE dept_name VARCHAR(30);
    SELECT d.DEPARTMENT_NAME  INTO dept_name FROM employees e 
    JOIN departments d 
    ON e.DEPARTMENT_ID=d.DEPARTMENT_ID 
    GROUP BY d.DEPARTMENT_NAME 
    ORDER BY avg(SALARY) 
    DESC LIMIT 1;
    RETURN dept_name;
END;
$$
DELIMITER ;
SELECT high_avg_sal();

SELECT e.DEPARTMENT_ID, avg(SALARY) FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID GROUP BY e.DEPARTMENT_ID; 
SELECT e.DEPARTMENT_ID, avg(SALARY) FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID GROUP BY e.DEPARTMENT_ID ORDER BY avg(SALARY) DESC ;
SELECT e.DEPARTMENT_ID, avg(SALARY) FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID GROUP BY e.DEPARTMENT_ID ORDER BY avg(SALARY) DESC LIMIT 1; 
SELECT e.DEPARTMENT_ID, avg(SALARY) FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID GROUP BY e.DEPARTMENT_ID ORDER BY avg(SALARY) DESC LIMIT 1;
SELECT d.DEPARTMENT_NSELECT d.DEPARTMENT_NAME FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID GROUP BY d.DEPARTMENT_NAME ORDER BY avg(SALARY) DESC LIMIT 1;AME, avg(SALARY) FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID GROUP BY d.DEPARTMENT_NAME ORDER BY avg(SALARY) DESC LIMIT 1;


-- return list of employees whose SALARY is greater than or equal to given amount
DROP FUNCTION geteq_sal_emps;

DELIMITER $$
CREATE FUNCTION geteq_sal_emps(inp_sal INT)
RETURNS VARCHAR(1000)
BEGIN
	DECLARE emp_nam VARCHAR(1000);
--     SELECT concat(FIRST_NAME,"",LAST_NAME) INTO emp_nam FROM employees
--     WHERE SALARY>=inp_sal;
    SELECT group_concat(concat(FIRST_NAME,"",LAST_NAME)SEPARATOR ',') INTO emp_nam FROM employees
    WHERE SALARY>=inp_sal;
    RETURN emp_nam;
END;
$$
DELIMITER ;

SELECT geteq_sal_emps(10000);


-- find the employees with their experience
DROP FUNCTION get_exp;
DELIMITER $$
CREATE FUNCTION get_exp(emp_id INT) RETURNS INT
BEGIN
	DECLARE exp INT;
    SELECT YEAR(NOW())-YEAR(HIRE_DATE) INTO exp FROM employees WHERE
    EMPLOYEE_ID=emp_id;
    RETURN exp;
END;
$$
DELIMTER ;
SELECT get_exp(101);

-- alternate solution
DROP FUNCTION get_emp_exp;
DELIMITER $$
CREATE FUNCTION get_emp_exp(emp_id INT) RETURNS VARCHAR(10000)
DETERMINISTIC
BEGIN
	DECLARE years_of_exp VARCHAR(10000);
    SELECT GROUP_CONCAT(CONCAT(DATEDIFF(END_DATE, START_DATE)/365)SEPARATOR ',')
    INTO years_of_exp
    FROM job_history j
    JOIN employees e 
    ON e.EMPLOYEE_ID=j.EMPLOYEE_ID 
    WHERE e.employee_ID=emp_id;
    IF years_of_exp IS NOT NULL THEN
		RETURN CONCAT(emp_id," has ",years_of_exp," years of experience");
	ELSE
		RETURN CONCAT("Sorry, employee with ",emp_id," is not in out DB.");
	END IF;
END;
$$
DELIMITER ;

SELECT get_emp_exp(102);
SELECT get_emp_exp(103);
SELECT * FROM job_history;
-- 
-- 
SELECT YEAR(NOW())-YEAR('2022-04-21');
SELECT YEAR(NOW());


-- Alter function
-- to create function return_hello
DELIMITER $$
CREATE FUNCTION return_hello(naam VARCHAR(15)) RETURNS VARCHAR(25)
BEGIN
    RETURN CONCAT("Hello ",naam);
END;
$$
DELIMITER ;
-- 
SELECT return_hello("Amit");
-- to ALTER UPDATE function return_hello
DELIMITER $$
UPDATE FUNCTION return_hello(naam VARCHAR(15)) RETURNS VARCHAR(25)
BEGIN
    RETURN CONCAT("Hello ",naam," Good Morning!");
END;
$$
DELIMITER ;
-- call to updated function return_hello 
SELECT return_hello("Amit");


-- 
-- Stored Procedure
DROP PROCEDURE GET_ALL_DATA; -- to drop a procedure
-- Procedure without args
DELIMITER $$
CREATE PROCEDURE GET_ALL_DATA() -- to create a procedure
BEGIN
	SELECT * FROM employees;
END;
$$
DELIMITER ;
-- 
CALL GET_ALL_DATA; -- call to procedure

--  ---------------------------------------
--  ---------------------------------------
--  procedure with IN args only
DELIMITER $$
CREATE PROCEDURE GET_EMP_NAME_WITH_ID(IN EMP_ID INT)
BEGIN
	SELECT CONCAT(FIRST_NAME," ",LAST_NAME) FROM employees WHERE  EMPLOYEE_ID=EMP_ID;
END;
$$
DELIMITER ;
--  ---------------------------------------
CALL GET_EMP_NAME_WITH_ID(102);
--  ---------------------------------------
--  ---------------------------------------
-- procedure with IN args only
DELIMITER $$
CREATE PROCEDURE GET_UPDATE_SAL(IN EMP_ID INT, IN SAL FLOAT(10, 3))
BEGIN
	UPDATE employees SET SALARY=sal WHERE  EMPLOYEE_ID=EMP_ID;
END;
$$
DELIMITER ;
-- 
CALL GET_UPDATE_SAL(102, 300000);
-- 
SELECT * FROM employees WHERE EMPLOYEE_ID=102;
--  ---------------------------------------
-- procedure with OUT args
DROP PROCEDURE GET_DEPT;
-- 
DELIMITER //
CREATE PROCEDURE GET_DEPT(INOUT EMP_ID INT, OUT F_NAME VARCHAR(50), OUT D_ID INT)
BEGIN
		SELECT FIRST_NAME, DEPARTMENT_ID INTO F_NAME, D_ID
        FROM employees 
        WHERE EMPLOYEE_ID=EMP_ID 
        LIMIT 1;
END;
//
DELIMITER ;
--
SET @EMP_ID=103;
CALL GET_DEPT(@EMP_ID, @F_NAME, @D_ID) ;
SELECT @F_NAME, @D_ID ;
--  ---------------------------------------
--  ---------------------------------------
-- procedure with INOUT & IN args
DROP PROCEDURE GET_UPDATE_SAL_USING_INOUT;
--
DELIMITER $$
CREATE PROCEDURE GET_UPDATE_SAL_USING_INOUT(INOUT EMP_ID INT, IN SAL FLOAT)
BEGIN
	UPDATE employees SET SALARY=SAL WHERE EMP_ID=EMPLOYEE_ID;
END;
$$
DELIMITER ;
-- 
--  ---------------------------------------
-- CALL GET_UPDATE_SAL_USING_INOUT(101, 3000); -- unable to read args directly, so put those values in variables
SET @EMPLOYEE_ID=101;
SET @SAL=3000;
SELECT @EMPLOYEE_ID, @SAL ;
CALL GET_UPDATE_SAL_USING_INOUT(@EMPLOYEE_ID, @SAL) ;
SELECT @EMPLOYEE_ID, @SAL ;
SELECT * FROM employees WHERE EMPLOYEE_ID=101;
-- 


--  ---------------------------------------
--  ---------------------------------------
-- to get first_name, Last_name of employee through employee ID
DROP PROCEDURE GET_emp_details ;
-- procedure with IN & OUT args
DELIMITER //
CREATE PROCEDURE GET_emp_details(IN EMP_ID INT, OUT naam VARCHAR(50))
BEGIN
	SELECT concat(FIRST_NAME," ",LAST_NAME) INTO naam FROM employees WHERE EMP_ID=EMPLOYEE_ID;
END;
//
DELIMITER ;
-- CALL GET_emp_details(101); 
SET @EMPLOYEE_ID=101;
SET @NAAM="";
CALL GET_emp_details(@EMPLOYEE_ID, @NAAM);
SELECT @NAAM;
--  ---------------------------------------
--  ---------------------------------------


-- example from salalry_history table
DELIMITER //
CREATE PROCEDURE insert_into(INOUT EMPLOYEE_ID INT, IN FIRST_NAME VARCHAR(30), IN new_salary DECIMAL(10,2))
BEGIN
	INSERT INTO salary_history(FIRST_NAME, new_salary) VALUES(FIRST_NAME, new_salary) ;
    SET EMPLOYEE_ID=LAST_INSER_ID();
END;
//
DELIMITER ;
-- 
SET @EMPLOYEE_ID=0;
CALL insert_into(@EMPLOYEE_ID, 'John Doe', 5600.7) ;
SELECT @EMPLOYEE_ID;
SELECT * FROM salary_history;
--






-- Trigger
-- --------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER BEFORE_INSERT_INTO_EMPLOYEE
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.SALARY<0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Cannot insert negative Salary";
    END IF;
END;
$$
DELIMITER ;

INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, CONTACT_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(10000, "Steven", "Kingg", '515.123.4567', '1987-06-17', 'AD_PRES', '-24000', '0.00', '0', '90');

INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, CONTACT_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(10001, "Steven", "Kingg", '515.123.4567', '1987-06-17', 'AD_PRES', '4000', '0.00', '0', '90');

SELECT * FROM employees;
show tables;






###################
-- Database- Day11
###################
USE HR;
SHOW TABLES;

-- --------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER BEFORE_INSERT_INTO_EMPLOYEE
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	IF NEW.SALARY<0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="Cannot insert negative Salary";
    END IF;
END;
$$
DELIMITER ;

INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, CONTACT_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(10000, "Steven", "Kingg", '515.123.4567', '1987-06-17', 'AD_PRES', '-24000', '0.00', '0', '90');

INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, CONTACT_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(10001, "Steven", "Kingg", '515.123.4567', '1987-06-17', 'AD_PRES', '4000', '0.00', '0', '90');

-- --------------------------------------------------------------------
-- BEFORE INSERT Trigger
DROP TRIGGER to_check_emp_id;
DELIMITER //
CREATE TRIGGER to_check_emp_id
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
-- 	IF EXISTS(NEW.EMPLOYEE_ID) THEN
-- 	IF OLD.EMPLOYEE_ID=NEW.EMPLOYEE_ID THEN
	IF EXISTS(SELECT EMPLOYEE_ID FROM employees WHERE EMPLOYEE_ID=NEW.EMPLOYEE_ID) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT="employee_id already exists" ;
	END IF ;
END ;
//
DELIMITER ;
INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, CONTACT_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(10001, "Steven", "Kingg", '515.123.4567', '1987-06-17', 'AD_PRES', '74000', '0.00', '0', '90');
-- --------------------------------------------------------------------
-- AFTER INSERT Trigger
-- vineeta's code modded
SELECT * FROM salary_history;
SELECT * FROM employees;
DROP TRIGGER after_insert_salary;
DELIMITER $$
CREATE TRIGGER after_insert_salary
AFTER INSERT ON employees
FOR EACH ROW
-- WHEN (NEW.SALARY<>NEW.SALARY)
BEGIN
/*    IF NOT EXISTS (SELECT * FROM salary_history WHERE employee_id=NEW.EMPLOYEE_ID AND old_salary=NEW.SALARY) THEN
		INSERT INTO salary_history (employee_id, first_name, old_salary, new_salary, department_id) VALUES
		(NEW.employee_id, NEW.first_name, OLD.SALARY, NEW.SALARY, OLD.department_id);
	END IF; */
/*    IF NOT EXISTS(SELECT employee_id FROM salary_history WHERE employee_id=NEW.EMPLOYEE_ID AND new_salary=NEW.SALARY) 
    THEN
		INSERT INTO salary_history(employee_id, first_name, old_salary, new_salary, department_id) VALUES
--         (NEW.EMPLOYEE_ID, NEW.FIRST_NAME, OLD.SALARY, NEW.SALARY, OLD.DEPARTMENT_ID);
        (NEW.EMPLOYEE_ID, NEW.FIRST_NAME, NEW.SALARY, NEW.SALARY, DEPARTMENT_ID);
	END IF ; */
    
END ;
$$
DELIMITER ;
-- 
-- INSERT INTO employee(employee_id, name, SALARY) VALUES();
INSERT INTO employees (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, CONTACT_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(10001, "Steven", "Kingg", '515.123.4567', '1987-06-17', 'AD_PRES', '74000', '0.00', '0', '90');
-- 
UPDATE employees SET SALARY=74000 WHERE EMPLOYEE_ID=10001;
-- --------------------------------------------------------------------
-- surya's code
SELECT * FROM salary_history;
DROP TRIGGER after_insert_salary;
-- 
DELIMITER $$
CREATE TRIGGER after_insert_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
	IF(NEW.SALARY<>OLD.SALARY) THEN
        INSERT INTO salary_history (employee_id, first_name, old_salary, new_salary, department_id) VALUES
		(NEW.EMPLOYEE_ID, NEW.FIRST_NAME, OLD.SALARY, NEW.SALARY, OLD.DEPARTMENT_ID);
	END IF;
END ;
$$
DELIMITER ;
-- 
UPDATE employees SET SALARY=74000 WHERE EMPLOYEE_ID=10001;

-- ------------------------------------------------------------------------
-- Deepak Patel's soln 
/* DELIMITER $$
create trigger SAL_HISTORY_UPDATE
AFTER update on employees for each row
begin
	if exists (select * from salary_history where employee_id = NEW.EMPLOYEE_ID)
    then
		UPDATE salary_history SET old_salary=OLD.SALARY, new_salary=NEW.SALARY where employee_id = NEW.EMPLOYEE_ID;
	else
			INSERT INTO salary_history (employee_id, first_name, old_salary, new_salary, department_id)
		VALUES(old.employee_id, old.first_name, old.salary, new.salary, old.department_id);
	end if;
end;
$$
DELIMITER ; */
-- ------------------------------------------------------------------------
-- vineeta's 2nd trial

-- ------------------------------------------------------------------------
-- suresh's trial
SELECT * FROM salary_history;
DROP TRIGGER after_insert_salary;
-- 
DELIMITER \\
CREATE TRIGGER after_insert_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
	IF(NEW.SALARY!=OLD.SALARY) 
    THEN
		INSERT INTO salary_history(employee_id, first_name, old_salary, new_salary, department_id) VALUES
        (NEW.EMPLOYEE_ID, NEW.FIRST_NAME, OLD.SALARY, NEW.SALARY, OLD.DEPARTMENT_ID);
	END IF;
END;
\\
DELIMITER ;
use hr;
SHOW CREATE TABLE countries;
SHOW CREATE TABLE employees;
