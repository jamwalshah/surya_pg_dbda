-- 2023 Apr 14

-- 1) Display the total number of records in the Emp table?
SELECT count(*) AS num_of_records FROM employees;

-- 2) Display emp table with salary descending order?
SELECT * FROM employees ORDER BY SALARY DESC;

-- 3) Display all the records in emp table order by ascending deptno, descending salary?
-- SELECT * FROM employees GROUP BY DEPARTMENT_ID ORDER BY SALARY DESC; # does not work, should be w.r.t. aggregate funtion
SELECT * FROM employees;
SELECT DEPARTMENT_ID FROM employees GROUP BY DEPARTMENT_ID; # subquery
SELECT * FROM employees WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM employees GROUP BY DEPARTMENT_ID) ORDER BY SALARY DESC;

-- 4) Display all employees with how many years they have been servicing in the company?
/*Date diff 
Arithmetic operators :-
Select hire_date + 1 from employees limit 1;
Select hire_date + interval 1 month from employees limit 1;
Select hire_date - interval 1 year from employees limit 1;
Function :- 
datediff() : return the number of days between two days
*/
SELECT * FROM employees;
SELECT DATE(HIRE_DATE+1) FROM employees LIMIT 1;
SELECT HIRE_DATE+ INTERVAL 1 MONTH FROM employees LIMIT 1;
SELECT datediff(CURDATE(), DATE(HIRE_DATE))/365.2425 FROM employees LIMIT 1;
SELECT ROUND(datediff(CURDATE(), DATE(HIRE_DATE))/365.2425) FROM employees LIMIT 1;

-- 5) Add 3 months with hiredate in the EMP table and display the result?
SELECT * FROM EMPLOYEES;
SELECT *, HIRE_DATE+INTERVAL 3 MONTH AS 'hire_date+3M' FROM EMPLOYEES;

-- 6) Find the date, 15 days after today’s date.
SELECT curdate();
SELECT curdate()+INTERVAL 15 DAY;

-- 7) Write a query to display the current date?
SELECT curdate();

-- 8) Display a distinct job from the emp table?
SELECT * FROM employees;
SELECT distinct(JOB_ID) FROM employees;

-- 9) Display all the records in the emp table where the employee was 
-- hired after 28-SEP-81 and before 03-DEC-81?
SELECT * FROM employees;
-- NO record between 28-SEP-81 and before 03-DEC-81
SELECT * FROM employees WHERE HIRE_DATE>'1981-09-28' AND HIRE_DATE<'1981-12-03';
-- NO record between 28-SEP-81 and before 03-DEC-81, so trying with 28-SEP-87 and before 03-DEC-87
SELECT * FROM employees WHERE HIRE_DATE>'1987-09-28' AND HIRE_DATE<'1987-12-03';

-- 10) Write a query that displays the employee’s names with the first 
-- letter capitalized and all other letters lowercase for all employees whose name starts with J, A, or M
SELECT * FROM employees;
SELECT * FROM employees WHERE FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'M%' ;
SELECT *, concat(UPPER(LEFT(FIRST_NAME, 1)),LOWER(RIGHT(FIRST_NAME, length(FIRST_NAME)-1))) AS title_fname 
FROM employees WHERE FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'M%' ;

-- 11) Display all jobs that are in department 10. Include the location of the department in the output.
SELECT * FROM employees;
SELECT * FROM departments;
SELECT EMPLOYEE_ID, DEPARTMENT_ID, JOB_ID FROM employees;
SELECT EMPLOYEE_ID, DEPARTMENT_ID, e.JOB_ID, j.JOB_TITLE FROM employees e JOIN jobs j ON e.JOB_ID=j.JOB_ID WHERE DEPARTMENT_ID=10;

-- 12) Write a query to display the employee name, department name of all employees who earn a commission
SELECT concat(e.FIRST_NAME," ",e.LAST_NAME) AS ename, d.DEPARTMENT_NAME AS 'dept_name' FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID WHERE e.COMMISSION_PCT!=0;

-- 13) Display the empno, ename, sal, and salary increased by 15%.
SELECT EMPLOYEE_ID AS empno, concat(FIRST_NAME," ",LAST_NAME) AS ename, SALARY as sal, SALARY+SALARY*.15 AS 'inc_salary_15%' FROM employees;

-- 14) Display ename, sal, grade. Use emp, salgrade table
-- ----------------------------
-- 			Salary > 15000 Grade A
-- 			Salary > 10000 and < 15000 Grade B
-- 			Salary between  5000 abd 10000  Grade C
-- 			Salary < 5000 Grade D
-- ----------------------------			
-- 			And Sort on the basis of Grades
-- ----------------------------
SELECT concat(FIRST_NAME," ",LAST_NAME) AS ename, SALARY AS sal, 
CASE
	WHEN SALARY>=15000 THEN "Grade A"
    WHEN SALARY>=10000 AND SALARY<15000 THEN "Grade B"
    WHEN SALARY>=5000 AND SALARY<10000 THEN "Grade C"
    WHEN SALARY<5000 THEN "Grade D"
END AS grade
FROM employees;
