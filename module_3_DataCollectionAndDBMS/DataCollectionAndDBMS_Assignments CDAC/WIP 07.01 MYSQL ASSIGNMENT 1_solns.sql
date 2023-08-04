-- 2023 Apr 18
-- ---------------------------------------------------------------------
-- Basic Select Statement
-- ---------------------------------------------------------------------
-- 1. Write a query to display the names (first_name, last_name) using 
-- alias name “First Name", "Last Name"


-- 2. Write a query to get a unique department ID from the employee table.


-- 3. Write a query to get all employee details from the employee table 
-- order by first name, descending.


-- 4. Write a query to get the names (first_name, last_name), salary, 
-- PF of all the employees (PF is calculated as 15% of salary).


-- 5. Write a query to get the employee ID, 
-- names (first_name, last_name), salary in ascending order of salary


-- 6. Write a query to get the total salaries payable to employees


-- 7. Write a query to get the maximum and minimum salary from 
-- the employees table.


-- 8. Write a query to get the average salary and number of employees 
-- in the employees table


-- 9. Write a query to get the number of employees working with 
-- the company.


-- 10. Write a query to get the number of jobs available in the 
-- employees table. 


-- 11. Write a query to get all first names from the employees 
-- table in upper case. 


-- 12. Write a query to get the first 3 characters of 
-- first name from the employees table. 


-- 13. Write a query to calculate 171*214+625. 


-- 14. Write a query to get the names 
-- (for example Ellen Abel, Sundar Ande etc.) of all the employees 
-- from the employees table. 


-- 15. Write a query to get the first name from the employees table 
-- after removing white spaces from both sides.


-- 16. Write a query to get the length of the employee names 
-- (first_name, last_name) from the employees table.


-- 17. Write a query to check if the first_name field of the employees 
-- table contains numbers. 


-- 18. Write a query to select the first 10 records from a table.


-- 19. Write a query to get the monthly salary (round 2 decimal places) 
-- of each and every employee Note : Assume the salary field 
-- provides the 'annual salary' information.





-- ---------------------------------------------------------------------
-- UPDATE
-- ---------------------------------------------------------------------
-- 1. Write a SQL statement to change the email column of the 
-- employees table with 'not available' for all employees.


-- 2. Write a SQL statement to change the email and 
-- commission_pct column of employees table with 'not available' 
-- and 0.10 for all employees.


-- 3. Write a SQL statement to change the email and 
-- commission_pct column of employees table with 'not available' 
-- and 0.10 for those employees whose department_id is 110.


-- 4. Write a SQL statement to change the email column of 
-- employees table with 'not available' for those employees 
-- whose department_id is 80 and gets a commission_pct is less than .20


-- 5. Write a SQL statement to change the email column of the 
-- employees table with 'not available' for those employees who 
-- belong to the 'Accounting' department.


-- 6. Write a SQL statement to change the salary of an employee to 8000 
-- whose ID is 105, if the existing salary is less than 5000.


-- 7. Write a SQL statement to change the job ID of the employee 
-- whose ID is 118, to SH_CLERK if the employee belongs to the 
-- department, whose ID is 30 and the existing job ID does not start with SH.


-- 8. Write a SQL statement to increase the salary of employees under 
-- the department 40, 90 and 110 according to the company rules that salary 
-- will be increased by 25% for department 40, 15% for 
-- department 90 and 10% for department 110 and the rest of the departments 
-- will remain the same.


-- 9. Write a SQL statement to increase the minimum and maximum salary 
-- of PU_CLERK by 2000 as well as the salary for those employees by 20% 
-- and commission percent by .10.




-- ---------------------------------------------------------------------
-- ALTER TABLE
-- ---------------------------------------------------------------------
-- 1. Write a SQL statement to rename the table countries to country_new.


-- 2. Write a SQL statement to add a column region_id to the table locations.


-- 3. Write a SQL statement to add a column ID as the first column of 
-- the table locations.


-- 4. Write a SQL statement to add a column region_id after 
-- state_province to the table locations.


-- 5. Write a SQL statement to change the data type of the column 
-- country_id to integer in the table locations.


-- 6. Write a SQL statement to drop the column city from the table locations.


-- 7. Write a SQL statement to change the name of the column 
-- state_province to state, keeping the data type and size same.


-- 8. Write a SQL statement to add a primary key for the 
-- columns location_id in the locations table.
-- Here is the sample table employees.


-- 9. Write a SQL statement to add a primary key for a combination of 
-- columns location_id and country_id.


-- 10. Write a SQL statement to drop the existing primary from the 
-- table locations on a combination of columns location_id and country_id.


-- 11. Write a SQL statement to add a foreign key on the job_id column 
-- of the job_history table referencing the primary key job_id of jobs table.


-- 12. Write a SQL statement to add a foreign key constraint 
-- named fk_job_id on the job_id column of the job_history table 
-- referencing the primary key job_id of jobs table.


-- 13. Write a SQL statement to drop the existing foreign key fk_job_id from 
-- the job_history table on job_id column which is referencing 
-- the job_id of jobs table.


-- 14. Write a SQL statement to add an index named indx_job_id 
-- on job_id column in the table job_history.


-- 15. Write a SQL statement to drop the index indx_job_id 
-- from job_history table.





