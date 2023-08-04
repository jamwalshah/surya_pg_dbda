-- 2023 Apr 15

-- 1. Write a SQL query to find the number of employees hired in
-- each year.
SELECT * FROM employees;
SELECT year(HIRE_DATE) AS hire_year, count(year(HIRE_DATE)) FROM employees GROUP BY year(HIRE_DATE);

-- 2. Write a SQL query to find the number of employees in each
-- department.
SELECT DEPARTMENT_ID, count(EMPLOYEE_ID) AS emp_count FROM employees GROUP BY DEPARTMENT_ID;
SELECT DEPARTMENT_ID, count(DEPARTMENT_ID) AS emp_count FROM employees GROUP BY DEPARTMENT_ID;

-- 3. Write a SQL query to find the department with the highest
-- total salary.
SELECT * FROM employees WHERE DEPARTMENT_ID=20;
SELECT DEPARTMENT_ID, SUM(SALARY) AS dept_cost FROM employees GROUP BY DEPARTMENT_ID;
SELECT DEPARTMENT_ID, SUM(SALARY) AS highest_dept_cost FROM employees GROUP BY DEPARTMENT_ID ORDER BY dept_cost DESC LIMIT 1;
SELECT DEPARTMENT_ID, max(SUM(SALARY)) AS highest_dept_cost FROM employees GROUP BY DEPARTMENT_ID;

-- 4. Write a query to list the number of jobs available in the
-- employees table.
SELECT * FROM employees;
SELECT JOB_ID, count(JOB_ID) FROM employees GROUP BY JOB_ID;

-- 5. Write a query to get the total salaries payable to employees.
SELECT * FROM employees;
SELECT DEPARTMENT_ID, JOB_ID, sum(SALARY) FROM employees GROUP BY DEPARTMENT_ID, JOB_ID;

-- 6. Write a query to get the minimum salary from the employees
-- table.
SELECT * FROM employees;
SELECT DEPARTMENT_ID, min(SALARY) FROM employees GROUP BY DEPARTMENT_ID;

-- 7. Write a query to get the maximum salary of an employee working as
-- a Programmer. 
SELECT * FROM employees;
SELECT JOB_ID, max(SALARY) FROM employees GROUP BY JOB_ID HAVING JOB_ID='IT_PROG';

-- 8. Write a query to get the average salary and number of employees
-- working the department 90. 
SELECT * FROM employees;
SELECT DEPARTMENT_ID, count(EMPLOYEE_ID) emp_count, avg(SALARY) avg_sal FROM employees GROUP BY  DEPARTMENT_ID HAVING DEPARTMENT_ID=90;

-- 9. Write a query to get the highest, lowest, sum, and average salary
-- of all employees. 
SELECT * FROM employees;
SELECT max(SALARY) max_sal, min(SALARY) min_sal, sum(SALARY) sum_sal, avg(SALARY) avg_sal FROM employees;
SELECT max(SALARY) max_sal, min(SALARY) min_sal, sum(SALARY) sum_sal, avg(SALARY) avg_sal FROM employees group by NULL;

-- 10. Write a query to get the number of employees with the same job
SELECT * FROM employees;
SELECT JOB_ID, count(JOB_ID) FROM employees GROUP BY JOB_ID;

-- 11. Write a query to get the difference between the highest and
-- lowest salaries. 
SELECT max(SALARY), min(SALARY) FROM employees;
SELECT max(SALARY), min(SALARY) FROM employees GROUP BY NULL;
SELECT max(SALARY), min(SALARY), max(SALARY)-min(SALARY) diff_max_min_sal FROM employees GROUP BY NULL;

-- 12. Write a query to find the manager ID and the salary of the
-- lowest-paid employee for that manager. 
SELECT * FROM employees;
SELECT MANAGER_ID, min(SALARY) FROM employees GROUP BY MANAGER_ID;

-- 13. Write a query to get the department ID and the total salary
-- payable in each department.
SELECT * FROM employees;
SELECT DEPARTMENT_ID, sum(SALARY) FROM employees GROUP BY DEPARTMENT_ID;

-- 14. Write a query to get the average salary for each job ID 
-- excluding programmer. 
SELECT * FROM employees;
SELECT JOB_ID, avg(SALARY) FROM employees GROUP BY JOB_ID;
SELECT JOB_ID, avg(SALARY) FROM employees GROUP BY JOB_ID HAVING JOB_ID NOT LIKE '%PROG%';

-- 15. Write a query to get the total salary, maximum, minimum, 
-- average salary of employees (job ID wise), for department ID 90 only. 
SELECT * FROM employees;
SELECT JOB_ID, sum(SALARY) total_sal, max(SALARY) max_sal, min(SALARY) min_sal, avg(SALARY) avg_sal FROM employees GROUP BY JOB_ID;
SELECT JOB_ID, sum(SALARY) total_sal, max(SALARY) max_sal, min(SALARY) min_sal, avg(SALARY) avg_sal FROM employees GROUP BY JOB_ID HAVING DEPARTMENT_ID=90;

-- 16. Write a query to get the job ID and maximum salary of the 
-- employees where maximum salary is greater than or equal to $4000.
SELECT * FROM employees;
SELECT JOB_ID, max(SALARY) FROM employees GROUP BY JOB_ID HAVING max(SALARY)>=4000;

-- 17. Write a query to get the average salary for all departments 
-- employing more than 10 employees. 
SELECT * FROM employees;
SELECT DEPARTMENT_ID, count(EMPLOYEE_ID) FROM employees GROUP BY DEPARTMENT_ID;
SELECT DEPARTMENT_ID, count(EMPLOYEE_ID), avg(SALARY) FROM employees GROUP BY DEPARTMENT_ID HAVING count(EMPLOYEE_ID)>10;
