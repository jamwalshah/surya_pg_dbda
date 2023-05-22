-- 2023 Apr 18

-- Assignment –1
-- Creating sample tables and inserting values.




-- Create the following tables with the given structures and insert sample data 
-- as specified: -

-- A) SALESPEOPLE
-- 		Snum int(4)
-- 		Sname varchar(10)
-- 		City varchar(10)
-- 		Comm float(3,2)
CREATE TABLE SALESPEOPLE

-- B) CUSTOMERS
-- 		Cnum int(4)
-- 		Cname varchar(10)
-- 		City varchar(10)
-- 		Rating int(4)
-- 		Snum int(4)
CREATE TABLE CUSTOMERS

-- C) ORDERS
-- 		Onum int(4)
-- 		Amt float(7,2)
-- 		Odate date
-- 		Cnum int(4)
-- 		Snum int(4)
CREATE TABLE ORDERS



-- SALES PEOPLE
-- 		SNUM SNAME CITY COMM
-- 		1001 Peel London .12
-- 		1002 Serres San Jose .13
-- 		1004 Motika London .11
-- 		1007 Rifkin Barcelona .15
-- 		1003 Axelrod New York .10
INSERT INTO SALESPEOPLE () VALUES ()


-- CUSTOMERS
-- 		CNUM CNAME CITY RATING SNUM
-- 		2001 Hoffman London 100 1001
-- 		2002 Giovanni Rome 200 1003
-- 		2003 Liu San Jose 200 1002
-- 		2004 Grass Berlin 300 1002
-- 		2006 Clemens London 100 1001
-- 		2008 Cisneros San Jose 300 1007
-- 		2007 Pereira Rome 100 1004
INSERT INTO CUSTOMERS () VALUES ()


-- ORDERS
-- 		ONUM AMT ODATE CNUM SNUM
-- 		3001 18.69 03-OCT-1990 2008 1007
-- 		3003 767.19 03- OCT -1990 2001 1001
-- 		3002 1900.10 03- OCT -1990 2007 1004
-- 		3005 5160.45 03- OCT -1990 2003 1002
-- 		3006 1098.16 03- OCT -1990 2008 1007
-- 		3009 1713.23 04- OCT -1990 2002 1003
-- 		3007 75.75 04- OCT -1990 2004 1002
-- 		3008 4723.00 05- OCT -1990 2006 1001
-- 		3010 1309.95 06- OCT -1990 2004 1002
-- 		3011 9891.88 06- OCT -1990 2006 1001 
INSERT INTO ORDERS () VALUES ()



-- Sameer Dehadrai