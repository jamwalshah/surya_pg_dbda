# Day 09 - BigDataTechnologies

## Create & Setup Single Node Hadoop cluster on Ubuntu

### Finding the version of Ubuntu

- Launch the terminal using either by `Right-Clicking on Desktop > Open in Terminal` or using shortcut `Ctrl+Alt+T`
- Run the command below to check the version of ubuntu

    ```bash
    sdevsinx@bdt0:~/Desktop$  cat /etc/lsb-release
    ```

### Updating the source list

- First move to current user's home directory

    ```bash
    sdevsinx@bdt0:~/Desktop$ cd ~
    ```

- Run the command below to update the source list, enter current user's password if asked

    ```bash
    sdevsinx@bdt0:~$ sudo apt update -y
    ```

### Java Setup

#### Install JDK

- The OpenJDK project is the default version of Java that is provided from a supported Ubuntu repository

- Run the command below to install specifically `OpenJDK 8`, a particular version of the Java Development Kit needed for further installation

    ```bash
    sdevsinx@bdt0:~$ sudo apt install openjdk-8-jdk
    ```

- **Optionally**, You may run the command below to install the `Default Java/jdk`, it pulls in the JDK version that the maintainers of your OS consider to be the standard or most stable version for general use

    ```bash
    sdevsinx@bdt0:~$ sudo apt install default-jdk
    ```

#### Check installed Java Version

- Run the command below to check the version of java that is being used, but if it already shows `java version 1.8` then you may skip to [Adding a dedicated Linux User & Group](#adding-a-dedicated-linux-user--group)

    ```bash
    sdevsinx@bdt0:~$ java -version
    ```

    ![java-version-11_0_19-check](../content_BigDataTechnologies/java-version-11_0_19-check.png)

##### `update-alternatives` command to configure `java` path

- Run command below to set alternative path for `java`, and then enter the selection number when prompted (here `2`) to move the selection star to `openjdk-8-jdk` path to `java`

    ```bash
    sdevsinx@bdt0:~$ sudo update-alternatives --config java
    ```

- Now run the command again to confirm if the star has moved to required `java` path, and press `Enter` when prompted, to keep the selection as it is

    ```bash
    sdevsinx@bdt0:~$ sudo update-alternatives --config java
    ```

    ![update-alternatives-config-java](../content_BigDataTechnologies/update-alternatives-config-java.png)

##### `update-alternatives` command to configure `javac` path

- Run command below to set alternative path for `javac`, and then enter the selection number when prompted (here `2`) to move the selection star to `openjdk-8-jdk` path to `javac`

    ```bash
    sdevsinx@bdt0:~$ sudo update-alternatives --config javac
    ```

- Now run the command again to confirm if the star has moved to required `java` path, and press `Enter` when prompted, to keep the selection as it is

    ```bash
    sdevsinx@bdt0:~$ sudo update-alternatives --config javac
    ```

    ![update-alternatives-config-javac](../content_BigDataTechnologies/update-alternatives-config-javac.png)

##### Confirming required java version

- Run the command below to check the version of java that is being used, it should show `java v1.8`

    ```bash
    sdevsinx@bdt0:~$ java -version
    ```

    ![java-version-1_8_0-check](../content_BigDataTechnologies/java-version-1_8_0-check.png)

### Adding a dedicated Linux User & Group

- Now you need to add a dedicated Hadoop user

#### Create Linux group `hadoop`

- Run the command below to add a group `hadoop`

    ```bash
    sdevsinx@bdt0:~$ sudo addgroup hadoop
    ```

    ![sudo-addgroup-hadoop](../content_BigDataTechnologies/sudo-addgroup-hadoop.png)

#### Creating linux user `hduser` and adding it to group `hadoop`

- Run the command below to add a new dedicated user `hduser` and add it to recently created group `hadoop`
- Set a password which you can remember easily (say `hadoop`), enter password again to confirm it
- Keep pressing `Enter` to enter default/skip it, if it asks to enter new value such as Full Name, Room Number, etc. for this new user
- Enter `Y` to confirm the information

    ```bash
    sdevsinx@bdt0:~$ sudo adduser --ingroup hadoop hduser
    ```

    ![sudo-adduser-ingroup-hadoop-hduser](../content_BigDataTechnologies/sudo-adduser-ingroup-hadoop-hduser.png)

### `ssh` setup

- `ssh` has two main components
  1. `ssh` : The command we use to connect to remote machines - the client
  2. `sshd` : THe daemon that is running on the server and allows clients to connect to the server

#### Installing `ssh`

- The `ssh` is pre-enabled on Linux, but in order to start the `sshd` daemon, we need to install the `ssh` first
- Run command below to install `ssh`, this will install ssh on our machine

    ```bash
    sdevsinx@bdt0:~$ sudo apt install ssh
    ```

#### Checking path for `ssh` & `sshd`

- If we get something similar to the following, we can think it is setup properly
- Run below command to get path for `ssh`

    ```bash
    sdevsinx@bdt0:~$ which ssh
    ```

    ![which-ssh](../content_BigDataTechnologies/which-ssh.png)

- Run below command to get path for `sshd`

    ```bash
    sdevsinx@bdt0:~$ which sshd
    ```

    ![which-sshd](../content_BigDataTechnologies/which-sshd.png)

#### Create and Setup SSH Certificates

Hadoop required SSH access to manage its nodes, i.e. remote machines plus our local machine. For our Single-node setup of Hadoop, we therefore need to configure SSH access to localhost

So, we need to have SSH up and running on our machine and configured it to allow SSH public key authentication

Hadoop uses SSH (to access its modes) which would normally require the user to enter a password. However, this requirement can be eliminated by creating and setting up SSH certificates using the following commands, If asked for a filename, just leave it blank and press `Enter` to continue

- First switch user to `hduser` using command below

    ```bash
    sdevsinx@bdt0:~$ su hduser
    ```

    ![su-hduser](../content_BigDataTechnologies/su-hduser.png)

- Then change directory to home directory of `hduser` using command below

    ```bash
    hduser@bdt0:/home/sdevsinx$ cd
    ```

- Now, generate a ssh key using command below, which specifies key type as rsa `-t rsa` and passphrase is empty `-P ""`, if asked for any file name press `Enter`

    ```bash
    hduser@bdt0:~$ ssh-keygen -t rsa -P ""
    ```

    ![ssh-keygen-t-rsa-P-empty](../content_BigDataTechnologies/ssh-keygen-t-rsa-P-empty.png)

- Now copy the newly generated key in `$HOME/.ssh/id_rsa.pub` into `$HOME/.ssh/authorized_keys`

    ```bash
    hduser@bdt0:~$ cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
    ```

- Now, test the ssh connection to localhost since we're setting hadoop on localhost using the command below

    ```bash
    hduser@bdt0:~$ ssh localhost
    ```

    ![ssh-localhost](../content_BigDataTechnologies/ssh-localhost.png)

### Hadoop Setup

#### Downloading Hadoop

- Use the `wget` command-line tool to download the Hadoop v2.6.0 archive to current directory (home directory of `hduser`) from [https://archive.apache.org/dist/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz](https://archive.apache.org/dist/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz), using command below

    ```bash
    hduser@bdt0:~$ wget https://archive.apache.org/dist/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz
    ```

#### Extracting Hadoop

- Once Hadoop archive is downloaded, you need to use `tar` utility to e**x**tract **f**orcibly through g**z**ip while **v**erbosing using the command below

    ```bash
    hduser@bdt0:~$ tar xvzf hadoop-2.6.0.tar.gz
    ```

#### Renaming & Moving Hadoop

- Once files have been extracted, it should have extracted all the files into a directory `hadoop-2.6.0`, which we'll rename to `hadoop` using `mv` utility

    ```bash
    hduser@bdt0:~$ mv hadoop-2.6.0 hadoop
    ```

- Now move this `hadoop` installation to `/usr/local/hadoop` directory using command below, if it does not show any error then you may skip to [Change Ownership of `hadoop` to `hduser:hadoop`](#change-ownership-of-hadoop-to-hduserhadoop)

    ```bash
    hduser@bdt0:~$ mv hadoop /usr/local/
    ```

    ![mv-hadoop-_usr_local_-error-permission-denied](../content_BigDataTechnologies/mv-hadoop-_usr_local_-error-permission-denied.png)

##### Moving hadoop using sudo

- If it showed error `Permission denied` in previous step while moving `hadoop`, then try moving with `sudo`, if it does not show any error then you may skip to [Change Ownership of `hadoop` to `hduser:hadoop`](#change-ownership-of-hadoop-to-hduserhadoop)

    ```bash
    hduser@bdt0:~$ sudo mv hadoop /usr/local/
    ```

    ![sudo-mv-hadoop-_usr_local_-error-sudoers](../content_BigDataTechnologies/sudo-mv-hadoop-_usr_local_-error-sudoers.png)

##### Adding `hduser` to sudoers

- If it showed error `hduser is not in sudoes file`, then you need to first add user `hduser` into sudoers, then try to move with `sudo` prefix
- First switch to previous user using which you've first logged into system (say `sdevsinx`) using command below

    ```bash
    hduser@bdt0:~$ su sdevsinx
    ```

    ![su-sdevsinx-for-adding-to-sudoers](../content_BigDataTechnologies/su-sdevsinx-for-adding-to-sudoers.png)

- now run command below to add user `hduser` to sudoers list/group

    ```bash
    sdevsinx@bdt0:/home/hduser$ sudo adduser hduser sudo
    ```

    ![sudo-adduser-hduser-sudo](../content_BigDataTechnologies/sudo-adduser-hduser-sudo.png)

- Now the `hduser` has root priviledge, we can move the hadoop installation to `/usr/local/hadoop` without any problem
- Now, switch back to user `hduser`

    ```bash
    sdevsinx@bdt0:/home/hduser$ sudo su hduser
    ```

- And, try to move `hadoop` to `/usr/local/hadoop` directory

    ```bash
    hduser@bdt0:~$ sudo mv hadoop /usr/local/
    ```

#### Change Ownership of `hadoop` to `hduser:hadoop`

- Although `/usr/local/hadoop/` should have `hduser:hadoop` as its `owner:group`, but you may run command below just in case

    ```bash
    hduser@bdt0:~$ sudo chown hduser:hadoop /usr/local/hadoop/
    ```

### Configuring files

- The following files will have to be modified to complete the Hadoop setup
  1. `~/.bashrc`
  2. `/usr/local/hadoop/etc/hadoop/hadoop-env.sh`
  3. `/usr/local/hadoop/etc/hadoop/core-site.xml`
  4. `/usr/local/hadoop/etc/hadoop/mapred-site.xml.template`
  5. `/usr/local/hadoop/etc/hadoop/hdfs-site.xml`

#### `~/.bashrc`

- Before editing the `.bashrc` file in home directory of `hduser`, we need to find the path where Java has been installed to set the `JAVA_HOME` environment variable using the following command

    ```bash
    hduser@bdt0:~$ update-alternatives --config java
    ```

    ```console
    There are 2 choices for the alternative java (providing /usr/bin/java).

      Selection    Path                                            Priority   Status
    ------------------------------------------------------------
      0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
      1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
    * 2            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode

    Press <enter> to keep the current choice[*], or type selection number:
    ```

- Now we can append the following to the end of `~./bashrc`, you may open it with `vim` editor to make changes

    ```bash
    hduser@bdt0:~$ vim .bashrc
    ```

    ```bash
    #HADOOP VARIABLES START
    #export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export HADOOP_INSTALL=/usr/local/hadoop
    export PATH=$PATH:$HADOOP_INSTALL/bin
    export PATH=$PATH:$HADOOP_INSTALL/sbin
    export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
    export HADOOP_COMMON_HOME=$HADOOP_INSTALL
    export HADOOP_HDFS_HOME=$HADOOP_INSTALL
    export YARN_HOME=$HADOOP_INSTALL
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
    export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
    #HADOOP VARIABLES END
    ```

- Save the file, and source it using command below

    ```bash
    hduser@bdt0:~$ source ~/.bashrc
    ```

> **Note:** The `JAVA_HOME` should be set as path just before the `.../bin/`

- To cross-check java path is working fine, you may run commands below
    1. check `javac` version

        ```bash
        hduser@bdt0:~$ javac -version
        ```

        ```console
        javac 1.8.0_362
        ```

    2. check `javac` path

        ```bash
        hduser@bdt0:~$ which javac
        ```

        ```console
        /usr/bin/javac
        ```

    3. `readlink` for `javac`

        ```bash
        hduser@bdt0:~$ readlink -f /usr/bin/javac
        ```

        ```console
        /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
        ```

#### `/usr/local/hadoop/etc/hadoop/hadoop-env.sh`

- We need to set `JAVA_HOME` by modifying `hadoop-env.sh`
- You need to append the following at the end of `hadoop-env.sh`, you may open it with `nano` or `vim` editor to make changes

    ```bash
    hduser@bdt0:~$ nano /usr/local/hadoop/etc/hadoop/hadoop-env.sh
    ```

    ```bash
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    ```

- Save changes in the file, adding the above `export` statement in `hadoop-env.sh` file ensure, that the value of `JAVA_HOME` variable will be available to Hadoop whenever it is started up.

#### `/usr/local/hadoop/etc/hadoop/core-site.xml`

- The `/usr/local/hadoop/etc/hadoop/core-site.xml` file contains the configuration properties that Hadoop uses when starting up.
- This file can be used to override the default settings that Hadoop starts with.
- In this file we'll configure two properties
    1. `hadoop.tmp.dir` : A base for other temporary directories
    2. `fs.default.name` : The name of the default file system. A URI whose scheme and authority determine the FileSystem implementation. The uri's scheme determines the config property (fs.SCHEME.impl) naming the FileSystem implementation class. The uri's authority is used to determine the host, port, etc. for a filesystem.

##### Creating `tmp` directory for current user

- But first we need to create a temporary directory for `hadoop.tmp.dir` property, so we'll create a directory `/app/hadoop/tmp` and change ownership to `hduser:hadoop` using command below

    ```bash
    hduser@bdt0:~$ sudo mkdir -p /app/hadoop/tmp
    ```

    ```bash
    hduser@bdt0:~$ sudo chown hduser:hadoop /app/hadoop/tmp/
    ```

- Now open `core-site.xml` file in `nano` or `vim` editor to make changes in the `xml` as shown below

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
    <!--
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License. See accompanying LICENSE file.
    -->

    <!-- Put site-specific property overrides in this file. -->
    <configuration>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/app/hadoop/tmp</value>
        <description>A base for other temporary directories.</description>
    </property>
    <property>
        <name>fs.default.name</name>
        <value>hdfs://localhost:54310</value>
        <description>The name of the default file system. A URI whose scheme and authority determine the FileSystem implementation. The uri's scheme determines the config property (fs.SCHEME.impl) naming the FileSystem implementation class. The uri's authority is used to determine the host, port, etc. for a filesystem.</description>
    </property>
    </configuration>
    ```

#### `/usr/local/hadoop/etc/hadoop/mapred-site.xml.template`

- By default the `/usr/local/hadoop/etc/hadoop/` directory contains `/usr/local/hadoop/etc/hadoop/mapred-site.xml.template` file which has to be renamed/copied with the name `mapred-site.xml`
- The `mapred-site.xml` file is used to specify which framework is being used for MapReduce
- Lets copy `mapred-site.xml.template` to `mapred-site.xml`, use command below

    ```bash
    cp /usr/local/hadoop/etc/hadoop/mapred-site.xml.template /usr/local/hadoop/etc/hadoop/mapred-site.xml
    ```

- Now open `mapred-site.xml` file in `nano` or `vim` editor to make changes in the `xml` as shown below

    ```xml
    <?xml version="1.0"?>
    <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
    <!--
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License. See accompanying LICENSE file.
    -->

    <!-- Put site-specific property overrides in this file. -->

    <configuration>
    <property>
        <name>mapred.job.tracker</name>
        <value>localhost:54311</value>
        <description>The host and port that the MapReduce job tracker runs at. If "local", then jobs are run in-process as a single map and reduce task.</description>
    </property>
    </configuration>
    ```

#### `/usr/local/hadoop/etc/hadoop/hdfs-site.xml`

- The `/usr/local/hadoop/etc/hadoop/hdfs-site.xml` file need to be configured for each host in the cluster that is being used
- It is used to specify the directories which will be used as the `namenode` and the `datanode` on that host
- In this file, we'll configure four properties
    1. `dfs.replication` : Default block replication. The actual number of replications can be specified when the file is created. The default is used if replication is not specified in create time.
    2. `dfs.blocksize` : it is optional to include, We'll keep it commented it here just for indication, but you may un-comment it to set custom default `blocksize`. Default blocksize in hadoop v1.x was 64MB and hadoop v2.0+ has default blocksize of 128MB
    3. `dfs.namenode.name.dir` : namenode file path
    4. `dfs.datanode.data.dir` : datanode file path

##### Creating Name Node and Data Node

- But before editing this file, we need to create two directories, which will contain the `namenode` and the `datanode` for this hadoop installation
    1. Run command below to create `namenode` directory `/usr/local/hadoop_store/hdfs/namenode`

        ```bash
        hduser@bdt0:~$ sudo mkdir -p /usr/local/hadoop_store/hdfs/namenode
        ```

    2. Run command below to create `datanode` directory `/usr/local/hadoop_store/hdfs/datanode`

        ```bash
        hduser@bdt0:~$ sudo mkdir -p /usr/local/hadoop_store/hdfs/datanode
        ```

    3. Run command below to change ownership of `/usr/local/hadoop_store` to `hduser:hadoop`, because we'll need `W` permission for `hduser`

        ```bash
        hduser@bdt0:~$ sudo chown -R hduser:hadoop /usr/local/hadoop_store
        ```

- Now open `hdfs-site.xml` file in `nano` or `vim` editor to make changes in `xml` as shown below

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
    <!--
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License. See accompanying LICENSE file.
    -->

    <!-- Put site-specific property overrides in this file. -->

    <configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
        <description>Default block replication. The actual number of replications can be specified when the file is created. The default is used if replication is not specified in create time.</description>
    </property>
    <!-- <property>
        <name>dfs.blocksize</name>
        <value>27M</value>
    </property> -->
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/usr/local/hadoop_store/hdfs/namenode</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:/usr/local/hadoop_store/hdfs/datanode</value>
    </property>
    </configuration>
    ```

### Formatting The new Hadoop Filesystem

- Now, the Hadoop filesystem needs to be formatted so that we can start to use it
- The format command should be issued with write permission, since it creates current directory under `/usr/local/hadoop_store/hdfs/namenode` directory, and we've already changed ownership to `hduser` so it has **W**rite permission
- Now run the command below to format the hadoop filesystem

    ```bash
    hduser@bdt0:~$ hadoop namenode -format
    ```

    ```console
    DEPRECATED: Use of this script to execute hdfs command is deprecated.
    Instead use the hdfs command for it.

    23/05/26 23:52:43 INFO namenode.NameNode: STARTUP_MSG:
    /************************************************************
    STARTUP_MSG: Starting NameNode
    STARTUP_MSG:   host = bdt0./127.0.1.1
    STARTUP_MSG:   args = [-format]
    STARTUP_MSG:   version = 2.6.0
    STARTUP_MSG:   classpath = /usr/local/hadoop/etc/hadoop:/usr/local/hadoop/share/hadoop/common/lib/commons-net-3.1.jar:...
    ...
    ...
    ...:/contrib/capacity-scheduler/*.jar
    STARTUP_MSG:   build = https://git-wip-us.apache.org/repos/asf/hadoop.git -r e3496499ecb8d220fba99dc5ed4c99c8f9e33bb1; compiled by 'jenkins' on 2014-11-13T21:10Z
    STARTUP_MSG:   java = 1.8.0_362
    ************************************************************/
    23/05/26 23:52:43 INFO namenode.NameNode: registered UNIX signal handlers for [TERM, HUP, INT]
    23/05/26 23:52:43 INFO namenode.NameNode: createNameNode [-format]
    23/05/26 23:52:43 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    Formatting using clusterid: CID-897f8f27-1621-4021-8991-3935b314aa13
    23/05/26 23:52:43 INFO namenode.FSNamesystem: No KeyProvider found.
    23/05/26 23:52:43 INFO namenode.FSNamesystem: fsLock is fair:true
    23/05/26 23:52:43 INFO blockmanagement.DatanodeManager: dfs.block.invalidate.limit=1000
    23/05/26 23:52:43 INFO blockmanagement.DatanodeManager: dfs.namenode.datanode.registration.ip-hostname-check=true
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: dfs.namenode.startup.delay.block.deletion.sec is set to 000:00:00:00.000
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: The block deletion will start around 2024 Sep 11 23:44:43
    23/05/26 23:52:43 INFO util.GSet: Computing capacity for map BlocksMap
    23/05/26 23:52:43 INFO util.GSet: VM type       = 64-bit
    23/05/26 23:52:43 INFO util.GSet: 2.0% max memory 889 MB = 17.8 MB
    23/05/26 23:52:43 INFO util.GSet: capacity      = 2^21 = 2097152 entries
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: dfs.block.access.token.enable=false
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: defaultReplication         = 1
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: maxReplication             = 512
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: minReplication             = 1
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: maxReplicationStreams      = 2
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: shouldCheckForEnoughRacks  = false
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: replicationRecheckInterval = 3000
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: encryptDataTransfer        = false
    23/05/26 23:52:43 INFO blockmanagement.BlockManager: maxNumBlocksToLog          = 1000
    23/05/26 23:52:43 INFO namenode.FSNamesystem: fsOwner             = hduser (auth:SIMPLE)
    23/05/26 23:52:43 INFO namenode.FSNamesystem: supergroup          = supergroup
    23/05/26 23:52:43 INFO namenode.FSNamesystem: isPermissionEnabled = true
    23/05/26 23:52:43 INFO namenode.FSNamesystem: HA Enabled: false
    23/05/26 23:52:43 INFO namenode.FSNamesystem: Append Enabled: true
    23/05/26 23:52:43 INFO util.GSet: Computing capacity for map INodeMap
    23/05/26 23:52:43 INFO util.GSet: VM type       = 64-bit
    23/05/26 23:52:43 INFO util.GSet: 1.0% max memory 889 MB = 8.9 MB
    23/05/26 23:52:43 INFO util.GSet: capacity      = 2^20 = 1048576 entries
    23/05/26 23:52:43 INFO namenode.NameNode: Caching file names occuring more than 10 times
    23/05/26 23:52:43 INFO util.GSet: Computing capacity for map cachedBlocks
    23/05/26 23:52:43 INFO util.GSet: VM type       = 64-bit
    23/05/26 23:52:43 INFO util.GSet: 0.25% max memory 889 MB = 2.2 MB
    23/05/26 23:52:43 INFO util.GSet: capacity      = 2^18 = 262144 entries
    23/05/26 23:52:43 INFO namenode.FSNamesystem: dfs.namenode.safemode.threshold-pct = 0.9990000128746033
    23/05/26 23:52:43 INFO namenode.FSNamesystem: dfs.namenode.safemode.min.datanodes = 0
    23/05/26 23:52:43 INFO namenode.FSNamesystem: dfs.namenode.safemode.extension     = 30000
    23/05/26 23:52:43 INFO namenode.FSNamesystem: Retry cache on namenode is enabled
    23/05/26 23:52:43 INFO namenode.FSNamesystem: Retry cache will use 0.03 of total heap and retry cache entry expiry time is 600000 millis
    23/05/26 23:52:43 INFO util.GSet: Computing capacity for map NameNodeRetryCache
    23/05/26 23:52:43 INFO util.GSet: VM type       = 64-bit
    23/05/26 23:52:43 INFO util.GSet: 0.029999999329447746% max memory 889 MB = 273.1 KB
    23/05/26 23:52:43 INFO util.GSet: capacity      = 2^15 = 32768 entries
    23/05/26 23:52:43 INFO namenode.NNConf: ACLs enabled? false
    23/05/26 23:52:43 INFO namenode.NNConf: XAttrs enabled? true
    23/05/26 23:52:43 INFO namenode.NNConf: Maximum size of an xattr: 16384
    23/05/26 23:52:43 INFO namenode.FSImage: Allocated new BlockPoolId: BP-705116047-127.0.1.1-1726078483419
    23/05/26 23:52:43 INFO common.Storage: Storage directory /usr/local/hadoop_store/hdfs/namenode has been successfully formatted.
    23/05/26 23:52:43 INFO namenode.NNStorageRetentionManager: Going to retain 1 images with txid >= 0
    23/05/26 23:52:43 INFO util.ExitUtil: Exiting with status 0
    23/05/26 23:52:43 INFO namenode.NameNode: SHUTDOWN_MSG:
    /************************************************************
    SHUTDOWN_MSG: Shutting down NameNode at bdt0./127.0.1.1
    ************************************************************/
    ```

> **Warning:** This `hadoop namenode -format` command should be executed once before we start using Hadoop. If this command is executed again after Hadoop has been used, it'll destroy all the data on the Hadoop

### Starting Hadoop Server

- Now its time to start the newly installed Single-node cluster
- You can use command below to start hadoop, if asked to connect via ssh for secondary nodes, type `yes` and press `Enter`

    ```bash
    hduser@bdt0:~$ start-all.sh
    ```

    ```console
    This script is Deprecated. Instead use start-dfs.sh and start-yarn.sh
    23/05/27 00:13:47 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    Starting namenodes on [localhost]
    localhost: starting namenode, logging to /usr/local/hadoop/logs/hadoop-hduser-namenode-bdt0.out
    localhost: starting datanode, logging to /usr/local/hadoop/logs/hadoop-hduser-datanode-bdt0.out
    Starting secondary namenodes [0.0.0.0]
    The authenticity of host '0.0.0.0 (0.0.0.0)' can't be established.
    ED25519 key fingerprint is SHA256:vj8ynkpQlVj6vLgnpVUvCTKfiHuncizUuQ2gE64DkL4.
    This host key is known by the following other names/addresses:
        ~/.ssh/known_hosts:1: [hashed name]
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    0.0.0.0: Warning: Permanently added '0.0.0.0' (ED25519) to the list of known hosts.
    0.0.0.0: starting secondarynamenode, logging to /usr/local/hadoop/logs/hadoop-hduser-secondarynamenode-bdt0.out
    23/05/27 00:15:52 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable starting yarn daemons
    starting resourcemanager, logging to /usr/local/hadoop/logs/yarn-hduser-resourcemanager-bdt0.out
    localhost: starting nodemanager, logging to /usr/local/hadoop/logs/yarn-hduser-nodemanager-bdt0.out
    ```

### Checking Hadoop Processes

#### `jps`

- We can check of its really up  and running using command `jps` which stands for `Java VM Process Status`
- Run command below, which should show PIDs for each of the corresponding classes

    ```bash
    hduser@bdt0:~$ jps
    ```

    ```console
    18113 Jps
    17242 DataNode
    17468 SecondaryNameNode
    17613 ResourceManager
    17103 NameNode
    17727 NodeManager
    ```

- THe output above means that we now have a functional instance of Hadoop running on our VPS (Virtual Private Server)

#### `netstat`

- Another way to check is using `netstat`
- Run command below to filter the `java` processes running over network listing with **p**rograms **l**isteningon **t**cp **e**xtended information with **n**umeric

    ```bash
    hduser@bdt0:~$ netstat -plten | grep java
    ```

    ```console
    (Not all processes could be identified, non-owned process info
    will not be shown, you would have to be root to see it all.)
    tcp        0      0 0.0.0.0:50010           0.0.0.0:*               LISTEN      1001       1767039    124353/java
    tcp        0      0 0.0.0.0:50020           0.0.0.0:*               LISTEN      1001       1767051    124353/java
    tcp        0      0 0.0.0.0:50075           0.0.0.0:*               LISTEN      1001       1767048    124353/java
    tcp        0      0 0.0.0.0:50070           0.0.0.0:*               LISTEN      1001       2029008    124200/java
    tcp        0      0 0.0.0.0:50090           0.0.0.0:*               LISTEN      1001       2082561    125000/java
    tcp        0      0 127.0.0.1:54310         0.0.0.0:*               LISTEN      1001       2029016    124200/java
    tcp6       0      0 :::44101                :::*                    LISTEN      1001       2076298    125500/java
    tcp6       0      0 :::8031                 :::*                    LISTEN      1001       2070528    125202/java
    tcp6       0      0 :::8030                 :::*                    LISTEN      1001       2086044    125202/java
    tcp6       0      0 :::8042                 :::*                    LISTEN      1001       2076309    125500/java
    tcp6       0      0 :::8040                 :::*                    LISTEN      1001       2076305    125500/java
    tcp6       0      0 :::8033                 :::*                    LISTEN      1001       2086059    125202/java
    tcp6       0      0 :::8032                 :::*                    LISTEN      1001       2086048    125202/java
    tcp6       0      0 :::8088                 :::*                    LISTEN      1001       2086052    125202/java
    ```

- In output, you can identify the processes with the `hostname:port` on which process is listening

### Stopping Hadoop Server

- Run the command below to stop the Hadoop server/processes

    ```bash
    hduser@bdt0:~$ stop-all.sh
    ```

    ```console
    This script is Deprecated. Instead use stop-dfs.sh and stop-yarn.sh
    23/05/27 00:41:04 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    Stopping namenodes on [localhost]
    localhost: stopping namenode
    localhost: stopping datanode
    Stopping secondary namenodes [0.0.0.0]
    0.0.0.0: stopping secondarynamenode
    23/05/27 00:41:21 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
    stopping yarn daemons
    stopping resourcemanager
    localhost: stopping nodemanager
    no proxyserver to stop
    ```

### Alternate to start Hadoop Server

- Instead of single command `start-all.sh` to start Hadoop, you may use use two commands below one after another to start Hadoop
    1. Run command below to start dfs

        ```bash
        hduser@bdt0:~$ start-dfs.sh
        ```

    2. Run command below to start yarn

        ```bash
        hduser@bdt0:~$ start-yarn.sh
        ```

- And, instead of single command `stop-all.sh` to stop Hadoop, you may use use two commands below one after another to stop Hadoop
    1. Run command below to stop dfs

        ```bash
        hduser@bdt0:~$ stop-dfs.sh
        ```

    2. Run command below to stop yarn

        ```bash
        hduser@bdt0:~$ stop-yarn.sh
        ```

- You have all the scripts inside `/usr/local/hadoop/sbin` path

    ```bash
    hduser@bdt0:~$ ls -l /usr/local/hadoop/sbin
    ```

    ```console
    total 120
    -rwxr-xr-x 1 hduser hadoop 2752 Nov 14  2014 distribute-exclude.sh
    -rwxr-xr-x 1 hduser hadoop 6452 Nov 14  2014 hadoop-daemon.sh
    -rwxr-xr-x 1 hduser hadoop 1360 Nov 14  2014 hadoop-daemons.sh
    -rwxr-xr-x 1 hduser hadoop 1640 Nov 14  2014 hdfs-config.cmd
    -rwxr-xr-x 1 hduser hadoop 1427 Nov 14  2014 hdfs-config.sh
    -rwxr-xr-x 1 hduser hadoop 2291 Nov 14  2014 httpfs.sh
    -rwxr-xr-x 1 hduser hadoop 2059 Nov 14  2014 kms.sh
    -rwxr-xr-x 1 hduser hadoop 4080 Nov 14  2014 mr-jobhistory-daemon.sh
    -rwxr-xr-x 1 hduser hadoop 1648 Nov 14  2014 refresh-namenodes.sh
    -rwxr-xr-x 1 hduser hadoop 2145 Nov 14  2014 slaves.sh
    -rwxr-xr-x 1 hduser hadoop 1779 Nov 14  2014 start-all.cmd
    -rwxr-xr-x 1 hduser hadoop 1471 Nov 14  2014 start-all.sh
    -rwxr-xr-x 1 hduser hadoop 1128 Nov 14  2014 start-balancer.sh
    -rwxr-xr-x 1 hduser hadoop 1401 Nov 14  2014 start-dfs.cmd
    -rwxr-xr-x 1 hduser hadoop 3705 Nov 14  2014 start-dfs.sh
    -rwxr-xr-x 1 hduser hadoop 1357 Nov 14  2014 start-secure-dns.sh
    -rwxr-xr-x 1 hduser hadoop 1571 Nov 14  2014 start-yarn.cmd
    -rwxr-xr-x 1 hduser hadoop 1347 Nov 14  2014 start-yarn.sh
    -rwxr-xr-x 1 hduser hadoop 1770 Nov 14  2014 stop-all.cmd
    -rwxr-xr-x 1 hduser hadoop 1462 Nov 14  2014 stop-all.sh
    -rwxr-xr-x 1 hduser hadoop 1179 Nov 14  2014 stop-balancer.sh
    -rwxr-xr-x 1 hduser hadoop 1455 Nov 14  2014 stop-dfs.cmd
    -rwxr-xr-x 1 hduser hadoop 3206 Nov 14  2014 stop-dfs.sh
    -rwxr-xr-x 1 hduser hadoop 1340 Nov 14  2014 stop-secure-dns.sh
    -rwxr-xr-x 1 hduser hadoop 1642 Nov 14  2014 stop-yarn.cmd
    -rwxr-xr-x 1 hduser hadoop 1340 Nov 14  2014 stop-yarn.sh
    -rwxr-xr-x 1 hduser hadoop 4295 Nov 14  2014 yarn-daemon.sh
    -rwxr-xr-x 1 hduser hadoop 1353 Nov 14  2014 yarn-daemons.sh
    ```

### Hadoop Web Interface

- To access Haoop web interface, we'll need Hadoop running again
- Once all processes of Hadoop is up and running, you may visit [http://localhost:50070/](http://localhost:50070/) to access the Web UI of the NameNode daemon

    ![Hadoop-web-UI](../content_BigDataTechnologies/Hadoop-web-UI.png)

## Apache Hive

1. is an open-source ETL (Extract-Transform-Load) tool created by Facebook by Joydeep Sen Sarma and Ashish Thusoo
2. started as sub-project for Hadoop, later became top-level project
3. Apache hive was created for two goals
    1. an SQL-based declarative language that also allowed engineers to be able to plug in their own scripts & programs when SQL didn't suffice, thus enabling most engineering world (SQL skill based) to use Hive with minimal disruption
    2. provided centralized meta-store (Hadoop-based) of all datasets in the organization
4. Initially developed within Facebook, its used & developed by other companies such as Netflix, Amazon maintaining a fork of Apache Hive included in Amazon EMR (Elastic MapReduce)
5. used to submit SQL queries
6. Compiles SQL query and converts it into `jar` files, and then jar files will be run by `YARN`
7. It needs a local database, so we first create a local database to store the data from the splits/blocks stored on DataNodes
8. The local database need to be created prior loading data, considering the structure of data/file being read from DataNodes
9. Tables and Data are in separate folder/location
10. Tables should be mapped to hadoop folder
11. Table is created in meta-store
12. Table is just for schema reference
13. HIVE tool takes SQL query, converts SQL query into `jar` file internally, and launches `jar` file on ResourceManager
14. **Not** built for OLTP workloads
15. is frequently used for OLAP workloads/data-warehousing tasks like data encapsulation, Ad-Hoc queries & analysis of huge datasets
16. designed to enhance scalability, extensibility, performance, fault-tolerance & loose-coupling with its input formats

![Hive-annotation](../content_BigDataTechnologies/Hive-annotation.png)

### Features of Hive

- Supports analysis of large datasets stored in Hadoop's HDFS & compatible filesystems such as Amazon S3, Azure Blob Storage, Azure Data Lake Storage (ADLS), Google Cloud Storage & Alluxio
- Provides a SQL-like query language `HiveQL`, with schema-on-read and transparently converts queries to Apache Spark, MapReduce & Apache Tez jobs
- Hive Data Functions help processing and querying big datasets, by providing functionalities such as string manipulation, date manipulation, type conversion, conditional operators, mathematical functions, etc.
- Metadata storage is in a RDBMS reduces time to perform semantic checks during query execution
- different storage types such as parquet, plain text, RCFiles, HBase, ORC, etc.
- Operating on compressed data stored into the Hadoop ecosystem using algorithms such as DEFLATE, BWT, snappy, etc.
- Built-in User Defined Functions (UDFs) to manipulate dates, strings, and other data mining tools, also supports extending the UDF set to handle use-cases not supported by built-in functions
- SQL-like queries (HiveSQL), implicitly converted into MapReduce or Tez or Spark Jobs

### Hive Advantages

1. **Scalability :** designed to handle huge volumes of data
2. **Familiar SQL-like interface :** uses SQL-like language called HiveQL, recducing disruptions/retraining
3. **Integration with Hadoop ecosystem :** integrates well with Hdoop ecosystem, enabling users to process data with Hadoop tools such as Pig, MapReduce & Spark
4. **Supports partitioning & bucketing :** can improve query partitioning by limiting the data to be read, by implementing partitioning & bucketing
5. **User-Defined Functions :** users can define UDFs which can be used in HiveQL

### Disadvantages Hive

1. **Limited Real-Time Processing :** designed for Batch-processing, not a best tool for real-time data processing
2. **Slow Performance :** can become slower than traditional databases since it is built on top of Hadoop, which makes it optimized for batch processing rather than interactive querying
3. **Steep learning curve :** while it is a SQL-like language, it still requires users to have knowledge of Hadoop & distributed computing, thus difficult for beginners
4. **lack of support for transactions :** does not supports transactions, so difficulty to maintain consistency
5. **Limited Flexibility :** not as flexible as other data-warehousing tools, since its designed specifically to work with Hadoop, which limits its usability in other environemnts

### Hive Architecture

![Hive-architecture](../content_BigDataTechnologies/Hive-architecture.png)

![Hive-architecture-annotation](../content_BigDataTechnologies/Hive-architecture-annotation.png)

- The key components of the Apache Hive architecture are `Hive Server 2`, `Hive Query Language (HiveQL/HQL)`, external `Apache Metastore` and `Hive Beeline shell`

1. **Hive Server 2 :** accepts incoming requests from users & creates an execution plan, auto-generates a YARN job to process SQL queries. It also supports the Hive optimizer and Hive compiler to streamline data extraction and processing.

2. **Hive Query Language :**  By enabling the implementation of SQL-reminiscent code, Hive negates the need for long-winded JavaScript codes to sort through unstructured data & allows users to make queries using built-in HQL statements (HQL). These statements can be used to navigate large datasets, refine results, and share data in a code-effective and time-efficient manner.

3. **Hive Metastore :** is the central repository of the Apache Hive infrastructure. Using metastore, Hive can also be formatted into Hive tables and partitions, to compare data across relational databases. Metastore includes table names, column names, data types, partition information and data location on HDFS.

4. **Hive Beeline Shell :** In line with other DBMS, Hive has its own built-in command-line interface where users can run HQL statements. Hive shell also runs Hive JDBC & ODBC drivers, so able to conduct queries on Open DB connection or Java DB connection apps.

### Hive CLI

- `Hive Shell` or `Hive CLI` is a shell utility at `$HIVE_HOME/bin/hive`, which can be used to run Hive queries in either interactive or batch mode
- `HiveServer2` (introduced in Hive 0.11) has its own CLI called `Beeline`, which is a JDBC client based on `SQLLine`
- `Hive CLI` is an older part of Apache Hive, and now deprecated, so command-line is migrated to Beeline is recommended.
- Hive CLI is a legacy tool which had two main use cases
    1. it served as a thick client for SQL Hadoop
    2. it served as a command-line tool for Hive Server (the original Hive Server, now often referred as `HiveServer`)
- `HiveServer` has been deprecated and removed from the code base as of Hive v1.0.0 and replaced with `HiveServer2`, so the second use case no longer applies
- For the First usecase, `Beeline` provides or is supposed to provide equal functionality, yet is implemented differently from Hive CLI
- Ideally, `Hive CLI` should have been deprecated as Hive community haslong recommended using the `Beeline` plus `HiveServer2`configuration, however, because of the wide use of Hive CLI, we instead are replacing the `Hive CLI`'s implementation with a new `Hive CLI` on top of `Beeline` plus embedded `HiveServer2`, so that the Hive community needs to maintain a single code path. In this way, the new `Hive CLI` is just an alias to `Beeline` at both the shell-script level and the high-code level. The goal is that no or minimal changes are required from existing user scripts using `Hive CLI`

#### Beeline

- `HiveServer2`supports a new command-line shell `Beeline`, that works with `HiveServer2`
- Its a JDBC client based on the `SQLLine CLI`
- `Beeline` shell works in both embedded mode as well as remote mode
  - In embedded mode, it runs an embedded Hive (similar to Hive CLI)
  - While remote mode is for connecting to a separate `HiveServer2` over `Thrift` protocol
- Starting in Hive v0.14, when Beeline is used with `HiveServer2`, it also prints the log messages from `HiveServer2` for queries it executes to `STDERR`

| Option | Description |
| :- | :- |
| `-u <database URL>` | The JDBC URL to connect to. Usage: `beeline -u db_URL` |
| `-n <username>` | The username to connect as. Usage: `beeline -n valid_user` |
| `-p <password>` | The password to connect as. Usage: `beeline -p valid_password` |
| `-d <driver class>` | The driver class to use. Usage: `beeline -d driver_class` |
| `-e <query>` | Query that should be executed. Double or single quotes enclose the query string. This option can be specified multiple times. Usage: `beeline -e "query_string"`|
| `-f <file>` | Script file that should be executed. Usage: `beeline -f filepath` |
| `--hiveconf property=value` | Use value for the given configuration property. Properties that are listed in hive.conf.restricted.list cannot be reset with **hiveconf**. Usage: `beeline --hiveconf prop1=value1` |
| `--hivevar name=value` | Hive variable name and value. This is a Hive-specific setting in which variables can be set at the session level and referenced in Hive commands or queries. Usage: `beeline --hivevar var1=value1` |

#### Starting Hive CLI

- The CLI when invoked without `-i` option, will attempt to load `$HIVE_HOME/bin/.hiverc` and `$HOME/.hiverc` as initialization files
- When `$HIVE_HOME/bin/hive` is run with the `-e` or `-f` option, it executes SQL commands in batch mode
- `hive -e <SQLQuery-String>` executes the SQL query string
- `hive -f <filePath>` executes one or more SQL queries form a file
- When `$HIVE_HOME/bin` is run without either `-e` or `-f` option, it enters interactive shell mode
  - Use `;` (semi-colon) to terminate commands
  - Comments in scripts can be specified using the `--` prefix

| Command | Description |
| :- | :- |
| `quit` `exit` | Use `quit` or `exit` to leave the interactive shell. |
| `reset` | Resets the configuration to the default values (as of Hive 0.10). |
| `set <key>=<value>` | Sets the value of a particular configuration variable (key). |
| | If you misspell the variable name, the CLI will not show an error. |
| `set` | Prints a list of configuration variables that are overridden by the user or Hive. |
| `set -v` | Prints all Hadoop and Hive configuration variables. |
| `add FILE[S] <filepath> <filepath>*` | Adds one or more **files** to the list of resources in the distributed cache. |
| `add JAR[S] <filepath> <filepath>*` | Adds one or more **jars** to the list of resources in the distributed cache. |
| `add ARCHIVE[S] <filepath> <filepath>*` | Adds one or more **archives** to the list of resources in the distributed cache. |
| `list FILE[S]` | Lists the resources already added to the distributed cache. |
| `list JAR[S]` | Lists the resources already added to the distributed cache. |
| `list ARCHIVE[S]` | Lists the resources already added to the distributed cache. |
| `list FILE[S] <filepath>*` | Checks whether the given resources are already added to the distributed cache or not. |
| `list JAR[S] <filepath>*` | Checks whether the given resources are already added to the distributed cache or not. |
| `list ARCHIVE[S] <filepath>*` | Checks whether the given resources are already added to the distributed cache or not. |
| `delete FILE[S] <filepath>*` | Removes the resource(s) from the distributed cache. |
| `delete JAR[S] <filepath>*` | Removes the resource(s) from the distributed cache. |
| `delete ARCHIVE[S] <filepath>*` | Removes the resource(s) from the distributed cache. |
| `! <command>` | Executes a shell command from the Hive shell. |
| `dfs <dfs command>` | Executes a dfs command from the Hive shell. |
| `<query string>` | Executes a Hive query and prints results to standard output. |
| `source <filepath>` | Executes a script file inside the CLI. |

- Start hive CLI using command below, it launches hive interactive shell mode

    ```hive
    [bigdatalab456422@ip-10-1-1-204 ~]$ hive
    ```

    ![Start-hive-cli](../content_BigDataTechnologies/Start-hive-cli.png)

#### Setup Hive CLI to print current db

- Run command below to set `hive.cli.print.current.db` to `true` which sets the control to print the current database in use, it won't print any errror message even if you made a mistake in typing the property

    ```hive
    hive> set hive.cli.print.current.db = true ;
    ```

#### SHOW DATABASES

- Run command below to print the databases in current `default` database

    ```hive
    hive (default)> SHOW DATABASES;
    ```

    ```console
    OK
    01_piyali
    01piyali
    03jav2023
    03march2023...
    ...
    ...
    ...zaq
    zeus_pract
    zome
    Time taken: 1.537 seconds, Fetched: 1028 row(s)
    ```

#### CREATE DATABASE

- Run command below to create a database `sandeep_training`

    ```hive
    hive (default)> CREATE DATABASE sandeep_training;
    ```

    ![CREATE-DATABASE-sandeep_training](../content_BigDataTechnologies/CREATE-DATABASE-sandeep_training.png)

- Run command below to create a database `surya_training`

    ```hive
    hive (default)> CREATE DATABASE surya_training ;
    ```

    ```console
    OK
    Time taken: 0.2 seconds
    hive (default)> 
    ```

- You may open the `Hue` tool and open the path fot hive warehouse `/user/hive/warehouse` to locate this new database `surya_training`, so path for new database would be `/user/hive/warehouse/surya_training.db`

    ![Hue-_user_hive_warehouse_surya_training_db](../content_BigDataTechnologies/Hue-_user_hive_warehouse_surya_training_db.png)

    ![Hue-_user_hive_warehouse_sandeep_training_db_annotation](../content_BigDataTechnologies/Hue-_user_hive_warehouse_sandeep_training_db_annotation.png)

#### Change Current Database `USE database`

- Run `USE` command as shown below to change to this new database `surya_training`

    ```hive
    hive (default)> USE surya_training ;
    ```

    ```console
    OK
    Time taken: 0.029 seconds
    hive (surya_training)>
    ```

#### `SHOW TABLES` in Current Database

- Run command below to see table in this new database `surya_training`

    ```hive
    hive (surya_training)> SHOW TABLES ;
    ```

    ```console
    OK
    Time taken: 0.067 seconds
    hive (surya_training)>
    ```

#### `CREATE TABLE nyse`

- Run the command below to create a table `nyse` for `NYSE.csv` dataset

    ```hive
    hive (surya_training)> create table nyse (exchange_name string, stock_id string, stk_date date,
    open double, high double, low double,
    close double, volume bigint, adj_close double
    row format delimited
    fields terminated by ','
    stored as textfile;
    ```

    ```console
    OK
    Time taken: 0.132 seconds
    hive (surya_training)>
    ```

> **Note:** While creating a table, remember
    1. Number of columns = Number of fields
    2. Proper Data types to be used
    3. Proper Delimiter to be used

##### SHOW TABLES

- Now run `SHOW TABLES` command to confirm `nyse` table is created

    ```hive
    hive (surya_training)> SHOW TABLES ;
    ```

    ```console
    OK
    nyse
    Time taken: 0.054 seconds, Fetched: 1 row(s)
    hive (surya_training)>
    ```

#### DESC describe `nyse` table

- To descibe/get schema information of a table, run `DESC` command for table `nyse` as below

    ```hive
    hive (surya_training)> DESC nyse ;
    ```

    ```console
    OK
    exchange_name           string
    stock_id                string
    stk_date                date
    open                    double
    high                    double
    low                     double
    close                   double
    volume                  bigint
    adj_close               double
    Time taken: 0.069 seconds, Fetched: 9 row(s)
    hive (surya_training)>
    ```

#### DESC FORMATTED `nyse` table

- To describe/get schema information along with deailed table information and Storage information, use `DESC FORMATTED` command on `nyse` table

    ```hive
    hive (surya_training)> DESC FORMATTED nyse ;
    ```

    ![DESC-FORMATTED-nyse](../content_BigDataTechnologies/DESC-FORMATTED-nyse.png)

- In the output, notice that it shows the actual Location of the table, table type is `MANAGED_TABLE`, SerDes Library is `LazySimpleSerDe`

#### SELECT records from table

- To print records from a table, use `SELECT` command to print all records from `nyse` table (it should print zero records, since no data has been inserted into it)

    ```hive
    hive (surya_training)> SELECT * FROM nyse ;
    ```

    ```console
    OK
    Time taken: 0.366 seconds
    hive (surya_training)>
    ```

#### Moving data into  `nyse` table

- You need to use `hadoop fs -mv` utility to move `NYSE.csv` which we uploaded in early days, to the table location we got from `Hue` tool, so use th command below to move the data set to managed table `nyse`, but you need to execute this command on `Hadoop client CLI` (not on this `Hive CLI`), You may open Hadoop client CLI in another web-browser tab, or exit this `Hive CLI` using command `exit`

    ```bash
    [bigdatalab456422@ip-10-1-1-204 ~]$ hadoop fs -mv /user/bigdatalab456422/training/NYSE.csv /user/hive/warehouse/surya_training.db/nyse
    ```

##### SELECT records from `nyse`

- If you have exited from `Hive CLI`, launch it again using command `hive` or if `Hive CLI` is already available, you may run the `SELECT` command to print first 10 records from `nyse` table, it should print 10 records this time as we have mapped data set into the table directory

    ```hive
    hive (surya_training)> SELECT * FROM nyse LIMIT 10 ;
    ```

    ![SELECT-_-FROM-nyse-LIMIT-10](../content_BigDataTechnologies/SELECT-_-FROM-nyse-LIMIT-10.png)

### Run Analytical Hive Queries

- Now, your data is loaded into the table, you may do further analytical processing by just launching SQL like Hive queries, it'll convert SQL query into `jar` file internally, and launch that `jar` file on ResourceManager to perfrom the processing

#### Find the Total Volume for each Stock

- Now you jsut need to run a SQL like Hive Query and Hive will do all the processing using Hadoop/mapReduce in the background

    ```hive
    hive (surya_training)> SELECT stock_id, sum (volume) FROM nyse GROUP BY stock_id ;
    ```

    ![SELECT-stock_id_-sum-_volume_-FROM-nyse-GROUP-BY-stock_id_1](../content_BigDataTechnologies/SELECT-stock_id_-sum-_volume_-FROM-nyse-GROUP-BY-stock_id.png)

#### Find the top 10 Highest Volume stocks

- Run the command below

    ```hive
    hive (surya_training)> SELECT stock_id, sum(volume) AS total_vol FROM nyse GROUP BY stock_id ORDER BY total_vol DESC LIMIT 10;
    ```

    ![SELECT-stock_id_-sum_volume_-AS-total_vol-FROM-nyse-GROUP-BY-stock_id-ORDER-BY-total_vol-DESC-LIMIT-10](../content_BigDataTechnologies/SELECT-stock_id_-sum_volume_-AS-total_vol-FROM-nyse-GROUP-BY-stock_id-ORDER-BY-total_vol-DESC-LIMIT-10.png)

> Notice that, running analytical queries on Hive is much faster & a lot easier than MapReduce on Hadoop, it can complete the query within few seconds, while MapReduce took a couple of minutes for the same job

#### Find the All Time Low Price for each Stock

- Run the command below

    ```hive
    hive (surya_training)> SELECT stock_id, min(low) FROM nyse GROUP BY stock_id;
    ```

    ![SELECT-stock_id_-min_low_-FROM-nyse-GROUP-BY-stock_id](../content_BigDataTechnologies/SELECT-stock_id_-min_low_-FROM-nyse-GROUP-BY-stock_id.png)

#### Find All Time High Price for each Stock

- Run the command below, and confirm if `AEA` stock has value `23.94`

    ```hive
    hive (surya_training)> SELECT stock_id, max(high) FROM nyse GROUP BY stock_id;
    ```

    ![SELECT-stock_id_-max_high_-FROM-nyse-GROUP-BY-stock_id](../content_BigDataTechnologies/SELECT-stock_id_-max_high_-FROM-nyse-GROUP-BY-stock_id.png)

### Save Hive Query output to a file

#### Save Total Volume for each Stock in row format file with fields demilited by `,`

- To save output to a file, we need to use `INSERT OVERWRITE DIRECTORY <dirPath>` clause
- Run the command below to save data into file `hive/result1` which will be created in user directory, file will be row formatted & fields sill be delimited by `,`

    ```hive
    hive (surya_training)> INSERT OVERWRITE DIRECTORY 'hive/result1' ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    SELECT stock_id, sum(volume) FROM nyse GROUP BY stock_id;
    ```

    ```console
    Query ID = bigdatalab456422_20230524071018_0a7286c1-718f-4a18-897d-7c8567317622
    Total jobs = 1
    Launching Job 1 out of 1
    Number of reduce tasks not specified. Estimated from input data size: 1
    In order to change the average load for a reducer (in bytes):
      set hive.exec.reducers.bytes.per.reducer=<number>
    In order to limit the maximum number of reducers:
      set hive.exec.reducers.max=<number>
    In order to set a constant number of reducers:
      set mapreduce.job.reduces=<number>
    23/05/24 07:10:19 INFO client.RMProxy: Connecting to ResourceManager at ip-10-1-1-204.ap-south-1.compute.internal/10.1.1.204:8032
    23/05/24 07:10:19 INFO client.RMProxy: Connecting to ResourceManager at ip-10-1-1-204.ap-south-1.compute.internal/10.1.1.204:8032
    Starting Job = job_1684866872278_0374, Tracking URL = http://ip-10-1-1-204.ap-south-1.compute.internal:6066/proxy/application_1684866872278_0374/
    Kill Command = /opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/lib/hadoop/bin/hadoop job -kill job_1684866872278_0374
    Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
    2023-05-24 07:11:26,556 Stage-1 map = 0%, reduce = 0%
    2023-05-24 07:11:54,284 Stage-1 map = 100%, reduce = 0%, Cumulative CPU 6.1 sec
    2023-05-24 07:12:14,119 Stage-1 map = 100%, reduce = 100%, Cumulative CPU 8.52 sec
    MapReduce Total cumulative CPU time: 8 seconds 520 msec
    Ended Job = job_1684866872278_0374
    Moving data to directory hive/result1
    MapReduce Jobs Launched:
    Stage-Stage-1: Map: 1 Reduce: 1 Cumulative CPU: 8.52 sec HDFS Read: 41000225 HDFS Write: 2918 HDFS EC Read: 0 SUCCESS
    Total MapReduce CPU Time Spent: 8 seconds 520 msec
    OK
    Time taken: 118.308 seconds
    hive (surya_training)>
    ```

- To view the output file/dump, Open `Hue` tool and open the path `/user/bigdatalab456422/hive/result1`, notice that it has only one file `000000_0` which is the only partition we have here

    ![Hue-_user_bigdatalab456422_hive_result1](../content_BigDataTechnologies/Hue-_user_bigdatalab456422_hive_result1.png)

- Now if you open this file `000000_0` in Hue tool, you can see the fields are separated by `,` in a row format

    ![Hue-_user_bigdatalab456422_hive_result1_000000_0](../content_BigDataTechnologies/Hue-_user_bigdatalab456422_hive_result1_000000_0.png)

### Save AllTimeHigh, AllTimeLow, AverageClose for each Stock in file

- Run the command below

    ```hive
    hive (surya_training)> INSERT OVERWRITE DIRECTORY 'hive/result2' ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    SELECT stock_id, max(high), min(low), round(avg(close), 2) FROM nyse GROUP BY stock_id;
    ```

    ```console
    Query ID = bigdatalab456422_20230524072336_7a5d4b20-1939-4828-8699-8a49ed1fef3f
    Total jobs = 1
    Launching Job 1 out of 1
    Number of reduce tasks not specified. Estimated from input data size: 1
    In order to change the average load for a reducer (in bytes):
      set hive.exec.reducers.bytes.per.reducer=<number>
    In order to limit the maximum number of reducers:
      set hive.exec.reducers.max=<number>
    In order to set a constant number of reducers:
      set mapreduce.job.reduces=<number>
    23/05/24 07:23:36 INFO client.RMProxy: Connecting to ResourceManager at ip-10-1-1-204.ap-south-1.compute.internal/10.1.1.204:8032
    23/05/24 07:23:36 INFO client.RMProxy: Connecting to ResourceManager at ip-10-1-1-204.ap-south-1.compute.internal/10.1.1.204:8032
    Starting Job = job_1684866872278_0396, Tracking URL = http://ip-10-1-1-204.ap-south-1.compute.internal:6066/proxy/application_1684866872278_0396/
    Kill Command = /opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/lib/hadoop/bin/hadoop job -kill job_1684866872278_0396
    Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
    2023-05-24 07:23:51,461 Stage-1 map = 0%, reduce = 0%
    2023-05-24 07:24:07,120 Stage-1 map = 100%, reduce = 0%, Cumulative CPU 8.59 sec
    2023-05-24 07:24:16,561 Stage-1 map = 100%, reduce = 100%, Cumulative CPU 13.89 sec
    MapReduce Total cumulative CPU time: 13 seconds 890 msec
    Ended Job = job_1684866872278_0396
    Moving data to directory hive/result2
    MapReduce Jobs Launched:
    Stage-Stage-1: Map: 1 Reduce: 1 Cumulative CPU: 13.89 sec HDFS Read: 41002190 HDFS Write: 4215 HDFS EC Read: 0 SUCCESS
    Total MapReduce CPU Time Spent: 13 seconds 890 msec
    OK
    Time taken: 41.592 seconds
    hive (surya_training)>
    ```

- To view the output file/dump, Open `Hue` tool and open the path `/user/bigdatalab456422/hive/result2`, notice that it has only one file 000000_0 which is the only partition we have here

    ![Hue-_user_bigdatalab456422_hive_result2](../content_BigDataTechnologies/Hue-_user_bigdatalab456422_hive_result2.png)

- Now if you open this file `000000_0` in Hue tool, you can see the fields are separated by `,` in a row format

    ![Hue-_user_bigdatalab456422_hive_result2_000000_0](../content_BigDataTechnologies/Hue-_user_bigdatalab456422_hive_result2_000000_0.png)

### Save Hive Query output to another table

- Lets first check how many tables do we have in current database, we should only see `nyse` table

    ```hive
    hive (surya_training)> SHOW TABLES ;
    ```

    ```console
    OK
    nyse
    Time taken: 0.034 seconds, Fetched: 1 row(s)
    hive (surya_training)>
    ```

#### Save Total Volume of each Stock in another Table

- To save output to another table, we need to use `CREATE TABLE <tableName> AS` clause
- Run the command below

    ```hive
    hive (surya_training)> CREATE TABLE stkvol AS
    SELECT stock_id, sum(volume) AS total_vol FROM nyse GROUP BY stock_id;
    ```

    ```console
    Query ID = bigdatalab456422_20230524073028_d3a92865-6298-4b0b-8208-c8a9bd75ac9d
    Total jobs = 1
    Launching Job 1 out of 1
    Number of reduce tasks not specified. Estimated from input data size: 1
    In order to change the average load for a reducer (in bytes):
      set hive.exec.reducers.bytes.per.reducer=<number>
    In order to limit the maximum number of reducers:
      set hive.exec.reducers.max=<number>
    In order to set a constant number of reducers:
      set mapreduce.job.reduces=<number>
    23/05/24 07:30:28 INFO client.RMProxy: Connecting to ResourceManager at ip-10-1-1-204.ap-south-1.compute.internal/10.1.1.204:8032
    23/05/24 07:30:28 INFO client.RMProxy: Connecting to ResourceManager at ip-10-1-1-204.ap-south-1.compute.internal/10.1.1.204:8032
    Starting Job = job_1684866872278_0397, Tracking URL = http://ip-10-1-1-204.ap-south-1.compute.internal:6066/proxy/application_1684866872278_0397/
    Kill Command = /opt/cloudera/parcels/CDH-6.2.1-1.cdh6.2.1.p0.1425774/lib/hadoop/bin/hadoop job -kill job_1684866872278_0397
    Hadoop job information for Stage-1: number of mappers: 1; number of reducers: 1
    2023-05-24 07:30:37,678 Stage-1 map = 0%, reduce = 0%
    2023-05-24 07:30:47,000 Stage-1 map = 100%, reduce = 0%, Cumulative CPU 4.11 sec
    2023-05-24 07:30:54,291 Stage-1 map = 100%, reduce = 100%, Cumulative CPU 7.21 sec
    MapReduce Total cumulative CPU time: 7 seconds 210 msec
    Ended Job = job_1684866872278_0397
    Moving data to directory hdfs://nameservice1/user/hive/warehouse/surya_training.db/stkvol
    MapReduce Jobs Launched:
    Stage-Stage-1: Map: 1 Reduce: 1 Cumulative CPU: 7.21 sec HDFS Read: 41000385 HDFS Write: 2998 HDFS EC Read: 0 SUCCESS
    Total MapReduce CPU Time Spent: 7 seconds 210 msec
    OK
    Time taken: 28.605 seconds
    hive (surya_training)>
    ```

- Run the command below to check if new table has been created to which data has been dumped

    ```hive
    hive (surya_training)> SHOW TABLES ;
    ```

    ```console
    OK
    nyse
    stkvol
    Time taken: 0.037 seconds, Fetched: 2 row(s)
    hive (surya_training)>
    ```

- Run `SELECT` command as show below to print first 10 records from the table `stkvol` which has been created to dump the output

    ```hive
    hive (surya_training)> SELECT * FROM stkvol LIMIT 10;
    ```

    ```console
    OK
    AA      42061448400
    AAI     5246821400
    AAN     817567400
    AAP     2802701500
    AAR     49882000
    AAV     834246600
    AB      1125446300
    ABA     11686500
    ABB     4532301800
    ABC     11439581700
    Time taken: 0.081 seconds, Fetched: 10 row(s)
    hive (surya_training)>
    ```
