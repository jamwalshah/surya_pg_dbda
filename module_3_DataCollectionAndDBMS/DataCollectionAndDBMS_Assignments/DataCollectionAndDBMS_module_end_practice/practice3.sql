CREATE DATABASE practice3;
USE practice3;
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- Q1 WAQ to add a column package_stat to the table orders
ALTER TABLE orders ADD COLUMN package_stat INT ;
SELECT * FROM orders;
-- -----------------------------------------------------------------
-- Q2 WAQ to change the package_stat column of orders  with 'not available' for all orders
ALTER TABLE orders MODIFY COLUMN package_stat VARCHAR(30);
SELECT * FROM orders;
DESC orders;
SET SQL_SAFE_UPDATES=0;
UPDATE orders SET package_stat="not available";
SET SQL_SAFE_UPDATES=1;
SELECT * FROM orders;
-- -----------------------------------------------------------------
-- Q3 WAQ to delete a row from customers table where where credit limit is 0.0
SELECT * FROM customers;
SELECT * FROM orders;
DESC customers;

SET SQL_SAFE_UPDATES=0;
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM customers WHERE creditLimit=0.0;
SET FOREIGN_KEY_CHECKS=1;
SET SQL_SAFE_UPDATES=1;
SELECT * FROM customers;

-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- Q1 To display the first_name  with the occurence of 'el' in the customers table
-- debug
SELECT * FROM  customers;
-- soln
SELECT First_name first_name FROM customers WHERE First_Name LIKE "%el%";
-- 
-- Q2 To prepare a list with customer name, customer_id, order_id for the customers whose delivery status is shipped
-- debug
SELECT * FROM customers;
SELECT * FROM orders;
DESC orders;
SELECT concat(c.First_Name," ",c.Last_Name) "customer name", c.customer_Id, o.order_Id,  o.Deliver
FROM customers c 
JOIN orders o 
ON c.customer_Id=o.customer_Id 
WHERE o.Deliver="Shipped";
-- soln
SELECT concat(c.First_Name," ",c.Last_Name) "customer name", c.customer_Id, o.order_Id
FROM customers c 
JOIN orders o 
ON c.customer_Id=o.customer_Id 
WHERE o.Deliver="Shipped";
-- 
-- Q3 To get the number of customers with the creditLimit greater than 50000
-- debug
SELECT * FROM customers;
SELECT * FROM customers WHERE creditLimit>50000;
-- soln
SELECT count(*) num_of_customers FROM customers WHERE creditLimit>50000;
-- 
-- Q4 To display the customer_id, name(first_name and last_name), order_id and deliver for all customers
-- debug
SELECT * FROM customers;
SELECT * FROM orders;
SELECT c.customer_Id AS customer_id, concat(c.First_Name," ",c.Last_Name) AS name, o.order_Id AS order_id, o.Deliver AS deliver 
FROM customers c JOIN orders o 
ON c.customer_Id=o.customer_Id;
-- soln
SELECT c.customer_Id AS customer_id, concat(c.First_Name," ",c.Last_Name) AS name, o.order_Id AS order_id, o.Deliver AS deliver 
FROM customers c LEFT JOIN orders o 
ON c.customer_Id=o.customer_Id;
-- 
-- Q5 To display the customer name in order of creditLimit smallest to highest
-- debug
SELECT  * FROM customers ;
SELECT  * FROM customers ORDER BY creditLimit;
-- soln
SELECT  concat(First_Name," ",Last_Name) 'customer name', creditLimit FROM customers ORDER BY creditLimit;
-- 
-- Q6 a stored procedure by name order_day. The procedure should show the customer_id and the day on which he had made the order
-- debug
SELECT * FROM customers ;
SELECT * FROM orders ;
SELECT c.customer_Id, o.order_Date 
FROM customers c LEFT JOIN orders o
ON c.customer_Id=o.customer_Id ;
DROP Procedure order_day;
-- soln
DELIMITER $$
CREATE PROCEDURE order_day(inout cust_id INT, out order_dt date)
BEGIN
	SELECT c.customer_Id, o.order_Date INTO cust_id, order_dt
	FROM customers c LEFT JOIN orders o
	ON c.customer_Id=o.customer_Id 
	WHERE c.customer_Id=cust_id;
END;
$$
DELIMITER ;
SET @custid=114;
SET @custid=112;
CALL order_day(@custid, @order_dt);
SELECT @order_dt;
-- 
-- Q7 a stored function by the name of customer_search. The stored function should return the maximum creditLimit made by any customer
-- debug
SELECT * FROM customers ;
DESC customers ;
SELECT creditLimit FROM customers WHERE customer_Id= 112;
-- soln
DELIMITER $$
CREATE FUNCTION customer_search(cust_id INT) RETURNS DECIMAL(10, 2)
BEGIN
	DECLARE credlim DECIMAL(10, 2);
    SELECT creditLimit INTO credlim
    FROM customers WHERE customer_Id=cust_id;
    RETURN credlim;
END;
$$
DELIMITER ;
SET @custid=112;
SELECT customer_search(@custid);
-- 
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------

-- Write SELECT statements to achieve the following
-- 1. Display  only the empno and ename columns from emp table
-- debug
SELECT * FROM employees;
-- soln


-- 2. display all employees who are clerks and the managers
-- debug

-- soln


-- 3. display the ename and job for all the employees who belong to the same deptno as employee 'KING'
-- debug

-- soln



-- 4. Find the names of all the employees hired in the month of february (of any year)
-- debug

-- soln



-- 5. display the employees in descending order of deptno
-- debug

-- soln



-- 6. display the employee name and employee number of the employees with the headings as NUMBER and NAME
-- debug

-- soln



-- 7. Find the names of all the employees who were hired on the last day of the month
-- debug

-- soln



-- 8. find the name of the employee who is receiving the maximum salary
-- debug

-- soln



-- 9. display the sum of sal for all the employees belonging to DEPTNO 10
-- debug

-- soln



-- 10. display the rows where JOB column ends with the letter 'T'
-- debug

-- soln



-- 11. write a stored procedure to convert the temp in fahreinheit (F) to its equivalent in Celsius (C)
-- 		The required formula is C=(F-32)*5/9
-- 		Insert the temperature inCentigrade into TEMPP table.Calling program for the stored procedure need not be writtem
-- debug

-- soln



-- 12. write a stored procedure ny the name of NUM_cube. The stored function should return the cube of a number 'N'. 
-- The number 'N' should be passed to the stored function as a parameter.
-- calling program for the stored function need not be written
-- debug

-- soln



-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
-- 1. Create a table employee, dept with following column and insert given data and to the stored function as a parameter
-- 		Calling program for the stored function need not be written


-- 2. Query to count number of employees

-- 3. query to get the unique department of employees

-- 4. Query to get min, max, avg, sum of salary for all the employees - get highest salary of an individual based on hobbies
-- 5. Query for sum of salary where address starts with 'M' or 'd' 
-- 6. get all the employee details with their department details
-- 7. query to find employees aged between 20 and 30
-- 		funtion to return name, emp_id, dept_name, hobbies, age by passing manager name
-- 8. function returns below details from employee and department table by passing manager name
-- 9. write a stored procedure that deletes all employees who have a salary less than a specified amount
-- 		the procedure should take an input parameter for the minimum salary
-- 10. Write a stored procedure that updates the job title for a given employee ID
-- 		The procedure should take input parameters for the employee ID and the new job title
-- 11. Write a stored procedure that updates the job title for a given employee ID. 
-- 		The procedure should take an input parameter for the number of years
-- 12. Write a stored function that takes an employee ID as an input parameter and returns the employee's salary
-- 13. write a stored function that takes an employee ID as an input parameter and returns the mumber of years the employee has been with the company
-- 14. write a stored function that takes a department ID as an input parameter and returns the total salary of all the employees in that department
-- 15. Write a stored function that takes an employee ID as an input parameter and returns the employee's manager's name
-- 16.Wriete a stored function that takes a department ID as an input parameter and returns a list of all employees in that department sorted by their salary in descending order
-- 		a. how a=can myswl triggers be used to automatically update employee records when a department is changed
-- 		b. what mysql trigger can be used to prevent an employee from being deleted if they are currently assigned to a department
-- 		c. how can a mysql trigger be used to send an email notification to HR when an employee is hired or terminated
-- 16. create mongodb collectoins with following details and insert data
-- 		DB=mongo exam
-- 		collection=assignment, inventory
-- 		assignment data {item:"journal", qty:25, tag:[black, red], {h:14,w}}
-- 16. get assignment documents having tags=gray
-- 16. get inventory details whose dim_cm>10, sorted by qty descending order and print only 3 documents
-- 16. create index on inventory in dscending order of qty
-- 17. query to aggregate sum of qty in inventory collection
-- 18. query to update inventory collection item name where qty:75 and dim_cm>22
-- 19. WAQ to select all employees and their corresponding department names
-- 21. WAQ to select all employees who work in the 'Sales' department
-- 22. WAQ to select the average salary for each department
-- 23. WAQ to select the total salary for each department 
-- 24. WAQ to select all employees and their corresponding department names, but only display those employees who ahave a manager
-- 25. WAQ that returns all the employees who have a salary greater than the average salary of their department
-- 26. WAQ that returns the names of all the departments that have more than 10 employees
-- 27. WAQ that returns the names of all the employees who work in departments that have a total salary greater than $1,000,000
-- 28. WAQ tht returns  the average salary of all the employees who have been with the company for less than 3 years
-- 29. -- 
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
DROP TABLE IF EXISTS `customers`;
create TABLE customers (
  customer_Id int(11) NOT NULL,
  First_Name varchar(50) NOT NULL,
  Last_Name varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  creditLimit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`customer_Id`)
  );
insert  into customers(customer_Id,First_Name,Last_Name,phone,creditLimit) values 
(125,'Piestrzeniewicz','Zbyszek ','(26) 642-7555','0.00');
  
insert  into customers(customer_Id,First_Name,Last_Name,phone,creditLimit) values 
(103,'Atelier','Schmitt','08-7896 6578','21000.00'),(112,'Signal','King','7025551838','71800.00'),
(114,'Ferguson','Peter','03-952’4555','117300.00'),
(119,'Labrune','Janine ','40.67.8555','118200.00'),
(121,'Bergulfsen','Jonas','07-989555','81700.00'),
(124,'Nelson','Susan','4155551450','210500.00'),
(125,'Piestrzeniewicz','Zbyszek ','(26) 642-7555','0.00'),
(128,'Keitel','Roland','+49 69 66 90 2555','59700.00'),
(129,'Murphy','Julie','6505555787','64600.00'),
(131,'Lee','Kwai','2125557818','114900.00'),
(141,'Freyre','Diego ','(91) 555 94 44','227600.00'),
(144,'Berglund','Christina ','0921-12 3555','53100.00'),
(145,'Petersen','Jytte','31123555','83400.00'),
(146,'Saveley','Mary ','78.32.5555','123900.00'),
(148,'Eric','Jecob','+65 221 7555','103800.00'),
(151,'Young','Jeff','2125557413','138500.00');

DROP TABLE IF EXISTS `orders`;
CREATE TABLE orders(
  order_Id int(11) NOT NULL,
  order_Date date NOT NULL,
  shipped_Date date DEFAULT NULL,
  Deliver varchar(15) NOT NULL,
  customer_Id int(11) NOT NULL,
  PRIMARY KEY (order_Id),
  FOREIGN KEY (customer_Id) REFERENCES customers(customer_Id)
);

insert  into orders(order_Id,order_Date,shipped_Date,Deliver,customer_Id) values 
(10100,'2003-01-06','2003-01-13','Shipped',114),(10101,'2003-01-09','2003-01-18','Shipped',125),
(10102,'2003-01-10','2003-01-18','Shipped',129),(10103,'2003-01-29','2003-02-07','Shipped',121),
(10104,'2003-01-31','2003-02-09','Shipped',141),(10105,'2003-02-11','2003-02-21','Shipped',145);
