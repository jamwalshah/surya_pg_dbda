# Day07- DataCollectionAndDBMS

## Indexes

1. An index is a database object used to speed up the retrieval of rows from a table or view.
2. Indexes are created on columns to enable faster lookup, sorting and joins, essentially reducing the time it takes to search through large datasets
3. An index uses data structures such as B-Trees, which improves the speed of data retrieval on a table at the cost of additional rights and storage to maintain
4. Indexes are quick to locate the data, without having to scan every row in a table for a given query
5. While creating index, one must choose the appropriate column to improve the performance of retrieval
6. It is important to use the index wisely, as it may lead to impact performance of write operations such as `INSERT`, `UPDATE` or `DELETE`

### Advantages of Using Indexes

1. **Faster Query Performance:** Indexes speed up the retrieval of data, especially for large tables
2. **Improved Sorting and Filtering:** Indexes help with `ORDER BY`, `GROUP BY`, `JOIN` and `WHERE` clauses
3. **Enhanced Uniqueness Enforcement:** They enforce data integrity in primary and unique key constraints

### Disadvantages of Using Indexes

1. **Slower Data Modification:** Inserting, updating and deleting data becomes slower because indexes need to be updated whenever data changes
2. **Storage Overhead:** indexes take up extra disk space
3. **Complexity:** Managing multiple indexes can complicate database maintenance

### Best Practices for Using Indexes

1. Use indexes on columns that are frequently queried (in `WHERE`, `JOIN`, `ORDER BY`, etc.)
2. Avoid over indexing, too many indexes can degrade performance, especially on data modification operations
3. Consider composite indexes when multiple columns are frequently used together in queries
4. Analyze query performance to see if existing indexes are being used and to identify opportunities for new indexes

### Indexing Mechanisms

1. Clustered Index
2. Non-Clustered Index

#### 1. Clustered Index

1. A clustered index determines the **physical order of the data rows** in a table, so table's data is stored on the disk in the same order as the index
2. Essentially, a clustered index means that the data rows themselves are the index
3. Example:

    ```sql
    CREATE TABLE `countries` (
    `COUNTRY_ID` varchar(2) NOT NULL,
    `COUNTRY_NAME` varchar(40) DEFAULT NULL,
    `REGION_ID` decimal(10,0) DEFAULT NULL,
    PRIMARY KEY (`COUNTRY_ID`),   -- clustered index on COUNTRY_ID
    KEY `COUNTR_REG_FK` (`REGION_ID`)
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1 ;
    ```

- **Default (Clustered Index):** In MySQL (InnoDB storage engine), the primary key of the table is always a clustered index. If you don't explicitly define a primary key, MySQL will automatically choose the first unique, non-nullable index as the clustered index
- **Single Clustered Index per Table:** Since the data is physically stored in the order of the clustered index, only one clustered index can exist per table. This is because the data can only be ordered in one way

##### Characteristics of CLustered Index

1. **Data Storage:** Data rows are stored in the leaf nodes of the index tree, meaning the data is stored in the same order as the index
2. **Speed:** It is generally faster for queries that retrieve ranges of data based on the indexed column
3. **Efficiency:** Accessing the table through the clustered index is very efficient because the data is stored in the same order as the index

#### 2. Non-Clustered Index

1. A non-clustered index is a separate structure from the data table
2. It does not alter the physical storage of the data rows. Instead, it creates a logical structure that maps the indexed columns to the actual data rows
3. Example:

    ```sql
    CREATE INDEX idx_phone  -- non-clustered index on PHONE_NUMBER column
        ON employees(PHONE_NUMBER);
    ```

- **Multiple Non-Clustered Indexes:** You can have multiple non-clustered indexes on a single table, as they don't affect the physical storage of data, they are stored separately from the table data
- **Separate Storage:** The non-clustered index contains the indexed column(s) and a pointer to the corresponding data rows in the table

##### Characteristics of Non-Clustered Index

- **Data Storage:** Non-clustered indexes are stored separately from the data, the index contains the indexed column value and a pointer to the row in the table
- **Speed:** Non-clustered indexes are beneficial for quickly retrieving specific rows or values, but accessing the data requires an additional lookup (via pointers) from the index to the actual data
- **Flexibility:** You can create multiple non-clustered indexes on different columns of a table

#### Interview Challenge: Clustered Indexes vs. Non-Clustered Indexes

| Feature | Clustered Index | Non-Clustered Index |
| :-- | :-- | :-- |
| **Definition** | Data rows are stored in the order of the index | Index is stored separately from the data |
| **Physical Storage** | The data itself is organized based on the clustered index | Index is stored in a separate structure from the table |
| **Number per Table** | One clustered index per table | Multiple non-clustered indexes can be created |
| **Data Sorting** | Data is sorted on disk according to the clustered index | Data is not physically sorted |
| **Speed (Insert/Update/Delete)** | Slower for Inserts/Updates, as data has to be reorganized | Faster for Inserts/Updates, as data is stored independently |
| **Example** | Primary key (default) or unique key (if no primary key)  | Index on columns like *age*, *email*, etc. |
| **Use Case** | Best for primary key, often queried fields | Best for non-primary key fields, or other frequently queried columns |

### Types of Indexes

1. B-Tree Index
2. R-Trees Index / Spatial Index
3. Hash Index
4. Full Text Index

#### 1. B-Tree Index

#### 2. R-Trees Index / Spatial Index

#### 3. Hashed Index

#### 4. Full Text Index
