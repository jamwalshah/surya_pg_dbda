-- 2023 Apr 14

use hr;
SELECT * FROM employees ;
SELECT * FROM departments ;

-- 1. From the following table return complete information about the employees. 
SELECT * FROM employees ;

-- 2. From the following table, write a  query to find the salaries of
-- all employees. Return salary.   
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID FROM employees;

-- 3. From the following table, write a  query to find the unique
-- designations of the employees. Return job name.   
SELECT * FROM departments;	# Main-Query
SELECT distinct(DEPARTMENT_ID) FROM employees;	# Sub-Query

SELECT DEPARTMENT_NAME FROM departments 
WHERE DEPARTMENT_ID=ANY(SELECT distinct(DEPARTMENT_ID) FROM employees);

-- 4. From the following table, write a  query to list the employees’
-- names, increase their salary by 15%, and express the number of Dollars.   
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS emp_name,
SALARY, concat("$", SALARY+SALARY*.15) AS salary_after_increment
FROM employees;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS emp_name,
SALARY, format(SALARY+SALARY*.15, 'C', 'en-us') AS salary_after_increment
FROM employees;

-- 5. From the following table, write a  query to list the employee's
-- name and job name as a format of "Employee & Job".   
SELECT *  FROM employees;
SELECT * FROM jobs;
SELECT distinct(JOB_ID), JOB_TITLE FROM jobs;

SELECT concat(FIRST_NAME, " ",LAST_NAME, ",    ", JOB_ID) AS "Employee & Job"
FROM employees ;

-- [IGN]6. Write a query to produce the output of employees as follows.  
#SELECT * FROM employees;
-- 7. From the following table, write a  query to find those employees
-- with a hire date in the format like February 22, 1991. Return
-- employee ID, employee name,
SELECT * FROM employees;
SELECT date_format(HIRE_DATE, '%y-%m-%d') from employees;
SELECT date_format(HIRE_DATE, '%Y-%M-%d') from employees;
SELECT EMPLOYEE_ID, concat(FIRST_NAME, " ", LAST_NAME) AS emp_name, 
DATE_FORMAT(HIRE_DATE, '%M %d, %Y') AS 'hire date' 
FROM employees;

-- 8. From the following table, write a 
-- query to count the number of characters except the spaces for each
-- employee name. Return employee name length.  
SELECT EMPLOYEE_ID, concat(FIRST_NAME, LAST_NAME) AS emp_name FROM employees;
SELECT EMPLOYEE_ID, FIRST_NAME AS emp_name, length(FIRST_NAME) FROM employees;
SELECT EMPLOYEE_ID, concat(FIRST_NAME, ' ', LAST_NAME) AS emp_name, length(concat(FIRST_NAME, LAST_NAME)) AS char_count FROM employees;

-- 9. From the following table, write a  query to find the employee ID,
-- salary, and commission of all the employees.  
SELECT * FROM employees;
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT AS 'commission percentage'FROM employees;

-- 10. From the following table, write a  query to find the unique
-- department with jobs. Return department ID, Job name.   
SELECT * FROM employees;
SELECT * FROM departments;
SELECT DEPARTMENT_ID, e.JOB_ID, j.JOB_TITLE AS job_name FROM employees e JOIN  jobs j ON e.JOB_ID=j.JOB_ID ORDER BY DEPARTMENT_ID;
SELECT distinct(DEPARTMENT_ID), e.JOB_ID, j.JOB_TITLE AS job_name FROM employees e JOIN  jobs j ON e.JOB_ID=j.JOB_ID ORDER BY DEPARTMENT_ID;

-- 11. From the following table, write a  query to find those employees
-- who do not belong to the department 2001. Return complete
-- information about the employees
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM employees WHERE DEPARTMENT_ID<>2001 ORDER BY DEPARTMENT_ID;

-- 12. From the following table, write a  query to find those employees
-- who joined before 1991. Return complete information about
-- the employees.   
SELECT *, YEAR(HIRE_DATE) FROM employees;
SELECT EMPLOYEE_ID, YEAR(HIRE_DATE) AS joining_year FROM employees WHERE YEAR(HIRE_DATE)<1991;

-- 13. From the following table, write a  query to calculate the average
-- salary of employees who work as analysts. Return average salary.  
SHOW TABLES;
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM jobs WHERE JOB_TITLE='Programmer';
SELECT JOB_ID FROM jobs WHERE JOB_TITLE='Programmer';
SELECT avg(SALARY) AS avg_salary FROM employees;
SELECT avg(SALARY) AS avg_salary_for_Programmer FROM employees WHERE JOB_ID=(SELECT JOB_ID FROM jobs WHERE JOB_TITLE='Programmer');

-- 14. From the following table, write a  query to find the details of
-- the employee ‘BLAZE’. 
SELECT * FROM employees;
SELECT * FROM employees WHERE FIRST_NAME='BLOOM' OR LAST_NAME='BLOOM';
SELECT * FROM employees WHERE concat(FIRST_NAME, LAST_NAME) LIKE '%BLOOM%';

-- 15. From the following table, write a  query to identify
-- employees whose commissions exceed their salaries. Return complete
-- information about the employees.  
SELECT * FROM employees;
SELECT *, SALARY*COMMISSION_PCT AS commission, SALARY+SALARY*COMMISSION_PCT AS net_salary FROM employees WHERE SALARY+SALARY*COMMISSION_PCT>SALARY;

-- 16. From the following table, write a  query to identify those
-- employees whose salaries exceed 3000 after receiving a 25% salary
-- increase. Return complete information about the employees.   
SELECT * FROM employees;
SELECT *, SALARY+SALARY*.25 AS salary_after_25pc FROM employees WHERE SALARY+SALARY*.25 > 3000;

-- 17. From the following table, write a  query to find the names of
-- the employees whose length is six. Return employee name.  
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS emp_name FROM employees;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS emp_name FROM employees WHERE length(concat(FIRST_NAME, " ", LAST_NAME))=6;

-- 18. From the following table, write a  query to find out which
-- employees joined in the month of January. Return complete information
-- about the employees.   
SELECT * FROM job_history;
SELECT *, date_format(HIRE_DATE, '%m') FROM employees;
SELECT * FROM employees WHERE date_format(HIRE_DATE, '%m')=01 ;
SELECT e.*, jh.START_DATE FROM employees e JOIN job_history jh ON e.EMPLOYEE_ID=jh.EMPLOYEE_ID;
SELECT e.*, jh.START_DATE FROM employees e JOIN job_history jh ON e.EMPLOYEE_ID=jh.EMPLOYEE_ID WHERE date_format(jh.START_DATE, '%m')=1;

-- 19. From the following table, write a  query to separate the names of
-- employees and their managers by the string 'works for'. 
SHOW tables;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
-- using INNER JOIN, can print only manager ID
SELECT concat(e.FIRST_NAME, ' ' , e.LAST_NAME, ' works for manager ', d.MANAGER_ID) AS emp_manager FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID;
-- using SLEF JOIN, can print manager name too
SELECT concat(e1.FIRST_NAME, ' ' , e1.LAST_NAME, ' works for manager ', e1.MANAGER_ID, " ", e2.FIRST_NAME, " ", e2.LAST_NAME) AS emp_manager FROM employees e1 JOIN employees e2 ON e1.MANAGER_ID=e2.EMPLOYEE_ID;
SELECT EMPLOYEE_ID FROM employees em WHERE em.EMPLOYEE_ID=e.MANAGER_ID;
SELECT concat(e.FIRST_NAME, ' ', e.LAST_NAME, " works for MANAGER ", e.MANAGER_ID) AS emp_manager FROM employees e WHERE e.MANAGER_ID=(SELECT EMPLOYEE_ID FROM employees em WHERE em.EMPLOYEE_ID=e.MANAGER_ID);



--  20. From the following table, write a  query to find those employees
-- whose designation is ‘CLERK’. Return complete information about
-- the employees.  
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT JOB_ID, JOB_TITLE FROM jobs WHERE JOB_TITLE LIKE "%CLERK%";
SELECT e.*, j.JOB_TITLE FROM employees e JOIN jobs j ON e.JOB_ID=j.JOB_ID WHERE  j.JOB_TITLE LIKE "%CLERK%";

-- 21. From the following table, write a  query to identify employees with
-- more than 27 years of experience. Return complete information
-- about the employees.   
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT *, YEAR(current_date())-YEAR(HIRE_DATE) AS exp FROM employees;
-- does not show NULL row, based on START_DATE & END_DATE from job_history, none has exp more than even 9yrs
SELECT e.*, YEAR(jh.END_DATE)-YEAR(jh.START_DATE) AS exp, jh.START_DATE, jh.END_DATE FROM employees e JOIN job_history jh ON e.EMPLOYEE_ID=jh.EMPLOYEE_ID WHERE YEAR(jh.END_DATE)-YEAR(jh.START_DATE)>27;
-- based on current_date & HIRE_DATE from employees, shows even retired emploees
SELECT *, YEAR(current_date())-YEAR(HIRE_DATE) AS experience FROM employees WHERE YEAR(current_date())-YEAR(HIRE_DATE)>27;
-- shows retired employees with value in START_DATE & END_DATE, but working employees have START_DATE & END_DATE AS NULL, which are required
SELECT e.*, YEAR(current_date())-YEAR(e.HIRE_DATE) AS exp, jh.START_DATE, jh.END_DATE FROM employees e LEFT JOIN job_history jh ON e.EMPLOYEE_ID=jh.EMPLOYEE_ID WHERE YEAR(current_date())-YEAR(e.HIRE_DATE)>27;
-- testing subquery for below command
SELECT EMPLOYEE_ID FROM job_history;
-- throws error as EMPLOYEE_ID FROM employees is matched multiple times with EMPLOYEE_ID FROM job_history due to inequality
SELECT e.*, YEAR(current_date())-YEAR(e.HIRE_DATE) AS exp, jh.START_DATE, jh.END_DATE FROM employees e, job_history jh WHERE e.EMPLOYEE_ID NOT IN (SELECT EMPLOYEE_ID FROM job_history);

-- 22. From the following table, write a  query to find those employees
-- whose salaries are less than 3500. Return complete information about
-- the employees.  
SELECT * FROM employees;
SELECT * FROM employees WHERE SALARY<3500;

-- 23. From the following table, write a  query to find the employee whose
-- designation is ‘ANALYST’. Return employee name, job name and salary.  
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM jobs WHERE JOB_TITLE='Programmer';
SELECT JOB_ID FROM jobs WHERE JOB_TITLE='Programmer';
SELECT * FROM employees WHERE JOB_ID=(SELECT JOB_ID FROM jobs WHERE JOB_TITLE='Programmer');

-- 24.From the following table, write a  query to identify those employees
-- who joined the company in 1991. Return complete information about
-- the employees.   
SELECT * FROM employees;
-- no employee hired in 1991, searching with 1993
SELECT * FROM employees WHERE YEAR(HIRE_DATE)=1991; 
-- no employee joined in  1991, searching with 1993
SELECT * FROM job_history;
-- shows employees joining in 1993
SELECT * FROM job_history WHERE YEAR(START_DATE)=1993;
SELECT EMPLOYEE_ID FROM job_history WHERE YEAR(START_DATE)=1993;
-- shows employees joined in 1993
SELECT * FROM employees WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM job_history WHERE YEAR(START_DATE)=1993);

-- 25. From the following table, write a  query to find those employees 
-- who joined before 1st April 1991. Return employee ID, employee name,
-- hire date and salary.   
SELECT * FROM employees;
SELECT * FROM job_history;
-- to print employees who started before 1999-04-01
SELECT e.*, jh.START_DATE FROM employees e JOIN job_history jh ON e.EMPLOYEE_ID=jh.EMPLOYEE_ID WHERE YEAR(jh.START_DATE)<'1991-04-01';

-- 26. From the following table, write a  query to identify the employees
-- who do not report to a manager. Return employee name, job name.  
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM departments;
SHOW TABLES;
SELECT e.FIRST_NAME, e.LAST_NAME, j.JOB_TITLE, e.MANAGER_ID AS emp_mgr_id, d.MANAGER_ID AS dept_mgr_id 
FROM employees e JOIN jobs j 
ON e.JOB_ID=j.JOB_ID 
JOIN departments d 
ON e.MANAGER_ID!=d.MANAGER_ID;

-- 27. From the following table, write a  query to find the employees who
-- joined on the 1st of May 1991. Return complete information about
-- the employees.  
SELECT * FROM employees;
SELECT * FROM job_history;
-- no record with employee having start_date as '1991-05-01'
SELECT e.* FROM employees e, job_history jh WHERE e.EMPLOYEE_ID=jh.EMPLOYEE_ID AND jh.START_DATE='1991-05-01';
-- as unable to find records with '1991-05-01', so trying with existing record of '1996-02-17'
SELECT e.* FROM employees e, job_history jh WHERE e.EMPLOYEE_ID=jh.EMPLOYEE_ID AND jh.START_DATE='1996-02-17';

-- 28. From the following table, write a  query to identify the
--  experience of the employees who work under the manager whose ID
-- number is 68319. Return employee ID, employee name, salary, experience.   
SELECT * FROM employees;
-- record where manager ID is 68319 , does not exist
SELECT EMPLOYEE_ID, concat(FIRST_NAME," ",LAST_NAME) AS emp_name, SALARY, YEAR(curdate())-YEAR(HIRE_DATE) AS experience FROM employees WHERE MANAGER_ID=68319;
-- record where manager ID is 68319 , does not exist, so trying with manager ID 149
SELECT EMPLOYEE_ID, concat(FIRST_NAME," ",LAST_NAME) AS emp_name, SALARY, YEAR(curdate())-YEAR(HIRE_DATE) AS experience FROM employees WHERE MANAGER_ID=149;

-- 29. From the following table, write a  query to find out which employees
-- earn more than 100 per day as a salary. Return employee ID, employee name,
-- salary, and experience.  
SELECT * FROM employees;
SELECT EMPLOYEE_ID, concat(FIRST_NAME," ",LAST_NAME) AS emp_name, SALARY, YEAR(curdate())-YEAR(HIRE_DATE) AS experience FROM employees WHERE SALARY/30 > 100;

-- 30. From the following table, write a  query to identify those
-- employees who retired after 31-Dec-99, completing eight years of service.
-- Return employee name.  
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT *, YEAR(END_DATE)-YEAR(START_DATE) AS experience FROM job_history;
-- no record with employee who retired after 1999-12-31
SELECT *, YEAR(END_DATE)-YEAR(START_DATE) AS experience FROM job_history WHERE END_DATE >'1999-12-31';
-- no record with employee who retired after 1999-12-31, so taking up 1998-12-31
-- no record with experience of 8yrs
SELECT *, YEAR(END_DATE)-YEAR(START_DATE) AS experience FROM job_history WHERE END_DATE >'1998-12-31';
-- no record with experience of 8yrs, so taking up exp  of 3 yrs
SELECT *, YEAR(END_DATE)-YEAR(START_DATE) AS experience FROM job_history WHERE END_DATE >'1998-12-31' AND YEAR(END_DATE)-YEAR(START_DATE)>=3;
SELECT EMPLOYEE_ID FROM job_history WHERE END_DATE >'1998-12-31' AND YEAR(END_DATE)-YEAR(START_DATE)>=3;
SELECT * FROM employees WHERE EMPLOYEE_ID=(SELECT EMPLOYEE_ID FROM job_history WHERE END_DATE >'1998-12-31' AND YEAR(END_DATE)-YEAR(START_DATE)>=3);

-- 31. From the following table, write a  query to identify the employees
-- whose salaries are odd. Return complete information about the employees. 
SELECT * FROM employees;
SELECT * FROM employees WHERE SALARY%2=0;
SELECT * FROM employees WHERE SALARY%2!=0;

-- 32. From the following table, write a  query to identify employees whose
-- salaries contain only three digits. Return complete information about
-- the employees.  
SELECT * FROM employees;
SELECT * FROM employees WHERE SALARY>=100 AND SALARY<=999;

-- 33. From the following table, write a  query to find those employees who
-- joined in the month of APRIL. Return complete information about
-- the employees.   
SELECT * FROM employees;
SELECT * FROM job_history;
-- no record  found for april month
SELECT *, date_format(HIRE_DATE, '%m') AS joining_month FROM employees WHERE date_format(HIRE_DATE, '%m')=04;
-- no record  found for april month, so tried for June month
SELECT *, date_format(HIRE_DATE, '%m') AS joining_month FROM employees WHERE date_format(HIRE_DATE, '%m')=06;

-- 34. From the following table, write a  query to find out which employees
-- joined the company before the 19th of the month. Return complete
-- information about the employees.   
SELECT * FROM employees;
SELECT *, date_format(HIRE_DATE, '%d') AS joining_date FROM employees WHERE date_format(HIRE_DATE, '%d')<19;

-- 35. From the following table, write a  query to identify those employees
-- who have been working as a SALESMAN and month portion of the experience
-- is more than 10. Return complete information about the employees. 
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT * FROM employee WHERE JOB_ID='SA_MAN';