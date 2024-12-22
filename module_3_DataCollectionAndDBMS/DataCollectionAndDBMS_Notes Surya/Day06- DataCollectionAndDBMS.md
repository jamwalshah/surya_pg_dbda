# Day06- DataCollectionAndDBMS

## Sub-Query

1. A sub-query is a query which is nested within another query
2. Also called as **Inner-Queries**
3. It is used to retrieve data from one or more tables and use a result of query as condition/criteria for another table in outer query
4. Sub-queries help in executing queries with dependency on the output of another query
5. Sub-queries are enclosed in parenthesis `( )`
6. It can be used with `SELECT`, `FROM`, `WHERE`, `HAVING` clauses
7. Sub-query is executed first before the execution of the outer query
8. We can write almost 255 levels of sub-queries

    > Larger the number of sub-queries, slower the execution time

9. `JOIN` is faster than sub-queries
10. In sub-queries, we use operators like `IN`(logical OR), `ANY`(logical OR), `ALL`(logical AND)

### Benefits of Sub-queries

1. **Modularity:** Sub-queries break down complex problems into simpler parts
2. **Flexibility:** You can query a dataset and use it dynamically in another query
3. **Readability:** They can improve the clarity of a query, making it easier to understand, compared to writing all the logic in one query

### Limitations of Sub-Queries

1. **Performance:** In some cases, Sub-Queries can be inefficient because they may require repeated executions of the Inner-query for each row of the Outer-query. This can be mitigated by using `JOIN` or optimizing sub-queries
2. **Nested Limits:** Some database systems impose a limit on the number of sub-queries or the depth of nested queries. e.g. MySQL has a limit of 256 sub-query depth

### Types of Sub-queries

1. Scalar Sub-queries
2. Row Sub-queries
3. Column Sub-queries
4. Multiple Row Sub-queries

#### 1. Scalar Sub-queries

1. These return a single value (one row or one column)
2. These are often used in `SELECT` or `WHERE` or `HAVING` or `FROM` clause and a comparison operator

    > **Note:** The inner-query is independent of the outer query and gives a meaningful result by running on its own (it is a non-correlated sub-query)

3. Scalar sub-queries can be used with the `WHERE` or `HAVING` clause to filter the results of the Outer-query
4. Example:

    ```sql
    SELECT EMPLOYEE_ID, 
        CONCAT(FIRST_NAME, ' ', LAST_NAME) AS employee_name, 
        SALARY , (SELECT AVG(SALARY)     -- in SELECT statement
            FROM employees) AS avg_salary
    FROM employees ;
    ```

    ```sql
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY 
    FROM employees
    WHERE SALARY > (SELECT AVG(SALARY)     -- similar usage in WHERE or HAVING or FROM clause to filter results in Outer-query
        FROM employees) ;
    ```

#### 2. Row Sub-queries

1. These returns a single row as an output to their parent query, and thus can return more than one column values in a row, which can be used with operators like `IN`, `NOT IN` `ANY`, `ALL`
2. Example:

    ```sql
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM employees
    WHERE ROW(DEPARTMENT_ID, MANAGER_ID) IN (SELECT DEPARTMENT_ID, MANAGER_ID
        FROM departments 
        WHERE LOCATION_ID = 2500) ;
    ```

    ```sql
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM employees
    WHERE (DEPARTMENT_ID, MANAGER_ID) IN (SELECT DEPARTMENT_ID, MANAGER_ID
        FROM departments 
        WHERE LOCATION_ID = 2500) ;
    ```

#### 3. Column Sub-queries

1. These return a single column of multiple values to their parent query
2. Example:

    ```sql
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM employees
    WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
        FROM departments 
        WHERE LOCATION_ID = 2500) ;
    ```

#### 4. Multiple Row Sub-queries

1. THese return multiple rows, which can be used in `HAVING` clause, `WHERE` clause, `FROM` clause, along with some logical operators like `IN`, `NOT IN` `ANY`, `ALL`
2. Example:

    ```sql
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM employees
    WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
        FROM departments 
        WHERE LOCATION_ID = 2500) ;
    ```

### Correlated and Non-Correlated Sub-Queries

#### 1. Non-Correlated Sub-Queries

1. These do not reference any columns of the Outer-query
2. These can be executed independently of the Outer-query
3. Example:

    ```sql
    SELECT EMPLOYEE_ID, SALARY 
    FROM employees
    WHERE SALARY > (SELECT AVG(SALARY) 
        FROM employees) ;
    ```

#### 2. Correlated Sub-Queries

1. These reference one or more columns from the Outer-query
2. They cannot be executed independently, as they depend on the Outer-query
3. Example:

    ```sql
    SELECT EMPLOYEE_ID, 
        DEPARTMENT_ID, SALARY, (SELECT MAX(SALARY) 
            FROM employees
            WHERE DEPARTMENT_ID = e.DEPARTMENT_ID) as max_salary
    FROM employees e;
    ```

### Sub-query in `SELECT` clause

1. A subquery can be used to return a value in the result set for each row
2. Syntax:

    ```sql
    SELECT <column1_name>, (SELECT <agg_func>(<column1_name>) 
        FROM <table1> 
        WHERE <column2_name> = t1.<column2_name>)
    FROM <table1> t1;
    ```

3. Example:

    ```sql
    SELECT EMPLOYEE_ID,
        CONCAT(FIRST_NAME, ' ', LAST_NAME) AS employee_name, 
        SALARY , DEPARTMENT_ID, (SELECT MAX(salary) 
            FROM employees 
            WHERE department_id = e.department_id) AS max_salary_in_dept
    FROM employees e
    ORDER BY DEPARTMENT_ID;
    ```

### Sub-query in `WHERE` clause

1. This is the most common use of sub-queries
2. A sub-query can be used to filter rows in the main query
3. Syntax:

    ```sql
    SELECT <column_name> 
    FROM <table1_name> 
    WHERE <column_name> [= | > | < | >= | <= | != | NOT | IN] (SELECT <column_name> 
        FROM <table2_name>) ;
    ```

4. Example:

    ```sql
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
    FROM employees
    WHERE DEPARTMENT_ID IN 
        (SELECT DEPARTMENT_ID 
        FROM departments 
        WHERE LOCATION_ID = 2500) ;
    ```

### Sub-query in `FROM` clause

1. Sub-queries can also be used in the `FROM` clause to create temporary table that is referenced in the Outer-query
2. Syntax:

    ```sql
    SELECT <column_name> 
    FROM (SELECT <column_name> 
        FROM <table2>) 
    WHERE <condition>;
    ```

3. Example:

    ```sql
    SELECT tmp_tbl.DEPARTMENT_ID, SUM(tmp_tbl.SALARY)
    FROM (SELECT DEPARTMENT_ID, SALARY
        FROM employees ) AS tmp_tbl
    GROUP BY tmp_tbl.DEPARTMENT_ID ;
    ```

### Rules to write Subqueries

1. A subquery must be enclosed in parenthesis `( )`
2. A subquery cannot return more than one column, but you may return them as a `ROW`
3. A subquery can return only one row in most cases, however we can use some clauses like `IN`, `ANY`, which will allow sub-query to return multiple rows
4. A subquery can be used in various clauses like `SELECT`, `FROM`, `WHERE`, `HAVING`, `DELETE`
5. Syntax of subquery will vary depending on the clause we have used
6. A subquery can be nested to multiple levels, but this can make the query more complex and harder to understand
7. A subquery slows down the query execution time. In order to have better performance, we need to optimize subqueries by rewriting them in an efficient manner possible

## Views
