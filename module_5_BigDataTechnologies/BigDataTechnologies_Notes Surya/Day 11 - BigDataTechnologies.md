# Day 11 - BigDataTechnologies

## Hive installation Steps

### Going to home directory of `hduser`

- First you need to change user to `hduser`, run the command below

    ```bash
    sdevsinx@bdt0:~$ su hduser
    ```

    ```console
    hduser@bdt0:/home/sdevsinx/Desktop$ 
    ```

- Now change the directory to the home using `cd` command as below, it'll take you to the home directory of `hduser` user

    ```bash
    hduser@bdt0:/home/sdevsinx/Desktop$ cd
    ```

    ```console
    hduser@bdt0:~$ 
    ```

- You can confirm the current directory by running `pwd` command as below just in case your command-line isn't printing the current directory

    ```bash
    hduser@bdt0:~$ pwd
    ```

    ```console
    /home/hduser
    hduser@bdt0:~$ 
    ```

### Hive Setup

#### Downloading Hive

- Use the `wget` command-line tool to download the Hive v1.2.1 **bin**ary archive to current directory (home directory of `hduser`) from [http://archive.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz](http://archive.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz), using command below

    ```bash
    hduser@bdt0:~$ wget http://archive.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz
    ```

    ```console
    --2023-05-29 11:43:45--  http://archive.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz
    Resolving archive.apache.org (archive.apache.org)... 65.108.204.189, 2a01:4f9:1a:a084::2
    Connecting to archive.apache.org (archive.apache.org)|65.108.204.189|:80... connected.
    HTTP request sent, awaiting response... 301 Moved Permanently
    Location: https://archive.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz [following]
    --2023-05-29 11:43:46--  https://archive.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz
    Connecting to archive.apache.org (archive.apache.org)|65.108.204.189|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 92834839 (89M) [application/x-gzip]
    Saving to: ‘apache-hive-1.2.1-bin.tar.gz’

    apache-hive-1.2.1-bin.tar.gz              100%[==================================================================================>]  88.53M   226KB/s    in 5m 2s

    2023-05-29 11:48:49 (301 KB/s) - ‘apache-hive-1.2.1-bin.tar.gz’ saved [92834839/92834839]

    hduser@bdt0:~$ 
    ```

#### Extracting Hive

- Once Hive archive is downloaded, you need to use `tar` utility to e**x**tract **f**orcibly through g**z**ip while **v**erbosing using the command below

    ```bash
    hduser@bdt0:~$ tar -xvzf apache-hive-1.2.1-bin.tar.gz
    ```

    ```console
    apache-hive-1.2.1-bin/NOTICE
    apache-hive-1.2.1-bin/LICENSE
    apache-hive-1.2.1-bin/README.txt
    ...
    ...
    ...
    apache-hive-1.2.1-bin/conf/hive-exec-log4j.properties.template
    apache-hive-1.2.1-bin/conf/beeline-log4j.properties.template
    apache-hive-1.2.1-bin/hcatalog/share/doc/hcatalog/README.txt
    hduser@bdt0:~$
    ```

#### Renaming & Moving Hive

- Once files have been extracted, it should have extracted all the files into a directory `apache-hive-1.2.1-bin`, which we’ll rename to `hive` using `mv` utility

    ```bash
    hduser@bdt0:~$ mv apache-hive-1.2.1-bin hive
    ```

    ```console
    hduser@bdt0:~$ 
    ```

- Now move this `hive` installation to `/usr/local/hive` directory using command below

    ```bash
    hduser@bdt0:~$ sudo mv hive /usr/local/
    ```

    ```console
    [sudo] password for hduser:
    hduser@bdt0:~$ 
    ```

#### Change ownership of `hive` to `hduser:hadoop`

- Although `/usr/local/hadoop/` should have `hduser:hadoop` as its `owner:group`, but you may run command below just in case

    ```bash
    hduser@bdt0:~$ sudo chown -R hduser:hadoop /usr/local/hive
    ```

    ```console
    hduser@bdt0:~$ 
    ```

### Setting hive paths in `~/.bashrc`

- Append the following to the end of `~./bashrc`, you may open it with `vim` or `nano` editor to make changes

    ```bash
    hduser@bdt0:~$ nano ~/.bashrc
    ```

    ```bash
    # hive variables start
    export HIVE_HOME=/usr/local/hive
    export PATH=$PATH:$HIVE_HOME/bin
    # hive variables end
    ```

- Save the `~./bashrc` file, and source it using command below

    ```bash
    hduser@bdt0:~$ source ~/.bashrc
    ```

    ```console
    hduser@bdt0:~$ 
    ```

### Configuring Hive Files on `hdfs` & `hadoop client`

- Now we need to create and configure some directories on hdfs as well as Hadoop client, so we need to start the hadoop server in order to access the hdfs

#### Starting Hadoop

- To start the Hadoop server, run the script/command below

    ```bash
    hduser@bdt0:~$ start-all.sh
    ```

    ```console
    This script is Deprecated. Instead use start-dfs.sh and start-yarn.sh
    23/05/29 11:50:13 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    Starting namenodes on [localhost]
    localhost: starting namenode, logging to /usr/local/hadoop/logs/hadoop-hduser-namenode-bdt0.out
    localhost: starting datanode, logging to /usr/local/hadoop/logs/hadoop-hduser-datanode-bdt0.out
    Starting secondary namenodes [0.0.0.0]
    0.0.0.0: starting secondarynamenode, logging to /usr/local/hadoop/logs/hadoop-hduser-secondarynamenode-bdt0.out
    23/05/29 11:50:26 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    starting yarn daemons
    starting resourcemanager, logging to /usr/local/hadoop/logs/yarn-hduser-resourcemanager-bdt0.out
    localhost: starting nodemanager, logging to /usr/local/hadoop/logs/yarn-hduser-nodemanager-bdt0.out
    hduser@bdt0:~$
    ```

#### Configuring `/tmp/hive` on hdfs

- First we need to create a directory `/tmp/hive` on hdfs using command below

    ```bash
    hduser@bdt0:~$ hadoop fs -mkdir -p /tmp/hive
    ```

    ```console
    23/05/29 11:50:51 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    hduser@bdt0:~$ 
    ```

- Once `/tmp/hive` is created on hdfs, we need to add write (`+w`) permission to its **g**roup using command below

    ```bash
    hduser@bdt0:~$ hadoop fs -chmod g+w /tmp/hive
    ```

    ```console
    23/05/29 11:51:40 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    hduser@bdt0:~$ 
    ```

- Now we'll change the permission to `733` for `/tmp/hive` using command below, so only user will have all (`7`) permissions and rest others will have only read+write (`3`) permission

    ```bash
    hduser@bdt0:~$ hadoop fs -chmod 733 /tmp/hive
    ```

    ```console
    23/05/29 11:54:21 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    hduser@bdt0:~$ 
    ```

#### Configuring `/user/hive/warehouse` on hdfs

- Now, we need to create a directory `/user/hive/warehouse` on hdfs using command below

    ```bash
    hduser@bdt0:~$ hadoop fs -mkdir -p /user/hive/warehouse
    ```

    ```console
    23/05/29 11:57:41 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    hduser@bdt0:~$ 
    ```

- Once `/user/hive/warehouse` is created on hdfs, we need to add write (`+w`) permission to its owner group using command below

    ```bash
    hduser@bdt0:~$ hadoop fs -chmod g+w /user/hive/warehouse
    ```

    ```console
    23/05/29 12:06:12 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    hduser@bdt0:~$ 
    ```

#### Configuring `/usr/local/hive/iotmp` on Hadoop Client

- Now, we need to create a directory `/usr/local/hive/iotmp` on Hadoop client using command below

    ```bash
    hduser@bdt0:~$ sudo mkdir /usr/local/hive/iotmp
    ```

    ```console
    [sudo] password for hduser:
    hduser@bdt0:~$
    ```

- Once `/usr/local/hive/iotmp` is created on Hadoop client, we need to change its ownership to `hduser:hadoop` using command below

    ```bash
    hduser@bdt0:~$ sudo chown -R hduser:hadoop /usr/local/hive/iotmp
    ```

    ```console
    hduser@bdt0:~$ 
    ```

- Now we'll change the permission to `777` for `/usr/local/hive/iotmp` using command below, so all users will have all (`7`) permissions

    ```bash
    hduser@bdt0:~$ sudo chmod 777 /usr/local/hive/iotmp
    ```

    ```console
    hduser@bdt0:~$ 
    ```

#### Configuration files for hive under `/usr/local/hive/conf`

- The configuration files for Hive are under the directory `/usr/local/hive/conf`

##### `/usr/local/hive/conf/hive-default.xml.template`

- `hive-default.xml.template` contains the default values for various configuration variables that come prepackaged in a Hive distribution. In order to override any of the values, create `hive-site.xml` instead and set the value in that file as shown above.
- `hive-default.xml.template` is located in the `conf` directory in your installation root, and `hive-site.xml` should also be created in the same directory.
- In `hive-site.xml` we need to set value for following properties
  1. `hive.exec.scratchdir` : HDFS root scratch dir for Hive jobs which gets created with write all (`733`) permission. For each connecting user, an HDFS scratch dir: `${hive.exec.scratchdir}/&lt;username&gt;` is created, with `${hive.scratch.dir.permission}`.
  2. `hive.exec.local.scratchdir` : Local scratch space for Hive jobs
  3. `hive.downloaded.resources.dir` : Temporary local directory for added resources in the remote file system.
  4. `hive.querylog.location` : Location of Hive run time structured log file
  5. `javax.jdo.option.ConnectionURL` : JDBC connect string for a JDBC metastore

- Goto `/usr/local/hive/conf` directory using command below as configuration files are present in it

    ```bash
    hduser@bdt0:~$ cd /usr/local/hive/conf/
    ```

    ```console
    hduser@bdt0:/usr/local/hive/conf$
    ```

- Now copy `hive-default.xml.template` as `hive-site.xml`

    ```bash
    hduser@bdt0:/usr/local/hive/conf$ cp hive-default.xml.template hive-site.xml
    ```

    ```console
    hduser@bdt0:/usr/local/hive/conf$
    ```

- Now open `hive-site.xml` using `vim` editor or `nano`, and you need to edit the following properties as per XML snippets shown below

    ```bash
    hduser@bdt0:/usr/local/hive/conf$ vim hive-site.xml
    ```

    1. `hive.exec.scratchdir`

        ```xml
            <property>
                <name>hive.exec.scratchdir</name>
                <value>/tmp/hive</value>
                <description>HDFS root scratch dir for Hive jobs which gets created with write all (733) permission. For each connecting user, an HDFS scratch dir: ${hive.exec.scratchdir}/&lt;username&gt; is created, with ${hive.scratch.dir.permission}.</description>
            </property>
        ```

    2. `hive.exec.local.scratchdir`

        ```xml
            <property>
                <name>hive.exec.local.scratchdir</name>
                <!-- <value>${system:java.io.tmpdir}/${system:user.name}</value> -->
                <value>/usr/local/hive/iotmp</value>
                <description>Local scratch space for Hive jobs</description>
            </property>
        ```

    3. `hive.downloaded.resources.dir`

        ```xml
            <property>
                <name>hive.downloaded.resources.dir</name>
                <!-- <value>${system:java.io.tmpdir}/${hive.session.id}_resources</value> -->
                <value>/usr/local/hive/iotmp</value>
                <description>Temporary local directory for added resources in the remote file system.</description>
            </property>
        ```

    4. `hive.querylog.location`

        ```xml
            <property>
                <name>hive.querylog.location</name>
                <!-- <value>${system:java.io.tmpdir}/${system:user.name}</value> -->
                <value>/usr/local/hive/iotmp</value>
                <description>Location of Hive run time structured log file</description>
            </property>
        ```

    5. `javax.jdo.option.ConnectionURL`

        ```xml
            <property>
                <name>javax.jdo.option.ConnectionURL</name>
                <!-- <value>jdbc:derby:;databaseName=metastore_db;create=true</value> -->
                <value>jdbc:derby:;databaseName=/usr/local/hive/metastore_db;create=true</value>
                <description>JDBC connect string for a JDBC metastore</description>
            </property>
        ```

##### `/usr/local/hive/conf/hive-env.sh.template`

- Now we need to make change in `hive-env.sh` file
- If `hive-env.sh` file is not available in `conf`, then create a copy from the default template `hive-env.sh.template` using the command below

    ```bash
    hduser@bdt0:/usr/local/hive/conf$ cp hive-env.sh.template hive-env.sh
    ```

    ```console
    hduser@bdt0:/usr/local/hive/conf$ 
    ```

- Now open `hive-env.sh` using `vim` editor or `nano` and append the following lines at the end of it

    ```bash
    hduser@bdt0:/usr/local/hive/conf$ vim hive-env.sh
    ```

    ```bash
    export HADOOP_USER_CLASSPATH_FIRST=true
    ```

### Starting Hive CLI

- Once files are configured properly, now `hadoop` server is already running, so you can start the `Hive CLI` but first move back to the `home` directory of `hduser`

    ```bash
    hduser@bdt0:/usr/local/hive/conf$ cd ~
    ```

    ```console
    hduser@bdt0:~$
    ```

- Run the command below to start the `hive CLI`

    ```bash
    hduser@bdt0:~$ hive
    ```

    ```console

    Logging initialized using configuration in jar:file:/usr/local/hive/lib/hive-common-1.2.1.jar!/hive-log4j.properties
    hive>
    ```

#### Running Hive CLI commands

- Once Hive CLI interactive shell is available, you can run Hive commands
- Run the command below in Hive interactive shell to list all the databases

    ```hive
    hive> SHOW DATABASES ;
    ```

    ```console
    OK
    default
    Time taken: 0.021 seconds, Fetched: 1 row(s)
    hive>
    ```
