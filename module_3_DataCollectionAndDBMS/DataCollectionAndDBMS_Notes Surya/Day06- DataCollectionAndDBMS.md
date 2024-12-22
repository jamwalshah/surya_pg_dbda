# Day06- DataCollectionAndDBMS

## Sub-Query

1. A sub-query is a query which is nested within another query
2. Also called as **Inner-Queries**
3. It is used to retrieve data from one or more tables and use a result of query as condition/criteria for another table in outer query
4. Sub-queries help in executing queries with dependency on the output of another query
5. Sub-queries are enclosed in parenthesis `( )`
6. It can be used with `SELECT`, `FROM`, `WHERE` clauses
7. Sub-query is executed first before the execution of the outer query
8. We can write almost 255 levels of sub-queries

    > Larger the number of sub-queries, slower the execution time

9. `JOIN` is faster than sub-queries
10. In sub-queries, we use operators like `IN`(logical OR), `ANY`(logical OR), `ALL`(logical AND)

### Types of Sub-queries

1. Scalar Sub-queries
2. Row Sub-queries
3. Column Sub-queries
4. Multiple Sub-queries

#### 1. Scalar Sub-queries

#### 2. Row Sub-queries

#### 3. Column Sub-queries

#### 4. Multiple Sub-queries

### Sub-query in `FROM` clause

1. Syntax:

    ```sql
    SELECT <column_name> 
    FROM 
        (SELECT <column_name> 
        FROM <table2>) 
    WHERE <condition>;
    ```

### Sub-query in `WHERE` clause

1. Syntax:

    ```sql
    SELECT <column_name> 
    FROM <table1_name> 
    WHERE <column_name> [= | > | < | >= | <= | != | NOT | IN] 
        (SELECT <column_name> 
        FROM <table2_name>) ;
    ```

### Sub-query in `HAVING` clause

1. Syntax:

    ```sql
    SELECT <column_name> 
    FROM <table1_name> 
    WHERE <condition> 
    GROUP BY <column_name> HAVING <column_name> [= | > | < | >= | <= | != ] 
        (SELECT <column_name> 
        FROM <table2_name>) ;

    ```

### Sub-query in `SELECT` clause

1. Syntax:

    ```sql
    -- SELECT <column1_name>,
    --    (SELECT MAX(salary) 
    --    FROM employees 
    --    WHERE department_id = e.department_id) AS max_salary_in_dept
    -- FROM employees e;

    ```
