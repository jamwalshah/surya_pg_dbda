# Day05- DataCollectionAndDBMS

## DDL (Data Definition Language)

1. DDL is a subset of SQL commands that are used to define and manage the **structure** of a database, including creation, modification or deletion of database objects like tables, indexes, views, and schemas
2. it focuses on structure and organization of the database itself
3. DDL statements are typically non-transactional in most databases (however newer versions might differ), meaning once a DDL operation is executed, it is committed immediately and cannot be rolled back
4. DDL is used for database schema changes
5. These are the foundations to the database administration and management
6. Common DDL commands are
    1. `CREATE`
    2. `ALTER`
    3. `DROP`
    4. `TRUNCATE`
    5. `RENAME`
    6. `COMMENT`

### 1. `CREATE` statement

1. It is used to create new database objects such as tables, views, indexes and schemas
2. To use any data from a table, first we need to create a database using `CREATE DATABASE` command
    1. Syntax:

        ```sql
        CREATE DATABASE <database_name>;
        ```

    2. Example:

        ```sql
        CREATE DATABASE hr;
        ```

3. The `CREATE TABLE` statement is used to create a new table in a database.
    1. Syntax:

        ```sql
        CREATE TABLE <table_name> (
            <column1_name> <datatype>,
            <column2_name> <datatype>,
            <column3_name> <datatype>,
            ...
        );
        ```

    2. Example:

        ```sql
        CREATE TABLE IF NOT EXISTS `countries` (
            `COUNTRY_ID` varchar(2) NOT NULL,
            `COUNTRY_NAME` varchar(40) DEFAULT NULL,
            `REGION_ID` decimal(10,0) DEFAULT NULL,
            PRIMARY KEY (`COUNTRY_ID`),
            KEY `COUNTR_REG_FK` (`REGION_ID`)
        ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
        ```

4. To `CREATE TABLE` using another table / **Create Table As Select (`CTAS`)**
    1. The structure of new table is created on basis of  the `SELECT` statement
    2. When `SELECT` is executed, the output of the `SELECT` statement will be inserted into the new table
    3. If you don't use `WHERE` clause, all the records will be copied into the new table
    4. Syntax:

        ```sql
        CREATE TABLE <new_table_name> AS
            SELECT <column1>, <column2>, ...
            FROM <existing_table_name>
            WHERE ... ;
        ```

    5. Example:

        ```sql
        CREATE TABLE employeescopy AS
            SELECT *
            FROM employees;
        ```

### 2. `ALTER` statement

1. It is used to make changes in a table using `ADD`, `RENAME`/`CHANGE`, `MODIFY`, `DROP` keywords
2. Using ALTER, you can
    1. `RENAME` a column
    2. `ADD` a column to the table
    3. `DROP` a column
    4. `MODIFY` a table/column to
        1. increase/decrease the width of a column
        2. change data type of a column
        3. copy a table
        4. copy the structure of a table
        5. change position of column in the table structure
3. `ADD`, `RENAME`/`CHANGE`, `MODIFY`, `DROP` clauses helps you in `ALTER` command

    > **Tip:** Data will be truncated if you try to insert more than the new/modified size

#### 4. `ADD` a column

1. To add a new column to an existing table
2. Syntax:

    ```sql
    ALTER TABLE <table_name>
    ADD <column_name> <data_type>;
    ```

3. Example:

    ```sql
    ALTER TABLE employeescopy 
    ADD age INT DEFAULT 18; -- ALTER command to ADD COLUMN `age` with default value 18
    
    DESC employees; -- to describe the table employees after altering
    ```

#### 5. `RENAME`/`CHANGE` a column

1. To `RENAME`/`CHANGE` the name of an existing column
2. Syntax:

    ```sql
    -- MySQL
    ALTER TABLE <table_name>
        CHANGE COLUMN <old_column_name> <new_column_name> <column_definition>;
    -- PostgreSQL/Oracle
    ALTER TABLE <table_name>
        RENAME COLUMN old_column_name TO <new_column_name>;
    ```

3. Example:

    ```sql
    -- MySQL
    ALTER TABLE employeescopy 
        CHANGE COLUMN age min_age INTEGER DEFAULT 20;
    -- PostgreSQL/Oracle
    ALTER TABLE employeescopy
        RENAME COLUMN age TO min_age;
    ```

#### 6. `RENAME` a table

1. This command will rename the table (renaming a table is not recommended)
2. Syntax:

    ```sql
    ALTER TABLE <old_table_name>
        RENAME TO <new_table_name>;
    ```

3. Example:

    ```sql
    ALTER TABLE employeescopy 
        RENAME TO employeescpy;
    ```

#### 7. `MODIFY` a column

1. To Change the Data type or size of an existing column
    1. Syntax:

        ```sql
        ALTER TABLE <table_name> 
            MODIFY <column_name> <column_definition>;
        ```

    2. Example:

        ```sql
        ALTER TABLE employeescpy
            MODIFY min_age VARCHAR(10);
        ```

#### 8. `DROP` a column

1. To remove a column from a table
2. Syntax:

    ```sql
    ALTER TABLE <table_name> 
        DROP COLUMN <column_name>;
    ```

3. Example:

    ```sql
    ALTER TABLE employeescpy 
        DROP COLUMN min_age;
    ```

#### 9. `ADD` or `DROP` `CONSTRAINTS`

1. You can `ADD` or `DROP` a `CONSTRAINT` using `ALTER` command

##### 2. `ADD` a `CONSTRAINT`

1. You can add constraints such as `PRIMARY KEY`, `FOREIGN KEY`, etc. using `ALTER` command
2. Syntax:

    ```sql
    ALTER TABLE <table_name>
        ADD CONSTRAINT [<pk_constraint_name>]   -- for PRIMARY | FOREIGN | UNIQUE | CHECK
            [PRIMARY KEY (<column_name>)][FOREIGN KEY (<column_name>) REFERENCES table_2 (<column2_name>)][UNIQUE (<column_name>)][CHECK (<condition>)]
        ALTER COLUMN <column_name>  -- for DEFAULT
            SET DEFAULT <default_value>
        MODIFY <column_name> <data_type> NOT NULL ; -- for NOT NULL
    ```

3. Example:

    ```sql
    ALTER TABLE departmentscpy
        ADD CONSTRAINT 
            PRIMARY KEY (DEPARTMENT_ID);
    ```

##### 3. `DROP` a `CONSTRAINT`

1. You can drop existing constraints such as `PRIMARY KEY`, `FOREIGN KEY`, etc. using `ALTER` command
2. Syntax:

    ```sql
    ALTER TABLE <table_name>
        DROP [[PRIMARY][FOREIGN] KEY][INDEX][CONSTRAINT] [<constraint_name>]    -- for PRIMARY | FOREIGN | UNIQUE | CHECK
        ALTER COLUMN <column_name> DROP DEFAULT    -- for DEFAULT
        MODIFY COLUMN <column_name> <column_definition> NULL;   -- for NOT NULL
    ```

3. Example:

    ```sql
    ALTER TABLE departmentscpy
        DROP PRIMARY KEY;
    ```

#### 10. Change table properties or storage parameters

1. In some RDBMS, `ALTER` command can be used to modify storage properties like table partitions
2. Example:

    ```sql
    ALTER TABLE my_table 
        ENGINE = InnoDB;
    ```

### 3. `DROP` statement

1. It removes entire objects from database, such as tables, views, indexes or even entire databases
2. This command cannot be undone once executed, thus irreversible
3. All the data stored in the object will be lost permanently
4. The user must have appropriate permissions (such as `DROP` privileges) to execute the `DROP` command on a specific object
5. You may use `DROP COLUMN` command with `ALTER` command to remove a column from an existing table, as shown in [DROP a column](#8-drop-a-column)
6. Syntax:

    ```sql
    DROP [TABLE][DATABASE][VIEW][INDEX] <object_name>;
    ```

7. Example:

    ```sql
    DROP TABLE employeescpy -- removes database
    DROP VIEW IT_dept_employees_view;   -- removes view
    DROP INDEX idx_employee_id ON employees; -- removes index from table employees
    DROP DATABASE hr2;  -- removes database
    ```

### 4. `TRUNCATE` statement

1. It removes all the rows from a table while keeping the table structure intact for future use
2. It is similar to `DELETE` operation, and faster than `DELETE` operation, as it does not has to deal with `WHERE` condition (searching of a particular record)
3. `TRUNCATE` operation is non-transactional and cannot be rolled back especially in older MySQL (but newer versions support it within transactions)
4. It simply de-allocates the data pages, making it more efficient & fast to delete all records compared to a `DELETE` statement, especially for large tables
5. It resets auto-increment in MySQL, but table structure (columns, constraints, etc.) remain intact
6. No trigger is fired, because it is a DML operation
7. You'll typically need `DROP` privileges to execute `TRUNCATE`
8. If a table is referenced by a `FOREIGN KEY` constraint, then `TRUNCATE` cannot be executed on that table unless those constraints are disabled or referencing table is truncated first
9. Syntax:

    ```sql
    TRUNCATE TABLE <table_name>;
    ```

10. Example:

    ```sql
    TRUNCATE TABLE employees;
    ```

### 5. `RENAME` statement

1. Sometimes we may want to rename our table to give it a more relevant name. For this purpose we can use `RENAME` command to rename the name of the table (in newer versions of MySQL).
2. Syntax:

    ```sql
    RENAME TABLE <old_table_name> TO <new_table_name>;
    ```

3. Example:

    ```sql
    RENAME TABLE employeescpy TO employeescopy;
    ```

4. This above syntax works in newer versions of MySQL, but to work with older versions of MySQL, you may use the `ALTER TABLE` syntax to rename a table as shown in [RENAME TABLE](#6-rename-a-table)

## DQL (Data Query Language)

1. DQL is a subset of SQL that focuses on querying data from databases
2. Primary purpose of DQL is to retrieve data and retrieve it in a specific way, without modifying the actual data in the database
3. Most commonly used DQL statement is `SELECT` statement, which is used to query the database and retrieve information

### 1. `SELECT` statement

1. We can retrieve data from one or more tables in a database using `SELECT` statement
2. Here `*` will give the output, all of the records along with their attributes will be displayed
3. Syntax:

    ```sql
    SELECT column1, column2, ... 
    FROM <table_name>
    [WHERE <condition>]
    [GROUP BY <column1> [HAVING <condition>]]
    [ORDER BY <column2> [DESC]]
    [LIMIT <n> [OFFSET <m>]];
    ```

4. Example:

    ```sql
    SELECT * 
    FROM employees;
    ```

## DML (Data Manipulation Language)

1. DML is a subset of SQL used for managing and manipulating **data** within database objects such as tables.
2. Unlike DDL which defines the structure of the database, DML focuses on the actual data stored in the database
3. DML is focused on non-structural changes, manipulating data within the existing database structure, rather than altering the structure itself
4. DML commands are typically used within transactions, i.e., you can commit or roll back changes
5. `WHERE` clause is often used in DML operations to specify which rows should be affected, to avoid unintentional changes to the entire table
6. Common DML commands are
    1. `INSERT`
    2. `UPDATE`
    3. `DELETE`
    4. `MERGE`

### 1. `INSERT` statement

### 2. `UPDATE` statement

### 3. `DELETE` statement

### 4. `MERGE` statement
