CREATE DATABASE practice3;
USE practice3;
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
DROP TABLE IF EXISTS customers1;
CREATE TABLE customers1(
CUSTOMER_ID INT(11) NOT NULL,
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
PHONE VARCHAR(20) NOT NULL,
CREDITLIMIT DECIMAL(10, 2) DEFAULT NULL,
PRIMARY KEY (`CUSTOMER_ID`)
);
-- -----------------------------------------------------------------
DROP TABLE IF EXISTS orders1;
CREATE TABLE orders1(
ORDER_ID INT(11) NOT NULL,
ORDER_DATE DATE NOT NULL,
SHIPPED_DATE DATE NOT NULL,
DELIVER VARCHAR(15) NOT NULL,
CUSTOMER_ID INT(11) NOT NULL,
PRIMARY KEY(`ORDER_ID`),
FOREIGN KEY(`CUSTOMER_ID`) REFERENCES customers1(`CUSTOMER_ID`)
);
-- -----------------------------------------------------------------
-- -----------------------------------------------------------------
DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
COUNTRY_ID VARCHAR(2),
COUNTRY_NAME VARCHAR(40) DEFAULT NULL,
REGION_ID DECIMAL(10, 0) DEFAULT NULL,
PRIMARY KEY (COUNTRY_ID),
KEY COUNTR_REG_FK (REGION_ID)
);
-- -----------------------------------------------------------------
DROP TABLE IF EXISTS departments;
CREATE TABLE departments(
DEPARTMENT_ID DECIMAL(4, 0) NOT NULL DEFAULT '0',
DEPARTMENT_NAME VARCHAR(30) NOT NULL,
MANAGER_ID DECIMAL(4, 0) DEFAULT NULL,
LOCATION_ID DECIMAL(4,0) DEFAULT NULL,
PRIMARY KEY(DEPARTMENT_ID),
KEY DEPT_MGR_FK (MANAGER_ID),
KEY DEPT_LOCATION_FK (LOCATION_ID)
);
-- -----------------------------------------------------------------
-- 






