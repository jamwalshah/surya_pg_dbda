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

### Rules to write Sub-queries

1. A subquery must be enclosed in parenthesis `( )`
2. A subquery cannot return more than one column, but you may return them as a `ROW`
3. A subquery can return only one row in most cases, however we can use some clauses like `IN`, `ANY`, which will allow sub-query to return multiple rows
4. A subquery can be used in various clauses like `SELECT`, `FROM`, `WHERE`, `HAVING`, `DELETE`
5. Syntax of subquery will vary depending on the clause we have used
6. A subquery can be nested to multiple levels, but this can make the query more complex and harder to understand
7. A subquery slows down the query execution time. In order to have better performance, we need to optimize sub-queries by rewriting them in an efficient manner possible

## Views

1. View are virtual tables that are based on the result of a query
2. They allow you to encapsulate complex queries and reuse them in different parts of your database applications
3. A view does not store data itself, rather it stores the SQL `SELECT` query that defines how the data should be retrieved
4. When you query a view, it runs the underlying query to generate the result dynamically
5. You cannot include DML statements like `INSERT`, `UPDATE` `DELETE` or `MERGE` within the view's definition, but views are not designed for data modification
6. Views are generally Read-Only, meaning you cannot directly perform `INSERT`, `UPDATE` or `DELETE` operations on data through a view unless it satisfies certain conditions
    1. The view must map directly into a single table (no joins or aggregations)
    2. The columns in the view must directly correspond to the columns in the underlying table
    3. The view should not contain any aggregate functions (e.g. `SUM`, `COUNT`, etc.)
    4. The view should not have a `GROUP BY` or `HAVING` clause
    5. The view should not have complex expressions or transformations on the data

7. A view is a logical entity, while a table is a physical entity, so you can create a view from another view/table, but if parent table is dropped then view becomes inaccessible

    ![table-view-hierarchy](../content/table-view-hierarchy.png)

8. Views are generally Read-Only, meaning you cannot directly Insert, Update or Delete data through a view unless it satisfies certain conditions
9. Example:

    ```sql
    CREATE VIEW employee_view AS
        SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
        FROM employees
        WHERE DEPARTMENT_ID <> 0 ;
    ```

### Uses of Views

1. **Simplify complex queries:** Use a view to encapsulate complicated joins or sub-queries that you need to use often
2. **Security:** Restrict access to sensitive data by exposing only a subset of columns or rows via views
3. **Data abstraction:** Create a level of abstraction, making it easier to maintain changes to the database schema without affecting application code that uses views

### Performance Considerations

1. **Performance Overhead:** Views are generally efficient, but since views do not store data, each time a view is queried, MySQL must execute the underlying `SELECT` query. This can add performance overhead, especially for complex queries with large data sets
2. **Indexing:** You cannot create indexes directly on a view in MySQL, as views do no store data. If performance is a concern, you might need to optimize the underlying tables or materialize the views manually by creating a table to store the query result
3. **Materialized Views:** MySQL does not support **materialized views** (views that store data), but you can manually create a table and populate it with the result of a query (which is a workaround for a materialized view)

### Advantages of Views in MySQL

1. **Data Abstraction:** Views provide a level of abstraction by hiding the complexity of queries
2. **Code Reusability:** You can reuse complex query logic across multiple applications or queries by querying the view
3. **Security:** Views can restrict the access to sensitive data by exposing only specific columns or rows
4. **Data Consistency:** Views ensure that the same query is used across different parts of the application, ensuring consistency

### Limitations of Views in MySQL

1. **Performance:** Views can add overhead if the underlying queries are complex or involve large datasets
2. **No Indexing on Views:** You cannot create indexes on views, so optimizing performance may require indexing the underlying tables
3. **Not always updatable:** Some views, especially those involving joins or aggregates, are not updatable, limiting their usefulness for modifying data

### `CREATE VIEW`

1. To create a view, you use the `CREATE VIEW` statement followed by the view's name and SQL query that defines it
2. Syntax:

    ```sql
    CREATE VIEW <view_name> AS 
        SELECT <column1>, <column2>, ... 
        FROM <table_name> 
        WHERE <condition> ;
    ```

3. Example:

    ```sql
    CREATE VIEW sal_emp_view AS -- basic VIEW
        SELECT FIRST_NAME, SALARY, DEPARTMENT_ID 
        FROM employees 
        WHERE SALARY > 10000 ;
    ```

    ```sql
    CREATE VIEW emp_count_by_dept_view1 AS  -- GROUP BY VIEW
        SELECT DEPARTMENT_ID, count(*) 
        FROM employees 
        GROUP BY DEPARTMENT_ID ;
    ```

    ```sql
    CREATE VIEW join_view1 AS   -- JOIN VIEW
        SELECT e.FIRST_NAME, d.DEPARTMENT_NAME, e.SALARY 
        FROM employees e 
        JOIN departments d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID ;
    ```

    ```sql
    CREATE VIEW subquery_view1 AS   -- Sub-query VIEW
        SELECT max(SALARY) 
        FROM employees 
        WHERE SALARY < (SELECT max(SALARY) 
            FROM employees) ;
    ```

### Querying a View

1. Once a view is created, you can query it like a regular table
2. Syntax:

    ```sql
    SELECT <column1_name>, <column2_name> 
    FROM <view_name>;
    ```

3. Example:

    ```sql
    SELECT * 
    FROM sal_emp_view ;
    ```

### DML operations on data through View

1. Generally DML operation on data is not possible using views unless it satisfies some criteria
2. The common conditions that a `VIEW` should satisfy are
    1. 

#### `INSERT` data through View

1. In general, you cannot `INSERT` data into a view unless it satisfies specific criteria.
2. Views are primarily read-only, and inserting into a view is allowed only if
    1. The view is based on a single table
    2. The view doesn't involve aggregations, joins or GROUP BY clauses
    3. All non-nullable columns in the underlying table are covered by the view, i.e., the view must expose all the columns that require a value when inserting
3. Example:

    ```sql
    ```

#### `UPDATE` data through View

1. Like `INSERT`, you can only update data through a view if the view meets specific conditions
    1. The view must map to a single table

#### `DELETE` data through View

1. You can also `DELETE` data through a view under similar conditions as `INSERT` and `UPDATE`
2. The view should satisfy the common conditions as well as some conditions specific to `DELETE` operation on data using `VIEW`

### Alter View

1. In MySQL, you **cannot directly alter a view** once it is created. However, you can modify a view using the `CREATE OR REPLACE VIEW` statement, which replaces the existing view with a new definition
2. Syntax:

    ```sql
    CREATE OR REPLACE VIEW <view_name> AS 
        SELECT <column1>, <column2>, ... 
        FROM <table_name> 
        WHERE <condition> ;
    ```

3. Example:

    ```sql
    CREATE OR REPLACE VIEW sal_emp_view AS
        SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
        FROM employees
        WHERE SALARY > 10000 ;
    ```

### `DROP VIEW`

1. To remove a view from the database, use the `DROP VIEW` statement
2. Syntax:

    ```sql
    DROP VIEW <view_name> ;
    ```

3. Example:

    ```sql
    DROP VIEW sal_emp_view ;
    ```
