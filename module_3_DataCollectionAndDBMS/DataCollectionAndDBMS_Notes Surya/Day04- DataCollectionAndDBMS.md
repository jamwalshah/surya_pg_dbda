# Day04- DataCollectionAndDBMS

## `WHERE` clause

1. It can be used with any of the operators
2. It is used to filter the row returned by `SELECT` statement
3. It allows you to specify a condition, that each row must meet in order to be included in the result set
4. Syntax:

    ```sql
    SELECT <column_name> FROM <table_name> WHERE <condition>;
    ```

5. This condition can include one or more expression that compares column values to literal value or other column
6. We can use operators like relational operators, logical operators in WHERE condition

    > **Tip:** If you don't use `WHERE` clause, all the rows will be affected for that operation

## Operators in SQL

It has following operators in precedence order of high to low

### 1. Relational operators

| Symbol | Detail |
| :-- | :-- |
| `>` | greater than |
| `>=` | greater than or equal to |
| `<` | less than |
| `<=` | less than or equal to |
| `!=` or `<>` | is not equal to |
| `=` | is equal to (don't use `==` in SQL) |
| `<=>` | NULL-safe equal to operator |

### 2. Logical Operators

1. `NOT` (Logical NOT)
    1. It’’ll give the output which is not present in the condition
    2. Example:

        ```sql
        SELECT * FROM employees WHERE SALARY NOT IN (24000, 17000);
        ```

2. `AND` (logical AND)
    1. It’’ll give output where both the conditions match
    2. Example:

        ```sql
        SELECT * FROM employees WHERE department_id=100 AND SALARY>6000; 
        ```

3. `OR` (logical OR)
    1. It’’ll give output where any of the conditions match
    2. Example:

        ```sql
        SELECT * FROM employees WHERE department_id=100 OR SALARY>6000;
        ```

- Consider this **Query 1**

    ```sql
    SELECT * FROM employees WHERE DEPARTMENT_ID=60 OR DEPARTMENT_ID=20 AND SALARY=17000;
    ```

    1. In Query 1, `DEPARTMENT_ID=60` or `DEPARTMENT_ID=20` will return employees who either belong to dept 20 or 60.
    2. The condition `SALARY=17000` will be connected to what previous condition of dept id being 60 or 20, which means condition will show employee whose `DEPARTMENT_ID` is 60, hence, it’ll lead to incorrect result as the condition is applied to `employees` who belong to either of the employees

- Consider this **Query 2**

    ```sql
    SELECT * FROM employees WHERE (DEPARTMENT_ID=60 OR DEPARTMENT_ID=20)AND SALARY>17000;
    ```

    > `AND` operator will get precedence over `OR` operator
    1. In Query 2, in this condition, `DEPARTMENT_ID=60` or `DEPARTMENT_ID=20` are grouped together within parenthesis.
    2. This ensures that OR condition will be evaluated first and then only condition `SALARY>17000` will be applied to employees who belong to either `DEPARTMENT_ID=60` OR `DEPARTMENT_ID=20`

### 3. Arithmetic operator

| Operator | Details |
| :-- | :-- |
| `()` | Parenthesis |
| `**` | Exponent |
| `%` or `MOD` | Modulo, remainder |
| `/` | Division |
| `*` | Multiplication |
| `+` | Addition |
| `-` | Subtraction |

## Pre-defined functions

These predefined functions are divided into categories

### 1. Aggregate Functions

1. `avg()`
    1. This function is used to calculate the average of the column
    2. Syntax:

        ```sql
        SELECT avg(column_name) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT avg(SALARY) FROM employees;
        ```

2. `sum()`
    1. This function is used to calculate the summation of all the records in the column
    2. Syntax:

        ```sql
        SELECT sum(column_name) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT sum(SALARY) FROM employees;
        ```

3. `count()`
    1. This function is used to count all the records in the column
    2. Syntax:

        ```sql
        SELECT count(*/column_name) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT count(*) FROM employees;
        ```

4. `max()`
    1. This function is used to find the maximum value from the column
    2. Syntax:

        ```sql
        SELECT max(column_name) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT max(SALARY) FROM employees;
        ```

5. `min()`
    1. This function is used to find the maximum value from the column
    2. Syntax:

        ```sql
        SELECT min(column_name) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT min(SALARY) FROM employees;
        ```

### 2. Comparison Functions

1. The comparison functions compare different values
2. `ISNULL()`
    1. This check for the value whether it is present in the list or not
    2. Example:

        ```sql
        SELECT FIRST_NAME FROM employees WHERE isnull(SALARY);
        ```

3. `LEAST(column1, column2)`
    1. This will return the least values from the column which are less than the specified value
    2. Syntax:

        ```sql
        least(column1, column2, column3)
        least(num1, num2, num3)
        least(str1, str2, str3)
        least(date1, date2, date3)
        ```

    3. This works for any data type and returns the least among the values
    4. This can u=be used in scenarios where we have to give a discount of a certain percentage, then you’ll use this function
    5. We can pass up to 255 values as arguments to it
4. `GREATEST(column1, column2)`
    1. This will return the greatest value from the column which are greater than the specified value
    2. Syntax

        ```sql
        greatest(column1, column2, column3)
        greatest(num1, num2, num3)
        greatest(str1, str2, str3)
        greatest(date1, date2, date3)
        ```

        > **NOTE:** Whenever you do a comparison with `NULL`, it’ll always return `NULL`. These are also referred to as pessimistic queries, which means that we are searching for `NULL` values

        ```sql
        SELECT SALARY FROM employees WHERE SALARY=NULL;
        ```

5. `IN` operator
    1. It operator allows you to specify multiple values in where clause
    2. `IN` operator is a shorthand for `OR` operator
    3. Example:

        ```sql
        SELECT * FROM employees WHERE DEPARTMENT_ID IN (10, 20,30);
        SELECT * FROM employees WHERE SALARY NOT IN (24000, 17000);
        ```

6. `BETWEEN` operator
    1. The `BETWEEN` operator selects values within a given range. The values can be numbers, text, or dates.
    2. The `BETWEEN` operator is inclusive: begin and end values are *included*.
    3. Example:

        ```sql
        SELECT * FROM employees WHERE SALARY BETWEEN 10000 AND 12000;
        ```

7. `LIKE` operator
    1. This operator is used to search a specific pattern in the column
    2. It supports 2 wildcard characters
    3. `'%'` represents 0 or more characters
    4. `'_'` represents single characters
    5. Example:
        1. Names starting with `s` are printed

            ```sql
            SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE 's%';
            ```

        2. Names ending with `a` are printed

            ```sql
            SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%a';
            ```

        3. Names containing `a` in between are printed

            ```sql
            SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%a%';
            ```

        4. Names with `a` as second character are printed

            ```sql
            SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '_a%';
            ```

8. `COALESCE(expr1, expr2, ..., exprN)`
    1. returns the first non-null value in a list of expressions
    2. used to substitute `NULL` with a default value or another column's value
    3. Syntax:

        ```sql
        COALESCE(expr1, expr2, ..., exprN)
        ```

    4. Example:

        ```sql
        UPDATE locations SET postal_code=NULL where LOCATION_ID=2400;
        UPDATE locations SET postal_code=NULL, STREET_ADDRESS=NULL where LOCATION_ID=1500;
        SELECT Location_ID, STREET_ADDRESS, COALESCE(postal_code, street_address, "One", "Two") as postal_code FROM locations;
        ```

### 3. String Functions

1. `concat()`
    1. It is used to concatenate two columns
    2. Example:

        ```sql
        SELECT concat(FIRST_NAME, " ", LAST_NAME) AS EmployeeName FROM employees;
        ```

2. `instr()`
    1. When we want to find the **first occurrence** of any substring, then we use this function
    2. Example:

        ```sql
        SELECT instr(FIRST_NAME, 'ar') AS pos_of_ar FROM employees;
        ```

3. `length()`
    1. If you want to find the length of any column in bytes and characters, we use `length()` function
    2. Returns the **number of bytes** given in a string
    3. Example:

        ```sql
        SELECT length(FIRST_NAME) as len_bytes FROM employees;
        ```

4. `char_length()`
    1. Returns the number of characters in a string
    2. Example:

        ```sql
        SELECT char_length(FIRST_NAME) as length_chars FROM employees;
        ```

    > Difference between `length()` and `char_length()` is that the number of bytes may not be same as the number of characters, and you may get different results while using the character set UTF-8

5. `left(column_name, number_of_characters)`
    1. If you want to get **first *n* characters** of any column, we will use the `left()` function
    2. First parameter is the column name, second parameter is number of first characters you want
    3. Example:

        ```sql
        SELECT left(FIRST_NAME, 3) FROM employees; -- gives first 3 chars
        ```

6. `right(column_name, number_of_characters)`
    1. If you want to get **last *n* characters** of any column, we will use the `right()` function
    2. First parameter is the column name, second parameter is number of last characters you want
    3. Example:

        ```sql
        SELECT right(FIRST_NAME, 3) FROM employees; -- gives last 3 chars
        ```

7. `substring(string, start_position [, length=end])`
    1. When you want to extract substring with their position value and with specified length then we use this function.
        > SQL uses 1-based index for strings, so start position starts from 1
    2. Syntax:

        ```sql
        SELECT substring(column_name, start_position, number_of_characters) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT substring(FIRST_NAME, 3, 2) FROM employees;
        SELECT substring(FIRST_NAME, 3) FROM employees;
        ```

    4. Realtime example of polymorphism can be `substring()` function

8. `substring_index(string, delimiter, count)`
    1. This function is used to extract substring from a string, based on delimiter that separates the substring based on the string
    2. It takes the arguments as
        1. original
        2. Delimiter
        3. count specifies which occurrence of delimiter to use for substring extraction, negative count will count from right
    3. Example:

        ```sql
        SELECT substring_index(STREET_ADDRESS, ' ', -1) AS street FROM locations;
        ```

9. `lower(string)`
    1. This will convert the string to lower case
    2. Syntax:

        ```sql
        SELECT lower(column_name) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT lower(FIRST_NAME) AS fname FROM employees;
        ```

10. `upper(string)`
    1. This will convert the string to upper case
    2. Syntax:

        ```sql
        SELECT upper(column_name) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT upper(FIRST_NAME) AS fname FROM employees;
        ```

11. `lpad(string, length, pad_string)`
    1. This is used for right justification, adds left-padding
    2. Syntax:

        ```sql
        SELECT lpad(column_name, number_of_characters, delimiter) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT lpad(FIRST_NAME, 10, '*') AS fname, FIRST_NAME FROM employees;
        ```

12. `rpad(string, length, pad_string)`
    1. This is used for left justification, adds right padding
    2. Syntax:

        ```sql
        SELECT rpad(column_name, number_of_characters, delimiter) FROM table_name;
        ```

    3. Example:

        ```sql
        SELECT rpad(FIRST_NAME, 10, '*') AS fname, FIRST_NAME FROM employees;
        ```

13. `ltrim(string)`
    1. It’ll remove the unwanted space from the left side
    2. Syntax:

        ```sql
        SELECT ltrim(column_name) from table_name;
        ```

    3. Example:

        ```sql
        SELECT ltrim(STREET_ADDRESS) FROM locations;
        ```

14. `rtrim(string)`
    1. It’ll remove the unwanted space from the right side
    2. Syntax:

        ```sql
        SELECT ltrim(column_name) from table_name;
        ```

    3. Example:

        ```sql
        SELECT rtrim(STREET_ADDRESS) FROM locations;
        ```

15. `trim(string)`
    1. It’ll remove the unwanted spaces/tab spaces at start/end
    2. Syntax:

        ```sql
        SELECT ltrim(column_name) from table_name;
        ```

    3. Example:

        ```sql
        SELECT trim(STREET_ADDRESS) FROM locations;
        ```

16. `replace(string, old_substring, new_substring)`
    1. This function is used to replace all the occurrence of substring within a string with new substring
    2. Syntax:

        ```sql
        SELECT replace(column_name, character_to_be_replaced, replacement_character);
        ```

    3. Example:

        ```sql
        SELECT replace(FIRST_NAME, 'a', 'Y') FROM employees;
        ```

17. `find_in_set()`
    1. This function is used to find the position of a sub-string within string which is a comma-separated list of values
    2. available only in MySQL
    3. Syntax:

        ```sql
        SELECT find_in_set(string_to_be_searched, comma_separated_string_list) from table_name;
        ```

    4. Example:

        ```sql
        SELECT DEPARTMENT_ID FROM departments WHERE find_in_set('IT', DEPARTMENT_NAME);
        ```

18. `reverse(string)`
    1. This function is used to reverse the string
    2. not available in Oracle SQL
    3. Syntax:

        ```sql
        SELECT reverse(column_name) FROM table_name;
        ```

    4. Example:

        ```sql
        SELECT reverse(FIRST_NAME) FROM employees;
        ```

19. `locate(string)`
    1. This function will find the position of substring within a string
    2. same functionality as`POSITION()` in PostgreSQL and `CHARINDEX()` in SQL Server
    3. This will return the position (not index) at which substring is found, returns 0 if not found
    4. Syntax:

        ```sql
        SELECT locate(substring_to_locate, column_name) FROM table;
        ```

    5. Example:

        ```sql
        SELECT locate('ell', FIRST_NAME) FROM employees;
        ```

20. `initcap(string)`
    1. It is used to make initial character in capital
    2. works in PostgreSQL and Oracle SQL
    3. Syntax:

        ```sql
        SELECT initcap(column_name) FROM table_name;
        ```

### 4. Math Functions

In math functions, there are multiple functions like

1. `abs(numeric_value)`
    1. returns absolute value of a number
    2. Example:

        ```sql
        SELECT abs(-5.1); -- 5.1
        ```

2. `floor(numeric_value)`
    1. return the smallest integer value that is smaller than the argument passed
    2. Example:

        ```sql
        SELECT floor(4.99); -- 4
        ```

3. `round(numeric_value [, decimal_places])`
    1. this will round off the decimal
    2. Example:

    ```sql
    SELECT ROUND(4.1755, 2); -- 4.18
    SELECT ROUND(4.1755); -- 4
    ```

4. `truncate(numeric_value, decimal_places)`
    1. removes the decimal portion of a number
    2. Example:

        ```sql
        SELECT truncate(4.9999, 2); -- 4.99
        SELECT truncate(449.9999, -1); -- 440
        ```

5. `mod(numeric_expression, divisor)`
    1. returns the mod/remainder
    2. Example:

        ```sql
        SELECT mod(19, 4); -- 3
        SELECT mod(-19, 4); -- -3
        SELECT mod(19, -4); -- -3
        SELECT mod(19, 0); -- NULL
        ```

6. `pow(base, exponent)` or `power(base, exponent)`
    1. raise a base number to the power of exponent, equivalent to ${base^{exponent}}$
    2. Example:

        ```sql
        SELECT pow(2, 3); -- 8
        SELECT pow(2, -3); -- 0.125
        ```

### 5. Control Flow Functions

1. `CASE...END`

    1. return the corresponding result in `THEN` branch if the condition in the `WHEN` branch is satisfied, otherwise, return the result in the `ELSE` branch.
    2. `CASE` statement checks the condition and returns the value of the condition that matches, so if one condition is `TRUE`, it’ll stop reading and return the result
    3. If there is no else or none of the conditions is `TRUE`, it’ll return `NULL`
    4. It accepts two parameters:
        1. Condition
        2. Result
    5. It works by evaluating a series of conditions and it returns a result based on first condition that maybe `TRUE`
    6. Syntax:

        ```sql
        CASE [expression]
            WHEN value1/condition1, THEN result1
            WHEN value2/condition2, THEN result2
            WHEN value3/condition3, THEN result3
            WHEN value4/condition4, THEN result4
            ELSE default_result
        END
        ```

    7. Example:

        ```sql
        SELECT FIRST_NAME, LAST_NAME, SALARY,
        CASE
            WHEN SALARY<=6000 THEN SALARY*.10
            WHEN SALARY<=10000 THEN SALARY*.20
            WHEN SALARY<=20000 THEN SALARY*.30
            ELSE SALARY*.5
        END AS bonus
        FROM employees;
        ````

2. `IF...ELSEIF...ELSE...END IF` or `IF(conditions, if_condition_true, if_condition_false)`
    1. used to implement conditional logic
    2. Syntax:

        ```sql
        IF condition1 THEN
            logic_for_condition1 ;
        ELSEIF condition2 THEN
            logic_for_condition2 ;
        ELSE
            logic_for_other_conditions ;
        END IF;
        ```

    3. Example:

        ```sql
        DELIMITER //
        CREATE FUNCTION SimpleCompare(n INT, m INT)
            RETURNS VARCHAR(20)
            READS SQL DATA
            DETERMINISTIC
            BEGIN
                DECLARE s VARCHAR(20);
                IF n>m THEN SET s='>';
                ELSEIF n=m THEN SET s='=';
                ELSE SET s='<';
                END IF;
                SET s = CONCAT(n, ' ', s, ' ', m);
                RETURN s;
            END //
        DELIMITER ;
        SELECT SimpleCompare(3, 5);
        ```

        ```sql
        SELECT IF('nisarg'='nirali', True, False) AS `Simple IF Statement`;
        ```

3. `IFNULL(expr1, expr2)`
    1. return the first argument if it is `NOT NULL` , otherwise returns the second argument
    2. if the specified expression is `NULL`, then it returns the specified value, else it returns the expression
    3. Syntax

        ```sql
        SELECT IFNULL(expr1, expr2);
        ```

    4. Example:

        ```sql
        SELECT LOCATION_ID, STREET_ADDRESS, ifnull(POSTAL_CODE, 'Not Available') AS `postal_code` FROM locations;
        ```

4. `NULLIF(expr1, expr2)`
    1. return NULL if the first argument is equal to the second argument, otherwise, returns the first argument
    2. Compares the expressions specified in function, If the values of expressions are equal, then it returns `NULL`, else it returns first expression
    3. Syntax:

        ```sql
        SELECT NULLIF(expr1, expr2);
        ```

    4. Example:

        ```sql
        SELECT FIRST_NAME, LAST_NAME, SALARY, NULLIF(COMMISSION_PCT, 0.00) AS commission FROM employees;
        ```

### 6. Date and Time Functions

1. `NOW()` or `CURRENT_TIMESTAMP()`
    1. returns the time at which statement began execution
    2. Example:

        ```sql
        SELECT NOW(), CURRENT_TIMESTAMP();
        ```

2. `CURDATE()` or `CURRENT_DATE()`
    1. returns the current date (without time) in `YYYY-MM-DD` or `YYYYMMDD` format, depending on it is used in string context ot numeric context
    2. Example:

        ```sql
        SELECT CURDATE(), CURRENT_DATE(), CURDATE()+0;
        ```

3. `CURTIME(fsp)` or `CURRENT_TIME(fsp)`
    1. Return the current time (Without date) in format `hh:mm:ss` or `hhmmss` depending on it is used in string context or numeric context respectively
    2. `fsp` argument is fractional seconds precision from 0 to 6, digits after decimal in second
    3. Example:

        ```sql
        SELECT CURTIME(), CURRENT_TIME(), CURTIME()+0, CURTIME(3), CURTIME(3)+0;
        ```

4. `EXTRACT()`
5. `DATE_FORMAT()`
6. `STR_TO_DATE()`
7. `TIMESTAMP()`
8. `UNIX_TIMESTAMP()`
9. `FROM_UNIXTIME()`
10. `TIMESTAMPDIFF()`
11. `DATEDIFF()`
12. `TIMEDIFF()`
13. `DATE_ADD()`
14. `DATE_SUB()`
15. `ADDDATE()`
16. `SUBDATE()`

### 7. Window Functions

1. Allows users to perform advanced calculations across a specified set of rows (related to the current row) known as **window** while retaining the individual data rows
2. These calculations happen within a defined window of data, and they are particularly useful for aggregates, ranking and cumulative totals without altering the dataset
3. Unlike traditional aggregate functions which return a single result for an entire group, window functions provide calculations across different partitions or groups of data, enabling complex analysis without altering original dataset

#### `OVER()` Clause

1. `OVER()` clause is the **key to define a window**
2. It partitions the data into different sets (using the `PARTITION BY` clause) and orders them (using the `ORDER BY` clause)
3. If `PARTITION BY` is **not specified** then all rows are put into **one single window**
4. These windows enable functions like `SUM()`, `AVG()`, `ROW_NUMBER()`, `RANK()` and `DENSE_RANK()` to be applied in a sophisticated manner
5. Syntax:

```sql
SELECT column1,
    <window_function>(column2) OVER ([PARTITION BY column1] [ORDER BY column3]) AS new_column
FROM table_name;

<window_function> := any aggregate or ranking function
column1 := column to be selected
column2 := column on which window function is to be applied
column3 := column on whose basis partition of rows is to be done
new_column := name of new column created upon windowing
```

#### Types of Window Functions

SQL Window functions are categorized into four primary types:

1. Aggregate Window Functions
2. Ranking Window Functions
3. Relative Row Window functions
4. Value Window Functions

These four types serve different purposes, but share a common ability to perform calculations over a defined set of rows while retaining the original data.

##### Aggregate Window Functions

1. These allow us to perform aggregate operations across a set of rows within the defined window, while still retaining the detail-level data
2. Aggregate functions available for `GROUP BY` such as `SUM()`, `AVG()`, `COUNT()`, `MAX()` and `MIN()` are also available as window functions
3. For Aggregate window functions, `OVER()` clause is **not mandatory**, but if `OVER()` clause is not used, these will only resolve columns for which aggregation is possible
4. Common Aggregate Window Functions are
    1. `SUM(expr)`
        1. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY,
                SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS SUM_OF_SALARY -- creates windows based on DEPARTMENT_ID column
            FROM employees;
            ```

    2. `AVG(expr)`
        1. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                AVG(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID) AS Average_SALARY -- orders windows based on DEPARTMENT_ID column
            FROM employees;
            ```

    3. `COUNT(expr)`
        1. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                COUNT(SALARY) OVER(ORDER BY SALARY) AS COUNT_OF_SALARY -- creates windows based on SALARY and orders windows based on salaries
            FROM employees;
            ```

    4. `MAX(expr)`
        1. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                MAX(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS MAX_SALARY -- allows to display non-aggregated columns too, while windows based on SALARY column are aggregated
            FROM employees;
            ```

    5. `MIN(expr)`
        1. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                MIN(SALARY) OVER(PARTITION BY DEPARTMENT_ID) AS MIN_SALARY
            FROM employees;
            ```

    6. `STDDEV_POP()`
    7. `STDDEV_SAMP()` or `STDDEV()` or `STD()`
    8. `VAR_POP()`
    9. `VAR_SAMP()` or `VARIANCE()`
    10. `BIT_AND()`
    11. `BIT_OR()`
    12. `BIT_XOR()`
    13. `JSON_ARRAYAGG()`
    14. `JSON_OBJECTAGG()`

##### Non-Aggregate Window Functions

1. Allows to perform different operations such as ranking, analytics, and other operations, but **require** `OVER()` clause to perform calculations
2. Non-Aggregate Window Functions include
    1. Ranking Window Functions
    2. Analytics Functions
    3. Other Window Functions

###### Ranking Window Functions

1. Used to assign a rank or a unique number to each row in a result set, based on the ordering of rows in a partition
2. Ranking Window Functions include
    1. `ROW_NUMBER()`
        1. Assigns a **unique sequential integer to rows** within each partition of a result set, starting from 1 for each partition
        2. **Row numbers are not repeated** within each partition
        3. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY DEPARTMENT_ID) AS row_num
            FROM employees;
            ```

    2. `RANK()`
        1. Assigns a rank number to each row in a partition
        2. Similar to `ROW_NUMBER()`, but it **allows for ties**
        3. If two rows have the same value, they get the same rank, and the next row gets a rank that skips the numbers
        4. Tied values are assigned same rank, next **ranking(s) is/are skipped for tied rows**
        5. There can be **gaps in ranking** if there are ties in rows
        6. `PARTITION BY` clause is **optional**, but `ORDER BY` clause is **mandatory**
        7. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS rnk
            FROM employees;
            ```

    3. `DENSE_RANK()`
        1. Assigns rank number to each row in a partition, but in a dense manner(doesn't skips rank)
        2. SImilar to `RANK()`, **allows for ties**, but it **does not skip any ranks** if there are ties
        3. There are **no gaps in ranking**
        4. `PARTITION BY` clause is **optional**, but `ORDER BY` clause is **mandatory**
        5. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS row_num, 
                RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS rnk, 
                DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS dns_rnk
            FROM employees;
            ```

    4. `PERCENT_RANK()`
        1. Assigns the **rank number of each row in a partition as a percentage/fraction between `0...1`**, **allows for ties**
        2. **Tied values are assigned same rank**
        3. Computed as **percentage/fraction of rows less than the current row**, i.e., the rank of row divided by the largest rank in the partition
        4. `PARTITION BY` clause is **optional**, but `ORDER BY` clause is **mandatory**
        5. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS row_num, 
                RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS rnk, 
                DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS dns_rnk, 
                PERCENT_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS pct_rnk
            FROM employees;
            ```

    5. `CUME_DIST()`
        1. assigns the cumulative distribution, the **percentage/fraction of rows less than or equal to the current row**, **allows for ties**
        2. assigns a rank **larger than 0 and atmost 1**
        3. **Tied values are given the same cumulative distribution value**
        4. `PARTITION BY` clause is **optional**, but `ORDER BY` clause is **mandatory**
        5. Example:

        ```sql
        SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
            ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS row_num, 
            RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS rnk, 
            DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS dns_rnk, 
            PERCENT_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS pct_rnk, 
            CUME_DIST() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS cum_dist
        FROM employees;
        ```

    6. `NTILE(n_buckets)`
        1. Divides the rows in the window into `n` equal parts/buckets, and assigns a number between `1...n` to each row
        2. Distributes the **rows of a partition into a specified number of buckets**
        3. for reference, if we use `NTILE(5)` on a table with 100 rows, then rows 1-20 will go into bucket 1, rows 21-40 will go into bucket 2 and so on
        4. `PARTITION BY` clause and `ORDER BY` clause, both are **optional**
        5. Example:

            ```sql
            SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
                NTILE(3) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS ntile_3
            FROM employees;
            ```

###### `LEAD`, `LAG` Window Functions

1. These locate a row relative to the current row
2. Both `LEAD` and `LAG` take three arguments:
    1. `Expression` : the name of column from which the value is retrieved
    2. `Offset` : the number of rows to skip, defaults to 1
    3. `Default_value` : the value to be returned if the value retrieved is `NULL`, defaults to `NULL`
3. Both `LEAD` and `LAG` require `ORDER BY` clause, but `PARTITION BY` clause is optional in `OVER()` clause
4. `LEAD(expr[, offset[, default_value]])`
    1. Accesses the value stored in a row after the current row
    2. Example:

        ```sql
        SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
            LEAD(SALARY, 2, "Not Available") OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) as 2_skip_salary
        FROM employees;
        ```

5. `LAG(expr[, offset[, default_value]])`
    1. Accesses the value stored in a row before the current row
    2. Example:

        ```sql
        SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
            LEAD(SALARY, 2, "Not Available") OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) as 2_nxt_salary, 
            LAG(SALARY, 2, "Not Available") OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) as 2_prev_salary
        FROM employees;
        ```

###### Value Window Functions

1. Allow you to retrieve specific values based on a **window created till the current row**, providing more flexibility for row-wise calculations
2. Helpful to calculate the first or last or some nth value in a window
3. `FIRST_VALUE(expr)`
    1. Returns the first value in an ordered partition of a result set
    2. Example:

        ```sql
        SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
            FIRST_VALUE(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS fst_sal
        FROM employees;
        ```

4. `LAST_VALUE(expr)`
    1. Returns the last value in an ordered partition of a result set
    2. Example:

        ```sql
        SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
            FIRST_VALUE(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS fst_sal, 
            LAST_VALUE(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS lst_sal
        FROM employees;
        ```

5. `NTH_VALUE(expr, n)`
    1. Returns the nth value in an ordered partition of a result set
    2. `n` : the position of the value (e.g. 1 for first value, 2 for second value, and so on)
    3. Example:

        ```sql
        SELECT FIRST_NAME, DEPARTMENT_ID, SALARY, 
            FIRST_VALUE(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS fst_sal, 
            LAST_VALUE(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS lst_sal, 
            NTH_VALUE(SALARY, 3) OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY) AS nth_sal
        FROM employees;
        ```

## Practical

```sql
-- ###################
-- Database- Day04
-- ###################
USE hr;
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS EmployeeName From employees; -- concat() will concatenate two columns data into one column
-- 

-- WHERE clause
SELECT EMPLOYEE_ID, SALARY FROM employees WHERE SALARY>5000;

-- Relational Operators
-- Greater than
SELECT * FROM employees WHERE SALARY>8000; -- prints employees with salary more than 8000
-- Less than
SELECT * FROM employees WHERE SALARY<10000; -- prints employees with salary less than 10000
-- Not Equal to
SELECT * FROM employees WHERE SALARY!=17000; -- prints employees with salary not equal to 17000
SELECT * FROM employees WHERE SALARY<>17000; -- prints employees with salary not equal to 17000

-- logical NOT , similar to Not Equal to
SELECT * FROM employees WHERE NOT SALARY=17000; -- prints employees with salary not equal to 17000
-- equal to , Greater than , logical AND 
SELECT * FROM employees WHERE DEPARTMENT_ID=100 AND SALARY>6000; -- print employees who work
-- BETWEEN.. AND operator
SELECT * FROM employees WHERE SALARY BETWEEN 10000 AND 12000; -- print employee whose salary is between 10k to 12k

-- AND operator
SELECT * FROM employees WHERE department_id=100 AND SALARY>6000; -- print employee whose dept ID is 100 and salary greater than 6000
-- OR operator
SELECT * FROM employees WHERE department_id=100 OR SALARY>6000; -- print employee whose dept ID is 100 or salary greater than 6000

-- Write a query where employee works for
-- dept whose ID is 60 or 30 and have salary of 13000
SELECT * FROM employees -- Query 1, works as expected for above problem
    WHERE (DEPARTMENT_ID=60 OR DEPARTMENT_ID=20) AND SALARY=13000;
SELECT * FROM employees -- Query 2
    WHERE DEPARTMENT_ID=60 OR DEPARTMENT_ID=20 AND SALARY=13000;

SELECT * FROM employees -- Query 2
    WHERE DEPARTMENT_ID=60 OR DEPARTMENT_ID=20;

-- IN operator
SELECT * FROM employees -- IN operator
    WHERE DEPARTMENT_ID IN (10, 20,30);
SELECT * FROM employees -- NOT IN operator combination
    WHERE SALARY NOT IN (24000, 17000);

-- ANY operator
SELECT * FROM employees; -- observe output
SELECT * FROM DEPARTMENTS; -- observe output, as it is being used in sub-query
-- matches all values of DEPARTMENT_ID from departments table in table employees to print DEPARTMENT_IS & FIRST_NAME
SELECT DEPARTMENT_ID, FIRST_NAME FROM employees
    WHERE DEPARTMENT_ID = ANY (SELECT DEPARTMENT_ID FROM departments);

SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_ID IN (10, 20);  -- observe output, as it is being used in sub-query
-- matches DEPARTMENT_ID 10, 20 from departments table in table employees to print DEPARTMENT_IS & FIRST_NAME
SELECT DEPARTMENT_ID, FIRST_NAME FROM employees
    WHERE DEPARTMENT_ID = ANY (SELECT DEPARTMENT_ID FROM departments WHERE DEPARTMENT_ID IN (10, 20));

SELECT SALARY FROM employees WHERE SALARY BETWEEN  9000 AND 12000;
SELECT DEPARTMENT_ID, FIRST_NAME, SALARY FROM employees
    WHERE SALARY = ANY (SELECT SALARY FROM employees WHERE SALARY BETWEEN 9000 AND 12000);

-- ALL operator
SELECT DEPARTMENT_ID FROM departments; -- observe output, as it is being used in sub-query
SELECT * from employees -- returns NULL as none of the condition is specified using WHERE clause
    WHERE DEPARTMENT_ID = ALL (SELECT DEPARTMENT_ID FROM departments); 

SELECT DEPARTMENT_ID FROM departments  WHERE DEPARTMENT_ID=90; -- observe output, as it is being used in sub-query
SELECT * from employees -- returns records from employees who have DEPARTMENT_ID=90
    WHERE DEPARTMENT_ID = ALL (SELECT DEPARTMENT_ID FROM departments  WHERE DEPARTMENT_ID=90);

-- comparison of ANY, ALL outputs
SELECT * from employees -- returns same output as previous query with ALL operator
    WHERE DEPARTMENT_ID = ANY (SELECT DEPARTMENT_ID FROM departments  WHERE DEPARTMENT_ID=90); 

-- 
SELECT FIRST_NAME fname, SALARY, SALARY*12 annual_salary FROM employees;
SELECT * FROM employees;

-- String Function
-- concat()
SELECT concat(FIRST_NAME, " ", LAST_NAME) AS EmployeeName 
FROM employees;

-- instr()
SELECT instr(FIRST_NAME, 'ar') AS pos_of_ar 
FROM employees;

SELECT instr(FIRST_NAME, 'ar') AS pos_of_ar, FIRST_NAME 
FROM employees;

-- length in bytes
SELECT length(FIRST_NAME) as len_bytes 
FROM employees;

SELECT length(FIRST_NAME) as len_bytes, FIRST_NAME 
FROM employees;

-- length in character
SELECT char_length(FIRST_NAME) as length_chars 
FROM employees;

SELECT char_length(FIRST_NAME) as length_chars, FIRST_NAME 
FROM employees;

-- left
SELECT left(FIRST_NAME, 3) 
FROM employees;

SELECT left(FIRST_NAME, 3), FIRST_NAME 
FROM employees;

-- right
SELECT right(FIRST_NAME, 3) 
FROM employees;

SELECT right(FIRST_NAME, 3), FIRST_NAME 
FROM employees;

-- lower
SELECT lower(FIRST_NAME) AS fname 
FROM employees;

SELECT lower(FIRST_NAME) AS fname, FIRST_NAME 
FROM employees;

-- upper
SELECT upper(FIRST_NAME) AS fname 
FROM employees;

SELECT upper(FIRST_NAME) AS fname, FIRST_NAME 
FROM employees;

-- lpad
SELECT lpad(FIRST_NAME, 10, '*') 
FROM employees;

SELECT lpad(FIRST_NAME, 10, '*') AS fname, FIRST_NAME 
FROM employees;

-- rpad
SELECT rpad(FIRST_NAME, 10, '*') 
FROM employees;

SELECT rpad(FIRST_NAME, 10, '*') AS fname, FIRST_NAME 
FROM employees;

-- substring
SELECT substring(FIRST_NAME, 3, 2) FROM employees;
SELECT substring(FIRST_NAME, 3, 2), FIRST_NAME FROM employees;
SELECT FIRST_NAME FROM employees;
SELECT substring(FIRST_NAME, 3) FROM employees;
SELECT substring(FIRST_NAME, 3), FIRST_NAME FROM employees;
SELECT substr(FIRST_NAME, 3), FIRST_NAME FROM employees; -- works same as substring() function

-- string_
SELECT STREET_ADDRESS FROM locations;
SELECT substring_index(STREET_ADDRESS, ' ', -1) AS street FROM locations;
SELECT substring_index(STREET_ADDRESS, ' ', -1) AS street, STREET_ADDRESS FROM locations;

-- intcap
SELECT initcap(FIRST_NAME) -- works in PostgreSQL or OracleSQL
FROM employees;

SELECT concat(upper(substr(FIRST_NAME, 1, 1)), lower(substr(FIRST_NAME, 2))) AS initcap, FIRST_NAME -- works in PostgreSQL or OracleSQL
FROM employees; -- turns it into capital case

-- replace
SELECT replace(FIRST_NAME, 'a', 'Y') FROM employees;
SELECT replace(FIRST_NAME, 'a', 'Y') AS replaced_str, FIRST_NAME FROM employees;

-- reverse
SELECT reverse(FIRST_NAME) FROM employees;
SELECT reverse(FIRST_NAME) AS reversed_name, FIRST_NAME FROM employees;

-- locate
SELECT locate('ell', FIRST_NAME) FROM employees;
SELECT locate('ell', FIRST_NAME) AS position_of_ell, FIRST_NAME FROM employees;

-- find_in_set
SELECT DEPARTMENT_ID FROM departments
WHERE find_in_set('IT', DEPARTMENT_NAME);
SELECT find_in_set() FROM employees;

-- 
use hr;

-- avg()
SELECT avg(SALARY) FROM employees;
SELECT avg(SALARY) AS average FROM employees;

-- sum()
SELECT sum(SALARY) FROM employees;
SELECT sum(SALARY) AS sum FROM employees;

-- count()
SELECT count(*) FROM employees;
SELECT count(*) AS employee_count FROM employees;

-- min(), max()
SELECT min(SALARY), max(SALARY) FROM employees;
SELECT min(SALARY) AS min_salary, max(SALARY) AS max_salary FROM employees;

-- isnull()
SELECT FIRST_NAME FROM employees WHERE isnull(SALARY);
SELECT FIRST_NAME AS null_in_fname FROM employees WHERE isnull(SALARY);

-- least()
SELECT least(SALARY, 7000) FROM employees;
SELECT least(SALARY, 7000) AS salary_atmost_7k FROM employees;

-- greatest()
SELECT greatest(SALARY, 7000) FROM employees;
SELECT greatest(SALARY, 7000) AS salary_atleast_7k FROM employees;

-- NULL
SELECT SALARY FROM employees WHERE SALARY=NULL;
SELECT SALARY AS null_salaries FROM employees WHERE SALARY=NULL;

-- LIKE
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE 's%'; -- searches  for starting with 's'
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%a'; -- searches  for ending with 'a'
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '%a%'; -- searches  for containing  'a'
SELECT FIRST_NAME FROM employees WHERE FIRST_NAME LIKE '_a%'; -- searches  where second character is 'a'

--  CASE statement
SELECT FIRST_NAME, LAST_NAME, SALARY,
CASE
    WHEN SALARY<=6000 THEN SALARY*.10
    WHEN SALARY<=10000 THEN SALARY*.20
    WHEN SALARY<=20000 THEN SALARY*.30
    ELSE SALARY*.5
END AS bonus
FROM employees;

-- Problem / challenge
-- write a query to show bonus of employees who are working in a particular dept
-- if the employee is working in marketing dept and earns less than 6000, then add bonus of 5%
-- if the employee is working in hr department and have salary less than 5000 than add bonus of 6%
-- if the employee is working in IT dept, and earns more than 10,000 then add bonus of 10%
-- 
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM employees employees WHERE DEPARTMENT_ID IN (20, 40, 60);

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY, 
CASE
    WHEN SALARY<=6000 AND DEPARTMENT_ID=20 THEN SALARY*0.05 -- marketing dept
    WHEN SALARY<=5000 AND DEPARTMENT_ID=40 THEN SALARY*0.06 -- HR dept
    WHEN SALARY>=10000 AND DEPARTMENT_ID=60 THEN SALARY*0.5 -- IT dept
END AS bonus
FROM employees WHERE DEPARTMENT_ID IN (20, 40, 60);
-- 
-- 
select first_name,last_name,salary,
case
    when salary <=6000 and department_id = 20 then salary*.05
    when salary <=5000 and department_id = 40 then salary*.06
    when salary >=10000 and department_id = 60 then salary*.10
end as bonus
from employees;

SELECT FIRST_NAME, LAST_NAME, SALARY, 
CASE
    WHEN DEPARTMENT_ID=60 AND SALARY>10000 THEN SALARY*0.50
    WHEN DEPARTMENT_ID=20 AND SALARY<6000 THEN SALARY*0.050
    WHEN DEPARTMENT_ID=40 AND SALARY<5000 THEN SALARY*0.060
    ELSE 1
END AS bonus
FROM employees WHERE DEPARTMENT_ID IN (20, 40, 60);
-- problem / challenge
-- write a query for student table considering that equal students have scored marks
-- below 8 then fail
-- below 16 in lab then
-- in lab between 35-40 then score is very good

-- LIMIT
SELECT * 
FROM employees 
LIMIT 10;

-- OFFSET
SELECT * 
FROM employees 
LIMIT 2 OFFSET 10;

-- distinct
SELECT distinct(FIRST_NAME) 
FROM employees;

-- ORDER BY
SELECT SALARY 
FROM employees 
ORDER BY SALARY;

SELECT SALARY 
FROM employees 
ORDER BY SALARY DESC;
```
