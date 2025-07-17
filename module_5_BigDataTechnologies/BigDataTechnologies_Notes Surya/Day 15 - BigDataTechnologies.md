# Day 15 - BigDataTechnologies

## Apache Spark

1. Spark is ...
    - Not a modified version of Hadoop
    - A low latency cluster computing system
    - Separate, fast, MapReduce-like engine
      - In-memory data storage for very fast iterative queries
      - General execution graphs and powerful optimizations
      - 40x to 100x faster than Hadoop
      - 100x faster than MapReduce for iterative algorithms
    - Compatible with Hadoop's storage APIs
      - can read/write to any Hadoop-supported system, including HDFS, HBase, SequenceFiles, etc.
        ![Spark-read-write-drawing](../content_BigDataTechnologies/Spark-read-write-drawing.png)
2. Apache Spark is an open-source distributed data processing engine for big data analytics, not a storage framework
3. utilizes in-memory caching, and optimized query execution for faster analytics against data of any size, it isn't tied to Hadoop's MapReduce two-stage paradigm to store and process data
4. It also provides APIs for Java, Scala, Python and R, making it accessible to more developers
5. supports code reusability across multiple nodes for batch processing, interactive querying, real-time analytics, machine learning and graph processing
6. initially started by Matei Zaharia at UC Berkeley's AMPLab in 2009, open-sourced in 2010, donated to Apache Software Foundation in 2013
7. in-memory processing makes repeated access to the same data much faster
8. Apache Spark can run as a standalone application OR on top of Hadoop YARN to read data from HDFS
9. Apache Spark includes a core data processing engine, as well as libraries for  SQL, Machine Learning, Stream Processing and Graph processing
10. Apache Spark can read from and write to a variety of storage types including HDFS, text files, etc.

## Data Sharing in Hadoop MapReduce vs Apache Spark

1. In Hadoop
    1. It has a filesystem for storage and computer power for processing on each data node
    2. After each iteration in a job, it writes data back to HDFS, increasing overhead in processing time and cost
    3. Data needs to be read from HDFS before each iteration, and final output is written again to the HDFS
    4. For each query, data needs to be read separately to produce different results, this read for each new query increases more overhead in time and cost
    ![Data-Sharing-in-MapReduce-annotation](../content_BigDataTechnologies/Data-Sharing-in-MapReduce-annotation.png)
2. In Apache Spark
    1. It has no filesystem for storage, instead caches data on RAM while processing, it is purely for processing framework
    2. It is a new thing, not a modified version of Hadoop
    3. It can read/write from/to any source like HDFS, Hive, Oracle, etc.
    4. Since it uses in-memory processing, so it requires more RAM, making it expensive than Hadoop
    5. Even for each iteration in a job, it keeps data on RAM and uses that for next iteration, does not writes back to the storage after each iteration, instead writes back to storage after complete processing, making it faster
    6. Data is once loaded into RAM which can be used to process different queries, each producing a different result, reducing the read overhead for different queries
    ![Data-Sharing-in-Spark-annotation](../content_BigDataTechnologies/Data-Sharing-in-Spark-annotation.png)

## Apache Spark Components

![Spark-components-annotation](../content_BigDataTechnologies/Spark-components-annotation.png)

- Apache Spark has following components

### 1. Cluster Manager

- Spark can operate with following kinds of Cluster Manager to manage its cluster(s)

1. **Spark Standalone**
    - A simple cluster manager included with Spark to run Spark apps on cluster of machines
    - Suitable for small clusters or development environments
    - It has Masters and number of workers with configured amount of memory and CPU cores
    - In Cluster mode, Spark allocates resources based on the cores, by default, an app will grab all the cores in the cluster
    - To check the application, each Spark app has a Web UI providing information on executors, storage usage, tasks, etc.
    - For High Availability, *ZooKeeper Quorum* helps in automatic recovery of Master node; Cluster tolerates the worker failure despite Master recovery is enabled or not
    - For Security, Spark supports authentication via a Shared-Secret with all the cluster Managers, and Standalone Manager requires user to configure each of the nodes with the Shared-Secret, data transfer can be can be encrypted using *Secure Sockets Layer (SSL)* for communication protocols, and *Simple Authentication and Security Layer (SASL)* for block transfers, access to Spark UI is restricted using *Access Control List (ACL)*
    - For monitoring, it has a Web UI to view cluster and job statistics, log outputs for each job, Applications' UI is created using Spark UI to show event logs (if any) for that application
2. **Apache Mesos**
    - Apache Mesos support is deprecated as of Apache Spark 3.2.0
    - A distributed systems kernel that abstracts across a cluster
    - can run multiple types of applications such as Spark, Hadoop, on the same cluster for efficient resource utilization
    - allows applications to request and release resources dynamically as needed
    - provides fault tolerance and scalability, making it suitable for large and complex
    - uses node abstraction to allow a variety of workloads on a node, decreasing overhead of allocating a specific machine for different workloads
    - Mesos uses reverse-virtualization, combining multiple physical resources into a single virtual resource
    - Mesos has three components
      1. **Mesos Master :** it is an instance of cluster, a cluster has many Mesos Masters to provide fault tolerance, out of which only one instance is the leading master
      2. **Mesos Slave :** a Mesos instance that offers resources to the cluster, Mesos master assigns tasks to the Mesos slave
      3. **Mesos Framework :** allows applications to request resources from the cluster
    - Some other frameworks that use Mesos are Chronos, marathon, Aurora, Hadoop, Spark, Jenkins, etc.
    - For High Availability, it uses *Apache ZooKeeper* for automatic recovery of Master Node, incase of failover, task execution is not stopped
    - For security, Mesos provides security to any entity interacting with Cluster, each of those entities can be enabled to use authentication, Custom modules can be used to replace Mesos default authentication module Cyrus SASL, By Default communication between modules in unencrypted while SSL/TLS can be enabled to encrypt communication, Mesos uses *Access Control List (ACL)* to provide access to services
    - For monitoring, Mesos supports per container network monitoring and isolation, providing many metrics including allocated CPU, memory usage, etc. for Master Node and Slave Nodes accessible with URL
3. **Hadoop YARN**
    - YARN stands for Yet another Resource Negotiator, which is a sub-project of Hadoop
    - It bifurcates the functionality of Resource Manger and Job Scheduling into different daemons, providing a global Resource Manager (RM) and a per-application Application Master (AM), an application is either a DAG or an individual job
    - It is a combination of Resource Manger and Node Manager
      - **YARN Resource Manager** manages resources among all the applications, it has a Job Scheduler and Application Manager (AM)
        - **Job Scheduler** allocates resources to applications, and monitors the application status
        - **Application Manager (AM)** manages applications across all the nodes
      - **YARN Node Manager**  contains Application Master and Container
        - **Container** is a place where actual processing takes place in an isolated manner, Each task of MapReduce runs in one container, an application requires one or more containers
        - **Application Master** is a per-application framework aimed to negotiate resources from Resource Manager, works with Node Manager(s) to monitor tasks for resource needs
    - YARN allows to share and configure the same resource pool between all the framework that runs on YARN, likely pre-installed on Hadoop
    - For High Availability, it supports manual recovery of Master Node, and can use *ZooKeeper* based *ActiveStandBy* embedded in the Resource Manager for automatic recovery, doesn't require a separate ZooKeeper failover controller
    - For Security, it has security for authentication using *Access Control List (ACL)* for Hadoop services and Web UIs, Service Level Authorization to provide authority to client, SSL for encryption of communication between clients and services
    - For monitoring, YARN has a Web UI for Resource Manager and Node Manager, Resource Manager UI provides metrics for clusters, and Node Manager UI provides information for each node, applications and containers running on that Node
4. **Kubernetes**
    - A container orchestration platform to manage containerized applications
    - suitable for cloud-native applications and environments using containers
    - Allows Spark to run as containers, scaling applications easily based on resource needs
    - Kubernetes API creates a driver pod that manages the application and launches executor pods for processing tasks
    - When an application completes, the executor pods terminate and are cleaned up, but driver pod persists logs and remains in completed state in Kubernetes API until it's eventually garbage collected or manually cleaned up
    - Kubernetes handles the lifecycle for both driver and executor pods ensuring job scheduling
    - It can scale the number of executor pods based on workload, runs multiple instances of Spark driver in different pods to enhance availability
    - For High Availability, It monitors health of nodes in a cluster, If a pod crashes, either driver or Executor, it automatically restarts that pod, providing automatic recovery
    - For Security, it supports *Role-Based Access Control (RBAC)* based on external authentication mechanisms like LDAP, etc., allows to define network policies, manages secrets using Kubernetes API

### 2. Spark Workloads

- The Spark framework includes following workloads
  1. Spark Core as the foundation for the platform
  2. Spark SQL for interactive queries
  3. Spark Streaming for real-time analytics
  4. Spark MLlib for machine learning
  5. Spark GraphX for graph processing

  ![what-is-apache-spark.b3a3099296936df595d9a7d3610f1a77ff0749df](../content_BigDataTechnologies/what-is-apache-spark.b3a3099296936df595d9a7d3610f1a77ff0749df.png)

#### 1. Spark Core

- All the functionalities in Apache Spark are built on top of Spark Core
- It is responsible for memory management, fault recovery, scheduling, distributing & monitoring jobs, and interacting with storage systems
- It is exposed through an API built for Java, Scala, Python and R, to hide the complexity of distributed computing behind simple high-level operators
- Spark Core is the home to the API that consist of `Resilient Distributed Dataset (RDD)` and provides APIs for building and Manipulating RDDs, Spark RDD handles partitioning data across all the nodes in a cluster, holds the memory pool of the cluster as a single unit
  - Two operations are performed on RDDs
    1. **Transformation :** produces new RDD from existing RDD, executed in a lazy evaluation fashion
    2. **Action :** allows to work on actual dataset to produce results, triggers execution of transformations

#### 2. Spark SQL

- Spark SQL is a framework for structured big data processing on a distributed query engine
- It provides low-latency interactive queries up to 100x faster than MapReduce
- It allows Spark to access Metadata about data and computation for extra optimizations
- It includes Cost-Based Optimizer (CBO), columnar storage, code generation for faster queries, etc., while scaling to thousands of nodes
- It allows Business Analysts to  use standard SQL or Hive Query Language (HQL) for querying data
- It allows developers to use APIs available in Scala, Java, Python and R
- It supports various data-sources out-of-the-box including JDBC, ODBC, JSON, HDFS, Hive, ORC and Parquet
- It supports popular data stores like Amazon Redshift, Amazon S3, Couchbase, MongoDB, Salesforce, ElasticSearch,  and others all of which can be found at [Spark Packages](https://spark-packages.org/?q=tags%3A%22Data%20Sources%22)
- It provides `DataFrame` API to work with different structured data sources such as Hive, Avro, Parquet, ORC, JSON, JDBC
- It uses Cost-Based Optimizer (CBO) to optimize query execution plans
- It Used for tabular or structured schema to create DataFrames

#### 3. Spark Streaming

- Spark Streaming provides scalable, high-throughout fault tolerant stream processing of streaming data
- It is a real-time analytics solution that leverages Spark Core's fast scheduling capability to perform streaming analytics
- It ingests data in micro-batches to enable analytics on that data with the same application code written for batch analytics, providing fault tolerance
- It improves developer productivity, since same code for batch processing can be abstracted to use for streaming applications
- Once data from live stream is captured, it can be sent to file system, databases or live dashboards
- Spark Streaming supports data from twitter, Apache Kafka, Apache Flume, HDFS, Amazon Kinesis, TCP sockets, and many more all of which can be found at [Spark Packages](https://spark-packages.org/?q=tags%3A%22Streaming%22) ecosystem
- It works in three stages
  1. **Gathering**
      - It provides two types of built-in streaming sources
        1. **Basic Sources :** includes sources available in `StreamingContext` API such as File systems and socket connections
        2. **Advanced Sources :** includes sources like Apache Kafka, Apache Flume, Amazon Kinesis, etc. available through extra utility classes
  2. **Processing**
      - The gathered data is processed using complex algorithms with a high-level function, such as MapReduce, Join and window
  3. **Data Storage**
      - The processed data is then pushed to file systems, databases and live-dashboards
      - Spark Streaming also provides high-level abstraction, also known as `Discretized Stream` or `DStream`
      - `DStream` in Spark signifies continuous stream of data, which can be formed either using sources such as Apache Kafka, Apache Flume, and Amazon Kinesis or by high-level operations on other DStreams
      - DStream is internally a sequence of RDDs

#### 4. Spark MLlib

- It is a library to perform Machine Learning on data at scale
- It is aimed to make Machine Learning scalable and easy
- Machine Learning models can be trained by Data Scientists with R and Python on any Hadoop data source, saved using MLlib, and imported into a Java or Scala-based pipelines to build complex workflows
- Spark was designed for fast, interactive computation that runs in-memory, enabling Machine Learning to run quickly
- It provides tools for  feature extraction, transformation and model evaluation
- The algorithms in MLlib have the ability to perform classification, regression, clustering, collaborative filtering and pattern mining, and some lower-level Machine Learning primitives such as Gradient Descent are also present in it
- In Spark v2.0, the `RDD` based API in `spark.mllib` package was put in maintenance, making the `DataFrame` based API as the primary Machine Learning API for Spark, MLlib will not add any new features in RDD based API instead it is only maintained
- The reason to switch to DataFrame based API in MLlib is that it is more user-friendly than RDD based API
- DataFrame based API for MLlib includes Spark Data Sources, SQL DataFrame queries, `Tungsten` and `Catalyst` Optimizations and uniform API across languages
- MLlib also uses linear algebra package `Breeze`, which is a collection of  libraries for numerical computing and Machine Learning
- For Machine Learning

#### 5. Spark GraphX

- Spark GraphX is a distributed graph processing framework built on top of Spark
- It provides ETL, EDA, and iterative graph computation to enable users to interactively build and transform a graph data structure at scale
- It comes with a highly flexible API, and a selection of distributed Graph algorithms
- For Entity Relationships

## Data Flow in Spark

- This essentially refers to the end-to-end lifecycle of data in Apache Spark, or the inbound-processing-outbound data flow in Spark's architecture
- Understanding this data flow is critical to improving Spark application's  performance, scalability, and integration with external systems
- Below steps broadly outline the life cycle of data in Spark architecture
  1. Data Ingestion
  2. Planning
  3. Execution
  4. Shuffle
  5. Output

### 1. **Data Ingestion**

- Data can enter Spark from a variety of sources, either structured, semi-structured, or unstructured
- Spark uses connectors and APIs for reading data
- Following are the common sources from which Spark can read data

    | Source Type | Examples |
    | :-- | :-- |
    | File-based | CSV, JSON, Parquet, ORC, Avro, Text |
    | Cloud | AWS S3, Azure Blob, GCS |
    | Databases | MySQL, Postgres, Oracle, SQL Server (via JDBC) |
    | Data Lakes | Delta Lake, Iceberg, Hudi |
    | Streams | Kafka, Kinesis, Flume, Socket, Files |
    | External APIs | REST API, Elasticsearch |

- The Data Ingestion mechanism involves reading data using Spark APIs

  ```python
  sdf = spark.read.format('csv').option('header', True).load('path/to/file.csv')
  ```

- Spark does not read all the data immediately, as it uses lazy evaluation
- It builds a logical plan describing how to access and transform data
- Actual data is read only when some action command such as `.count()`, `.show()` is triggered

  > Spark builds the plan before reading data, but metadata about the source such as schema, may still be accessible during reading, especially for structured formats like parquet

### 2. **Planning**

- Apache Spark creates a comprehensive plan on how to read data and do transformations
- This plan which can be viewed as two kinds of plans
  1. Logical Execution Plan to Optimized Plan
  2. Physical Execution Plan and Directed Acyclic Graph (DAG)

#### **1. Logical Plan to Optimized Plan**

- Once you define your transformation such as `.filter()`, etc. shown as below, Spark builds a logical plan

  ```python
  df_filtered = df.filter('age > 30').select('name', 'age')
  ```

- This plan is then optimized by the Catalyst Optimizer using techniques such as
  - Predicate pushdown
  - Constant folding
  - Column pruning
  - Reordering joins, etc.
- This stage is also metadata only, and data still has not been actually read or moved

#### **2. Physical Execution Plan and Directed Acyclic Graph (DAG)**

- When you trigger an action command such as `.show()`, only then spark converts the logical execution plan into a physical execution plan, because it uses lazy evaluation
- The Physical Execution Plan includes the *Directed Acyclic Graph (DAG)* representing  *job(s)*, split into multiple *stages* having multiple *tasks*
- It then schedules the tasks on the executors which are distributed across cluster nodes
- The data is now actually read and transformed in partitions based on the number of executors available in the cluster for this job

  ```text
  Spark Application
      └──> Action triggers a -> JOB
                  └──> Job split into -> STAGES (at shuffle boundaries)
                              └──> Each consists of -> TASKS (1 per partition)
  ```

##### Directed Acyclic Graph (DAG)

- A Directed Acyclic Graph (DAG) in Spark is a graph of computation that represents all the operations (including transformations) in your Spark application, without any cycles
  - Each *Node* in DAG represents an RDD/DataFrame transformation
  - Each *Edge* represents a dependency between operations
  - *Acyclic* means there are no loops, data flows in one direction only without any cycles
- Spark first builds a logical plan of transformations, then optimizes it.
- Once an action is triggered, Spark generates a physical execution plan and converts it into a DAG of stages and tasks
- When you run your Spark Application, spark builds a DAG of transformations like read, filter, group, count, etc. in a lazy fashion, so nothing gets executed at the moment

##### Job

- A Job is a top-level execution unit in Spark,triggered by an action such as `.collect()`, `.show()`, `.write()`, `.count()`, etc.
- It is used by Spark to know when to start the execution of DAG
- Each Job contains one or more Stages, depending on whether there are shuffles

##### Stage

- A Stage is a subset of a job consisting of a sequence of transformations that can be executed without a shuffle
- A job is divided into stages at shuffle boundaries
- Spark groups operations with narrow dependencies into a single stage

###### Types of Stages

- There are two types of stages
  1. `ShuffleMapStage` : Produces intermediate data that needs to be shuffled
  2. `ResultStage` : Final stage that returns the result to the driver

- Example:

  ```python
  df = spark.read.csv('data.csv')
  df_filtered = df.filter('age > 30')
  df_grouped = df_filtered.groupBy('dept').count()
  df_grouped.show()
  ```

- In this above example, it has two stages
  1. *Stage 1* : Read + Filter (no shuffle)
  2. *Stage 2* : GroupBy + Count (needs shuffle)

- Breaking down a job into stages allows Spark to
  - Execute parts of the Job in parallel
  - Handle fault tolerance (only failed stages are recomputed)

##### Task

- A task is the smallest unit of execution in Spark
- One task represents one unit of work on a single partition
- Each stage is made up of multiple tasks, one task per partition
- For example, if a stage processes 200 partitions, Spark will launch 200 tasks for that stage
- Tasks are at the level at which parallelism is achieved
- Spark can run tasks in parallel across many executor cores

### **3. Execution**

- Execution starts when the driver schedules tasks across executors
- These executors read the data from sources (such as CSV, parquet, database, etc.) in parallel, process it based on task assignments, and store intermediate data in memory or disk
- It continues following the steps from the Physical Execution plan to run Jobs, Stages and Tasks in a Directed Acyclic Graph (DAG)
- The data is loaded as partitions into multiple executors, and then data is transformed at each executor for its respective partition
- It involves below key components from Spark architecture:

  | Component | Role |
  | :-- | :-- |
  | Driver | Runs your PySpark code and orchestrates job execution |
  | Cluster Manager | YARN / Kubernetes / Standalone, allocates resources (executors) |
  | Executors | Worker nodes that run tasks and hold data in memory or disk |
  | Tasks | Individual units of work for a data partition |

### **4. Shuffle**

- Shuffling is not always required, occurs for wide transformations such as `.groupBy()`, `.join()`, `.distinct()`, `.reduceByKey()`
- Exchange Operators in physical plans such as `Exchange`, `SHuffledHashJoin` are indicators of shuffle points
- In this step, data is repartitioned and transferred across executors
- This step incurs network and disk I/O, in order to transfer data across worker nodes
- You can use `.cache()` or `.persist()` to store intermediate results in memory (or disk), which avoids re-computation of upstream transformation in subsequent stages

  ```python
  df.cache()
  ```

#### Caching methods

##### 1. `.cache()`

- Caching in Apache spark refers to storing intermediate results in memory (RAM), so that it can be reused in future actions without re-computation
- By default, Spark uses lazy evaluation, so transformation such as `.filter()`, `.map()`, `.join()` are not executed until an action such as `.collect()`, `.count()` is triggered
- If you perform multiple actions on the same DataFrame/RDD without caching, Spark re-computes the entire lineage (the whole chain of transformations) every time, right from the start of DAG
- Example
  - Without caching

    ```python
    df = spark.read.csv('big/file.csv')
    df_filtered = df.filter('age > 30')            # no caching
    df_filtered.count()    # triggers computation, reads from source, applies filter
    df_filtered.show()     # triggers same computation again, again reads from source, again applies filter
    ```

  - With caching

    ```python
    df = spark.read.csv('big/file.csv')
    df_filtered = df.filter('age > 30').cache()    # indicates Spark to store intermediate result into memory
    df_filtered.count()    # triggers computation, reads from source, applies filter and stores result in memory
    df_filtered.show()     # triggers computation, but it resumes from intermediate result stored in memory, instead of starting over
    ```

- When you perform caching using `.cache()`, it triggers the same functionality as `.persist(StorageLevel.MEMORY_AND_DISK)`, to store into RAM, spill to disk if needed
- In case of spill to disk, Spark will recompute partially
- Caching is good for iterative algorithms, multiple actions, and machine learning pipelines

##### 2. `.persist()`

- Also, you may use `.persist()` to unlock the full potential of persistence in Spark, utilizing other storage levels too.
- `.persist()` allows you to store a DataFrame or RDD in memory and/or disk across operations, so Spark doesn't recompute it every time
- It is similar to `.cache()`, but with more control over how and where data is stored
- You may use `.persist()` when
  - You want to optimize memory/disk usage
  - You know your dataset won't fit in RAM
  - You want fine-tuned control (e.g. off-heap, serialization)

| Storage Level | Memory | Disk | Serialized | Description | Usage scenario |
| :-- | :-- | :-- | :-- | :-- | :-- |
| `.persist(StorageLevel.MEMORY_ONLY)` | ✅ | ❌ | ❌ | Fastest, but fails if memory (RAM) is insufficient | Data fits in memory easily |
| `.persist(StorageLevel.MEMORY_AND_DISK)` | ✅ | ✅ | ❌ | Default for `.cache()`, spills to disk if needed | Data is large and spills |
| `.persist(StorageLevel.MEMORY_ONLY_SER)` | ✅ | ❌ | ✅ | Serialized, uses less memory (RAM) by storing serialized objects | Want to save memory (RAM) |
| `.persist(StorageLevel.MEMORY_AND DISK_SER)` | ✅ | ✅ | ✅ | Serialized, spills to disk | Low-latency analytics |
| `.persist(StorageLevel.DISK_ONLY)` | ❌ | ✅ | ✅ | No RAM usage, slowest but safest | Disk space is cheap, budget is tight |
| `.persist(StorageLevel.OFF_HEAP)` (advanced) | ✅ | ❌ | ✅ | Uses Off-Heap memory (with Tungsten Engine), must enable manually | Large data, High-performance, advanced tuning |

- Example

  ```python
  from pyspark import StorageLevel

  df = spark.read.parquet('path/to/data')
  df_clean = df.filter('score >50').persist(StorageLevel.MEMORY_ONLY_SER)  # persist with MEMORY_ONLY_SER storage level
  df_clean.count()
  df_clean.groupBy('category').avg('score').show()
  ```

  > When you persist data, spark executes lineage to compute the dataset for the first time, and stores the intermediate result according to Storage Level, then all future actions on that dataset will reuse the stored data, instead of computing the lineage again

- Once you're done with a cached/persisted dataset, always unpersist it to free up resources using `.unpersist()` method

  ```python
  df_filtered.unpersist()
  df_clean.unpersist()
  ```

### **5. Output**

- Finally, Spark outputs results using actions like `.write()`, `.collect()` or `.show()`
- Output/result can be written to external sinks or returned to driver
- Following are the common targets to which Spark can write data

  | Target Type | Examples |Parallel | Notes |
  | :-- | :-- | :-- | :-- |
  | File Output | `.write.parquet()`, `write.csv()`, `.write.format('delta')` | Yes | Executors write partitioned output files in parallel |
  | Databases | `.write.jdbc()` | Partial| not always parallel, by default single connection, but can be parallelized with options and table being partitioned |
  | Data Lakes | `write.format('delta')`, `.write.format('iceberg')` | Yes | Built on distributed file systems, supports partitioned and parallel writes |
  | Streams | `writeStream.format('kafka')`, `.writeStream.format('console')` | Yes | Micro-batches or continuous writes handled in parallel by executors |
  | Return to Driver | `.collect()`, `.toPandas()` (only for small data) | No | Data is moved to driver node, serialized and written in driver process |

- Example

  ```python
  df_filtered.write.format('parquet').save('/output/path')
  ```

- Spark executes output tasks in parallel on the executors, each of which writes its own partition of data directly to the storage layer (e.g. HDFS, S3, etc.)
- Output can be in parallel, optimized for throughput, if data is directly written back to an external sink (not firstly to driver)
- These writes happen in parallel across executors, Spark will write as many output files as there are partitions in the final DataFrame/RDD (unless you do `.coalesce()` or `.repartition()`first)
- Executors own their partitions, so they write them without shuffling them back to driver

  > That's why people use `.coalesce(1)` or `.repartition(n)` before writing if they want fewer/more output files

- But, writes are not parallel if data is collected back at driver first
- If you write the result, using functions such as `.collect()`, `.toPandas()`, etc., the driver writes it, and not in a parallel manner
- This writing by driver can be dangerous for large datasets, and can cause memory issues or even crashes

## Apache Spark Architecture

- TBD

## Apache Spark APIs

- Apache Spark is a unified analytics engine designed for distributed data processing, which provides high-level APIs in multiple programming languages and several core abstractions that simplify the handling of large-scale data
- These APIs enable developers to efficiently process, transform, and analyze data in parallel across clusters of machines

### 01. Spark Programming Language APIs

- The Spark API is available in several programming languages, allowing developers to use their preferred language to interact with the engine
- The primary APIs are:

#### 01. Scala API (Native API)

- It is the original and most feature-rich API, native to Spark
- Spark is primarily written in Scala, making the Scala API the most complete and efficient in terms of feature support and performance
- The Scala API can make full use of Spark's optimizations, such as the Catalyst optimizer and the Tungsten execution engine

#### 02. Java API

- Spark also provides an API for Java, allowing developers to use all of Spark's features in Java
- The Java API tends to be more verbose compared to the Scala API, which may require more boilerplate code to accomplish the same tasks
- Ideal for Java developers or teams working within Java enterprise environments

#### 03. Python API (PySpark)

- PySpark is the Python binding for Spark and is widely used in data science, machine learning communities
- PySpark is typically used in interactive notebooks like Jupyter or Zeppelin, making it ideal for rapid prototyping and exploration
- It offers most Spark features, though it introduces some performance overhead due to inter-process communication with the JVM

#### 04. R API (SparkR)

- SparkR provides an interface to use Spark with the R programming language
- SparkR supports data processing via DataFrames, but it lacks some of the advanced features available in the Scala/Java APIs
- It is intended for statisticians and R users who wish to scale their data analysis to large datasets across clusters

### 02. Spark Core Abstractions (Data APIs)

- Spark provides several abstractions for working with distributed data, which allow users to perform data transformations and computations in a fault-tolerant and parallel manner
- The primary data abstractions are:

#### 01. Resilient Distributed Dataset (RDD)

- It is a low-level abstraction
- It is an immutable distributed collection of objects that are strongly typed
- It supports fault-tolerant, fine grained transformations
- It is best for complex, unstructured data and functional programming
- Its API are available in Scala, Java, and Python (with limited support in R)

##### Lazy Evaluation

- TBD

#### 02. DataFrame

- It is a high-level abstraction, built on top of RDDs
- It is a distributed collection of data organized into named columns , resembling a SQL table with a defined schema
- It can be optimized using Catalyst query optimizer
- It is supported in Scala, Java, Python & R
- It also integrates well with SQL queries

#### 03. Dataset

- It combines benefits of RDD (strong typing, object-oriented) and DataFrame (optimized execution)
- It provides compile-time safety and leverages encoders for efficient serialization
- It is not available in Python or R
- Internally, it is backed by a DataFrame and an encoder schema

### 03. Summary

| Component | Description | Language Support |
| :-- | :-- | :-- |
| RDD | Low-level abstraction for distributed data | Scala, Java, Python |
| DataFrame | Structured data abstraction | Scala, Java, Python, R |
| Dataset | Typed extension of DataFrame | Scala, Java |
| PySpark | Python API for Spark | Python |
| SparkR | R API for Spark | R |
| Scala API | Native Spark API | Scala |
| Java API | Spark API for Java applications | Java |

### Spark Execution Modes

#### Local Execution Mode

#### Client Execution Mode

#### Cluster Execution Mode

### Actions and Transformations

## Apache Spark Programming Model

## Fault Tolerance in Apache Spark

## Apache Spark Hands-on (Transactions dataset)

### Starting PySpark

### Find the Category of Transactions with Highest Net Value

## reduceByKey() & sortBy()
