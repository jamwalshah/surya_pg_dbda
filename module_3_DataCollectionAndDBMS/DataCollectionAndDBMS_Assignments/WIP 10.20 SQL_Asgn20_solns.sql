-- 2023 Apr 18


-- Assignment – 20
-- Changing Values through Views.




-- 1) Which of these views are updateable (will allow DML operations)?
-- 
-- 	#1	Create View Dailyorders
-- 			as Select Distinct cnum, snum, onum, odate from Orders;
-- 
-- 	#2	Create View Custotals
-- 			as Select cname, Sum (amt) Sum_Amt from Orders, Customers
-- 			where Orders.cnum=Customers.cnum
-- 			Group by cname;
-- 
-- 	#3	Create view Thirdorders
-- 			as Select * from Dailyorders where odate=‟1990-10-03‟;
-- 
-- 	#4	Create view Nullcities
-- 			as Select snum, sname, city
--			from Salespeople
-- 			where city is NULL
-- 			OR sname BETWEEN ‘A’ and ‘MZ’;



-- 2) Create a view of the Salespeople table called Commissions. 
-- This view will include only the snum and comm fields. 
-- Through this view, someone could enter or change commissions, 
-- but only to values between .10 and .20. 





-- Sameer Dehadrai