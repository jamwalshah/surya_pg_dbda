# Day05- DataCollectionAndDBMS

## DDL (Data Definition Language)

1. `CREATE` statement
    1. To use any data from a table, first we need to create a database using `CREATE DATABASE` command
        1. Syntax to create database:

            ```sql
            CREATE DATABASE <database_name>;
            ```

        2. Example to create database:

            ```sql
            CREATE DATABASE hr;
            ```

    2. The `CREATE TABLE` statement is used to create a new table in a database.
        1. Syntax to create table:

            ```sql
            CREATE TABLE <table_name> (
                <column1_name> <datatype>,
                <column2_name> <datatype>,
                <column3_name> <datatype>,
                ...
            );
            ```

        2. Example to create table:

            ```sql
            CREATE TABLE IF NOT EXISTS `countries` (
                `COUNTRY_ID` varchar(2) NOT NULL,
                `COUNTRY_NAME` varchar(40) DEFAULT NULL,
                `REGION_ID` decimal(10,0) DEFAULT NULL,
                PRIMARY KEY (`COUNTRY_ID`),
                KEY `COUNTR_REG_FK` (`REGION_ID`)
            ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
            ```

    3. To `CREATE TABLE` using another table / **Create Table As Select (`CTAS`)**
        1. The structure of new table is created on basis of  the `SELECT` statement
        2. When `SELECT` is executed, the output of the `SELECT` statement will be inserted into the new table
        3. If you don;t use `WHERE` clause, all the records will be copied into the new table
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

2. `ALTER` statement:
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

    4. `ADD` a column
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

    5. `RENAME`/`CHANGE` a column
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

    6. `RENAME` a table
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

    7. `MODIFY` a column
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

    8. `DROP` a column
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

    9. `ADD` or `DROP` `CONSTRAINTS`
        1. You can `ADD` or `DROP` a `CONSTRAINT` using `ALTER` command
        2. `ADD` a `CONSTRAINT`
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

        3. `DROP` a `CONSTRAINT`
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

    10. Change table properties or storage parameters
        1. In some RDBMS, `ALTER` command can be used to modify storage properties like table partitions
        2. Example:

            ```sql
            ALTER TABLE my_table 
                ENGINE = InnoDB;
            ```

3. `DROP` statement
4. `TRUNCATE` statement
5. `RENAME` statement

## DQL (Data Query Language)
