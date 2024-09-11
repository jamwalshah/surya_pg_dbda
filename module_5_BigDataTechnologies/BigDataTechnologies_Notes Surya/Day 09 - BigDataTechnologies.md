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

- Now its tiem to start the newly installed Single-node cluster

### Checking Java Processes

### Stopping Hadoop Server

### Alternate to start Hadoop Server

### Hadoop Web Interface

## Hive

### Hive Architecture

### Hive CLI

#### Starting Hive CLI

#### Setup Hive CLI to print current db

#### SHOW DATABASES

#### CREATE DATABASE

#### Change Current Database `USE database`

#### `SHOW TABLES` in Current Database

#### `CREATE TABLE nyse`

##### SHOW TABLES

#### DESC

#### DESC FORMATTED

#### SELECT
