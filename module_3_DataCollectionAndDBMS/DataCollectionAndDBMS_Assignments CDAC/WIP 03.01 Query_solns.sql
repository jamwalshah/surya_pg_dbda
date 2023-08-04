-- 2023 Apr 14

-- 01. Calculate the average rating of all salaries, with an alias
-- for the average salary.


-- 02. Retrieve the name and email address of all customers, with
-- an alias for the concatenation of their first and last name:


-- 03. Retrieve the number of  departments, with an alias for
-- the count_of_dept.


-- 04. Write a query to calculate the total revenue generated from
-- sales, and alias the sum as "Total Sales Revenue"


-- 05. Display all the employees whose salary is greater than the
-- average salary of their department. 


-- 06. Display employees where length of employee name is 5


-- 07. Display all employees where employee name start with J and
-- ends with S


-- 08. Display all employees where employee does not belong
-- to 10,20,40 department_id


-- 09. Display all employees where jobs do not belong to
-- the PRESIDENT and MANAGER?


-- 10. Display all three figures salary in emp table


-- 11. Display all records in emp table for employee who does not
-- receive any commission


-- 12. Display all employee names where the first character could be
-- anything, but the second character should be L?


-- 13. Display nth highest and nth lowest salary in emp table?


-- 14. Display all the departments where the department has 3 employees?


-- 15. Display emp name and corresponding subordinates.
-- Use CONNECT BY clause.


-- 16. Display all employee name, sal, dept id,department name
-- from emp, dept table where all departments which have employees
-- as well as department does not have any employees. This query should
-- include non matching rows.


-- 17. Display all employee name, sal, dept id from emp, dept table
-- where all employees which have matching departments as well as
-- employee does not have any departments. This query should
-- include non matching rows.
-- 		Note: In the below query, employees will always have matching
-- records in dept table. Emp, dept table may not be a good example
-- to answer this question.


-- 18. Display all employee name, sal, dept id from emp, dept table
-- where all employees which have matching and non matching department
-- as well as all departments in dept table which has matching and
-- non matching employees. This query should include non matching
-- rows on both the tables. 
-- 		Note: In the below query, employees will always have matching
-- records in the dept table. Emp, dept table may not be a good example
-- to answer this question.


-- 19. Display all ename, empno, dname, loc from emp, dept table
-- without joining two tables


-- 20. Display all the departments where department does not have
-- any employees


-- 21. Display all the departments where department does have at
-- least one employee


-- 22. Display all employees who are not managers?


-- 23. Display ename, deptno from emp table with format of {ename}
-- belongs to {deptno}


-- 24. Display total number of employees hired for 1980,1981,1982. The
-- output should be in one record.


-- 25. Display employee name, dept id from employee table. Also add
-- another column in the same query and it should display ten for dept 10,
-- twenty for dept 20, thirty for dept 30, fourty for dept 40


-- 26. Display all the records in the emp table. The employee name
-- should be lower case. The job first character should be uppercase
-- and the rest of the character in the job field should be lowercase.


-- 27. Display all employees who have joined in the first week 
-- of the month ?


-- 28. Display all employees who have joined in the 49th week of
-- the year?


-- 29. Display empid, deptid, salary, salary difference between current
-- record and previous record in emp table. Deptno should be in
-- descending order.


-- 30. Create table emp1 and copy the emp table for dept id 10 while
-- creating the table


-- 31. Create table emp2 with the same structure of emp table. Do not
-- copy the data


-- 32. Insert new record in emp1 table, Merge the emp1 table on emp table.


-- 33. Display all the records for dept id which belongs to employee name JAMES? 


-- 34. Display all the records in the emp table where salary should be
-- less then or equal to ADAMS salary?


-- 35. Display all employees that were joined before employee WARD joined?


-- 36. Display all subordinates who are working under BLAKE?


-- 37. Display all subordinates(all levels) for employee BLAKE?


-- 38. Display all records in the emp table for the dept id which
-- belongs to KING's Job? 


-- 39. Write a SQL statement to increase the salary of employees under
-- the department 40, 90 and 110 according to the company rules that
-- salary will be increased by 25% for department 40, 15% for department 90
-- and 10% for department 110 and the rest of the departments
-- will remain the same.


-- 40. Display list of employee names of those who have joined in
-- Year 81 as MANAGER?


-- 41. Display who is making the highest commission?


-- 42. Display who is the senior most employee? How many years has
-- been working?


-- 43. Display who is the most experienced and least experienced
-- employee?


-- 44. Display employee name, sal, grade, dept name, loc for
-- each employee.


-- 45. Display all employees whose location is DALLAS?


-- 46. Display ename, job, dname, deptno for each employee by using
-- INLINE view?


-- 47. List employee name, job, sal and department of all employees
-- whose salary is not within the salary grade?


-- 48. Use EMP and EMP1 tables. Query should have only three columns.
-- Display empno,ename,sal from both tables including duplicates. 


-- 49. Display the employees for empno which belongs to job PRESIDENT?


-- 50. Display the total number of records in the Emp table?


-- 51. Display emp table with salary descending order?


-- 52. Display all the records in emp table order by ascending deptno,
-- descending salary?


-- 53. Display all employees with how many years they have been
-- servicing in the company?


-- 54. Select hire_date + 1 from employees limit 1;


-- 55. Select hire_date + interval 1 month from employees limit 1;


-- 56. Select hire_date - interval 1 year from employees limit 1;


-- 57. datediff() : return the number of days between two days


-- 58. Add 3 months with hiredate in the EMP table and display
-- the result?


-- 59. Find the date, 15 days after today’s date.


-- 60. Write a query to display the current date?


-- 61. Display a distinct job from the emp table?


-- 62. Display all the records in the emp table where employees hired
-- after 28-SEP-81 and before 03-DEC-81?


-- 63. Write a query that displays the employee’s names with the first
-- letter capitalized and all other letters lowercase for all employees
-- whose name starts with J, A, or M


-- 64. Display all jobs that are in department 10. Include the location
-- of the department in the output.


-- 65. Write a query to display the employee name, department name of all
-- employees who earn a commission


-- 66. Display the empno, employee name, sal, and salary increased by 15%.


-- 67. Display employee name, sal, grade. Use emp, salgrade table
-- ----------------------------------
-- 			Salary > 15000 Grade A
-- 			Salary > 10000 and < 15000 Grade B
-- 			Salary between  5000 abd 10000  Grade C
-- 			Salary < 5000 Grade D
-- ----------------------------------			
-- 			And Sort on the basis of Grades
-- ----------------------------------


