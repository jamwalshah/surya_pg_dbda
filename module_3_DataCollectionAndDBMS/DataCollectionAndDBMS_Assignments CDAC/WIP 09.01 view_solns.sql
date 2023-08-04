-- 2023 Apr 18
-- ---------------------------------------------------------------------
USE humans;
-- create table empl
-- Q1. Create a view to fetch the employees data 
-- EmployeeId, EmployeeName, EmployeeSalary, EmployeeManager, EmployeeDepartment
USE humans;
CREATE VIEW emp_data123 AS SELECT EMPLOYEE_ID AS EmployeeID, FIRST_NAME AS Employee_Fname, LAST_NAME AS Employee_Lname, SALARY AS EmployeeSalary, MANAGER_ID AS EmployeeManager, DEPARTMENT_ID AS EmployeeDepartment FROM employees;
SELECT * FROM emp_data123;

CREATE VIEW emp_data AS 
SELECT EMPLOYEE_ID AS EmployeeID, 
concat(FIRST_NAME,LAST_NAME) AS EmployeeName,
SALARY AS EmployeeSalary, 
MANAGER_ID AS EmployeeManager, 
DEPARTMENT_ID AS EmployeeDepartment 
FROM employees;
SELECT * FROM emp_data;

-- Q2. Create a view to fetch all the employees data working on jobs with 
-- minimum salary > 2000 and maximum salary < 5000;
SELECT * FROM employees WHERE SALARY>2000 AND SALARY<5000;
CREATE  VIEW emps_with_sal_2k_5k AS SELECT * FROM employees WHERE SALARY>2000 AND SALARY<5000;
SELECT * FROM emps_with_sal_2k_5k;

-- Q3. Create a view to fetch employee data 
-- EMPLOYEEID,EMPLOYEENAME,EMPLOYEEDEPARTMENT,EMPLOYEESALARY,EMPLOYEECOUNTRY,EMPLOYEELOCATION, EMPLOYEEREGION.
SELECT * FROM employees ; 
SELECT * FROM departments ; 
SELECT * FROM countries ; 
SELECT * FROM locations ; 
SELECT * FROM regions ;
-- 
SELECT e.EMPLOYEE_ID, concat(e.FIRST_NAME," ",e.LAST_NAME) empName, d.DEPARTMENT_NAME, e.SALARY, c.COUNTRY_NAME, d.LOCATION_ID, r.REGION_NAME
FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID
JOIN countries c ON l.COUNTRY_ID=c.COUNTRY_ID JOIN regions r ON c.REGION_ID=r.REGION_ID;
-- INNER JOIN method, will lead to incorrect values
DROP VIEW empDeptCtryLoctnRgn;
CREATE VIEW empDeptCtryLoctnRgn AS 
SELECT e.EMPLOYEE_ID, concat(e.FIRST_NAME," ",e.LAST_NAME) empName, d.DEPARTMENT_NAME, e.SALARY, c.COUNTRY_NAME, d.LOCATION_ID, r.REGION_NAME
FROM employees e JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID 
JOIN countries c ON l.COUNTRY_ID=c.COUNTRY_ID JOIN regions r ON c.REGION_ID=r.REGION_ID ;
SELECT * FROM empDeptCtryLoctnRgn;
-- avoid inner join as it will fetch only common values, 
-- but try LEFT JOIN to fetch values with LEFT perspective to get correct values
DROP VIEW empDeptCtryLoctnRgnLJ;
CREATE VIEW empDeptCtryLoctnRgnLJ AS 
SELECT e.EMPLOYEE_ID, concat(e.FIRST_NAME," ",e.LAST_NAME) empName, d.DEPARTMENT_NAME, e.SALARY, c.COUNTRY_NAME, d.LOCATION_ID, r.REGION_NAME
FROM employees e 
LEFT JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID 
LEFT JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID 
LEFT JOIN countries c ON l.COUNTRY_ID=c.COUNTRY_ID 
LEFT JOIN regions r ON c.REGION_ID=r.REGION_ID ;
SELECT * FROM empDeptCtryLoctnRgn ORDER BY EMPLOYEE_ID ;

-- Q4. CREATE A VIEW FOR Q3 AND DISPLAY ONLY THOSE EMPLOYEES WHOSE DEPARTMENTID = 30 AND SALARY < 5000;
CREATE VIEW empDeptCtryLoctnRgnLjDeptEq30SalLt5k AS 
SELECT e.EMPLOYEE_ID, concat(e.FIRST_NAME," ",e.LAST_NAME) empName, d.DEPARTMENT_NAME, e.SALARY, c.COUNTRY_NAME, d.LOCATION_ID, r.REGION_NAME
FROM employees e 
LEFT JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID 
LEFT JOIN locations l ON d.LOCATION_ID = l.LOCATION_ID 
LEFT JOIN countries c ON l.COUNTRY_ID=c.COUNTRY_ID 
LEFT JOIN regions r ON c.REGION_ID=r.REGION_ID 
WHERE d.DEPARTMENT_ID=30 AND e.SALARY<5000 ;
SELECT * FROM empDeptCtryLoctnRgnLjDeptEq30SalLt5k ORDER BY EMPLOYEE_ID ;

-- Q5. CREATE A VIEW TO FETCH ALL EMPLOYEES DATA WITH THERE APPRAISED SALARY FOR THE CURRENT YEAR.
-- EG : CURRENT SALARY = 3000
-- COMM : 300
-- APPRAISED SALARY RULE : 
-- 		PEOPLE GETTING SALARY 2000 - 10000 :: 10%
-- 		PEOPLE GETTING SALARY 10001 -15000 :: 8%
-- 		PEOPLE GETTING SALARY 15000 - 20000 :: 6%
-- 		PEOPLE GETTING SALARY > 20000 :: 5%
SELECT * FROM employees ;
SELECT EMPLOYEE_ID, concat(FIRST_NAME," ",LAST_NAME) empName, SALARY,
CASE
	WHEN SALARY>2000 AND SALARY<=10000 THEN SALARY+SALARY*.10
    WHEN SALARY>10000 AND SALARY<=15000 THEN SALARY+SALARY*.08
    WHEN SALARY>15000 AND SALARY<=20000 THEN SALARY+SALARY*.06
    WHEN SALARY>20000 THEN SALARY+SALARY*.05
END AS 'appraisedSalary', COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM employees ;
CREATE VIEW appraisal AS SELECT EMPLOYEE_ID, concat(FIRST_NAME," ",LAST_NAME) empName, SALARY,
CASE
	WHEN SALARY>2000 AND SALARY<=10000 THEN SALARY+SALARY*.10
    WHEN SALARY>10000 AND SALARY<=15000 THEN SALARY+SALARY*.08
    WHEN SALARY>15000 AND SALARY<=20000 THEN SALARY+SALARY*.06
    WHEN SALARY>20000 THEN SALARY+SALARY*.05
END AS 'appraisedSalary', COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM employees ;
SELECT * FROM appraisal ; 
SHOW TABLES;
		
-- Q6. CREATE A VIEW ON THE EMPLOYEES TABLE WITH EMPNO , EMPNAME, EMPSALARY
-- 	1. UPDATE THE SALARY OF EMPLOYEE ID = 105;
-- 	2. DELETE THE ROW OF THE EMPLOYEE ID = 106;
-- 	3. UPDATE THE EMPLOYEE DEPARTMET ID OF THE EMPLOYEEID = 108
-- 	OBSERVE THE PARENT TABLE EMPLOYEES
SELECT * FROM employees;
SELECT EMPLOYEE_ID empname, SALARY empsalary FROM employees;
CREATE VIEW empid_sal AS SELECT EMPLOYEE_ID empno, SALARY empsalary FROM employees;
SELECT * FROM empid_sal;
-- DROP VIEW empid_sal;
-- update salary of empno 105
SELECT * FROM empid_sal WHERE empno=105;	-- check salary in view before updating
SELECT EMPLOYEE_ID, SALARY FROM employees WHERE EMPLOYEE_ID=105;	-- check salary in table before updating
UPDATE empid_sal SET empsalary=4900 WHERE empno=105;
SELECT * FROM empid_sal WHERE empno=105;	-- check salary in view after updating
SELECT EMPLOYEE_ID, SALARY FROM employees WHERE EMPLOYEE_ID=105;	-- check salary in table after updating [updated in table too]
-- DELETE employee 106
SELECT * FROM empid_sal WHERE empno BETWEEN 104 AND 109;	-- check salary in view before updating
SELECT EMPLOYEE_ID, SALARY FROM employees WHERE EMPLOYEE_ID BETWEEN 104 AND 109;	-- check salary in table before updating
DELETE FROM empid_sal WHERE empno=106;
SELECT * FROM empid_sal WHERE empno BETWEEN 104 AND 109;	-- check salary in view before updating
SELECT EMPLOYEE_ID, SALARY FROM employees WHERE EMPLOYEE_ID BETWEEN 104 AND 109;	-- check salary in table before updating, [deleted from table too]
-- update dept of employee 108
SELECT * FROM empid_sal WHERE empno BETWEEN 104 AND 109;	-- check salary in view before updating
SELECT EMPLOYEE_ID, SALARY FROM employees WHERE EMPLOYEE_ID BETWEEN 104 AND 109;	-- check salary in table before updating
UPDATE empid_sal SET DEPARTMENT_ID=90 WHERE empno=108;
SELECT * FROM departments;
SELECT * FROM employees WHERE EMPLOYEE_ID BETWEEN 104 AND 109;

-- Q7. CREATE A VIEW ON EMPLOYEES AND DEPARTMENT WITH DEPARTMENTID COMPARISON
-- 	1. TRY TO DO UPDATE 

		

