# Day 13 - BigDataTechnologies

- tart hive CLI using command below, it launches hive interactive shell which is Hive CLI

    ```bash
    [bigdatalab456422@ip-10-1-1-204 ~]$ hive
    ```

    ```console
    WARNING: Use "yarn jar" to launch YARN applications.
    SLF4J: Class path contains multiple SLF4J bindings.
    SLF4J: Found binding in [jar:file:/opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/jars/log4j-slf4j-impl-2.8.2.jar!/org/slf4j/impl/StaticLoggerBinder.class]
    SLF4J: Found binding in [jar:file:/opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/jars/slf4j-log4j12-1.7.25.jar!/org/slf4j/impl/StaticLoggerBinder.class]
    SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
    SLF4J: Actual binding is of type [org.apache.logging.slf4j.Log4jLoggerFactory]
    2023-05-30 09:54:50,539 main WARN JNDI lookup class is not available because this JRE does not support JNDI. JNDI string lookups will not be available, continuing configuration. Ignoring java.lang.ClassNotFoundException: org.apache.logging.log4j.core.lookup.JndiLookup

    Logging initialized using configuration in jar:file:/opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/jars/hive-common-2.1.1-cdh6.2.1.jar!/hive-log4j2.properties Async:false

    WARNING: Hive CLI is deprecated and migration to Beeline is recommended.
    hive>
    ```

- Run command below to set Hive CLI to print current DB

    ```sql
    hive> SET hive.cli.print.current.db = true ;
    ```

- Run command below to use the `surya_training` database

    ```sql
    hive (default)> USE surya_training ;
    ```

    ```console
    OK
    Time taken: 0.029 seconds
    hive (surya_training)>
    ```

## Types of Tables in Hive

```text
Types of tables

1) managed table
2) external

User define function
```

### Managed Tables

1. Created by default by hive
2. If you drop a Managed table, you also lose/delete the data as well as the schema from the Hive Metastore
3. If someone is accessing the data from a Managed table that is deleted, the data becomes inaccessible to the User
4. Managed table data and its Hive Metadata are managed by Hive
5. Data is stored in `/databaseName/tableName/` inside our warehouse by default, which is essentially a location in HDFS
6. Managed tables support `TRUNCATE` as data and  the Hive Metadata for table, are both managed by Hive
7. These also support ACID Transactions, using ORC file format by default
8. These also support Query Result Caching, means it can store the result of the already executed Hive Query, for a subsequent query
9. Table data and its Hive Metastore containing table schema will be removed as soon as the table is dropped

> Managed tables are not used when data is stored externally, outside of Hive and accessed by other Hadoop tools on HDFS

#### `DESC` the table `txnrecords`

- Use the `DESC` command on `txnrecords` table and notice that it shows that it is a `MANAGED_TABLE` in `Table Type:` field using the command below, also note the table path which will be used further

    ```sql
    hive (surya_training)> DESC FORMATTED txnrecords ;
    ```

    ```console
    OK
    # col_name              data_type               comment

    txnno                   int
    txndate                 string
    custno                  int
    amount                  double
    category                string
    product                 string
    city                    string
    state                   string
    spendby                 string

    # Detailed Table Information
    Database:               surya_training
    Owner Type:             USER
    Owner:                  bigdatalab456422
    CreateTime:             Mon May 29 09:29:46 UTC 2023
    LastAccessTime:         UNKNOWN
    Retention:              0
    Location:               hdfs://nameservice1/user/bigdatalab456422/sales
    Table Type:             MANAGED_TABLE
    Table Parameters:
            transient_lastDdlTime   1685352586

    # Storage Information
    SerDe Library:          org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe
    InputFormat:            org.apache.hadoop.mapred.TextInputFormat
    OutputFormat:           org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat
    Compressed:             No
    Num Buckets:            -1
    Bucket Columns:         []
    Sort Columns:           []
    Storage Desc Params:
            field.delim             ,
            serialization.format    ,
    Time taken: 0.088 seconds, Fetched: 35 row(s)
    hive (surya_training)>
    ```

- Now you may list tables to track down exactly which tables exist right now because we'll delete `txnrecords` table later which is a Managed Table to see its behavior upon deletion

    ```sql
    hive (surya_training)> SHOW TABLES ;
    ```

    ```console
    OK
    customer
    nyse
    stkvol
    txn_bucket
    txn_orc
    txn_parquet
    txnrecords
    txnrecsbycat
    txnrecsbycat2
    txnrecsbycat3
    txnrecsbycat4
    Time taken: 0.035 seconds, Fetched: 11 row(s)
    hive (surya_training)>
    ```

#### Open the table location in Hue

- So our table `txnrecords` should exist in its table location that we got FROM `DESC FORMATTED` command earlier, so open the `Hue` tool and visit the path at `/user/bigdatalab456422/sales` to see what are the contents of this table path

  ![Hue-_user_bigdatalab456422_sales_contentManagedTable](../content_BigDataTechnologies/Hue-_user_bigdatalab456422_sales_contentManagedTable.png)

#### `DROP` the table `txnrecords`

- Now we'll `DROP` the table `txnrecords` to observe its behavior upon deletion

    ```sql
    hive (surya_training)> DROP TABLE txnrecords ;
    ```

    ```console
    OK
    Time taken: 0.165 seconds
    hive (surya_training)>
    ```

- Now list all the tables, as we've deleted `txnrecords` table, so it will not be listed now

    ```sql
    hive (surya_training)> SHOW TABLES ;
    ```

    ```console
    OK
    customer
    nyse
    stkvol
    txn_bucket
    txn_orc
    txn_parquet
    txnrecsbycat
    txnrecsbycat2
    txnrecsbycat3
    txnrecsbycat4
    Time taken: 0.035 seconds, Fetched: 10 row(s)
    hive (surya_training)>
    ```

#### Open the table location in Hue after deletion

- Since this `txnrecords` table was a Managed Table, and upon deletion, their data should also be deleted, So if we open the path location for this Managed table in `Hue` tool, it'll show an error indicating that path is inaccessible
- You may goto the `Hue` tool you last opened and just refresh it for the table path at `/user/bigdatalab456422/sales` to see what error it shows

  ![Hue-_user_bigdatalab456422_sales_afterDROPTABLE](../content_BigDataTechnologies/Hue-_user_bigdatalab456422_sales_afterDROPTABLE.png)

### External Tables

1. To avoid losing the data from the table while only deleting the schema, you use the External table
2. Only the Schema/structure is deleted from the Hive Metastore, but data is kept intact at it actual location from where it was Mapped
3. Data is independent of the Schema of the table, as Hive only stores the Schema and then maps some external location of data store to that External table
4. `EXTERNAL` keyword is used while creating an External table

#### `CREATE EXTERNAL TABLE`

## UDF (User Defined Functions) in Hive
