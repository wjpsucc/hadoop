# 02 Install ambari-server and ambari-agent 

# **Author:** Linou.Zhang
# **Create Time:** 2017/7/31


###	0. ntp service
@all nodes
yum install -y ntp
systemctl enable ntpd.service
systemctl start ntpd.service
systemctl status ntpd.service

###	1. Prepare repo
# 1) use public repo
cd /etc/yum.repos.d/
wget http://s3.amazonaws.com/public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.2.0/ambari.repo

# 2) use local repo
# use the repo prepared in 01_config_local_hdp_repo.sh for all nodes
@ all nodes
cat /etc/yum.repos.d/ambari.repo
[Updates-ambari-2.5.1.0]
name=ambari-2.5.1.0-Updates
baseurl=http://192.168.56.10/hdp/ambari/centos7/
gpgcheck=1
gpgkey=http://public-repo-1.hortonworks.com/ambari/centos7/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
enabled=1
priority=1

###	2. install jdbc connector
yum install -y mysql-connector-java

###	3. install ambari server
@ hdpca
yum install -y ambari-server

###	4. install ambari agent on all nodes
yum install -y ambari-agent

###	5. create schema in mysql database master02
# install mysql:
@ nhdpca-node1
yum install -y mariadb-server

systemctl start mariadb.service
systemctl status mariadb.service

# To set the MySQL root password:
/usr/bin/mysql_secure_installation
[...]
Enter current password for root (enter for none):
OK, successfully used password, moving on...
[...]
Set root password? [Y/n] y
New password:
Re-enter new password:
Remove anonymous users? [Y/n] Y
[...]
Disallow root login remotely? [Y/n] N
[...]
Remove test database and access to it [Y/n] Y
[...]
Reload privilege tables now? [Y/n] Y
All done!

# cp ambari schema ddl from ambari server
scp master01:/var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql ./

mysql -u root -p


-- hive
CREATE DATABASE metastore;
USE metastore;
CREATE USER 'hiveuser'@'%' IDENTIFIED BY 'hive';
GRANT ALL ON metastore.* TO 'hiveuser'@'%';

-- ambari
CREATE DATABASE ambari;
USE ambari;
CREATE USER 'ambari'@'%' IDENTIFIED BY 'bigdata';
GRANT ALL ON ambari.* TO 'ambari'@'%';

-- oozie
CREATE DATABASE oozie;
USE oozie;
CREATE USER 'oozie'@'%' IDENTIFIED BY 'oozie';
GRANT ALL ON oozie.* TO 'oozie'@'%';

-- knox
CREATE DATABASE knox;
USE knox;
CREATE USER 'knox'@'%' IDENTIFIED BY 'knox';
GRANT ALL ON knox.* TO 'knox'@'%';

-- ranger
CREATE DATABASE ranger;
USE ranger;

CREATE USER 'ranger'@'%' IDENTIFIED BY 'ranger';
GRANT ALL ON ranger.* TO 'ranger'@'%';

CREATE USER 'rangeradmin'@'%' IDENTIFIED BY 'ranger';
GRANT ALL ON ranger.* TO 'rangeradmin'@'%';

CREATE DATABASE rangerkms;
USE rangerkms;
CREATE USER 'rangerkms'@'%' IDENTIFIED BY 'rangerkms';
GRANT ALL ON rangerkms.* TO 'rangerkms'@'%';

-- Hue
CREATE DATABASE hue;
USE hue;
CREATE USER 'hue'@'%' IDENTIFIED BY 'hue';
GRANT ALL ON hue.* TO 'hue'@'%';


use ambari;
source Ambari-DDL-MySQL-CREATE.sql;

FLUSH PRIVILEGES; 

###	6. setup ambari at ambari server
ambari-server setup

[root@ambari ~]# ambari-server setup
Using python  /usr/bin/python
Setup ambari-server
Checking SELinux...
SELinux status is 'disabled'
Customize user account for ambari-server daemon [y/n] (n)?
Adjusting ambari-server permissions and ownership...
Checking firewall status...
Checking JDK...
[1] Oracle JDK 1.8 + Java Cryptography Extension (JCE) Policy Files 8
[2] Oracle JDK 1.7 + Java Cryptography Extension (JCE) Policy Files 7
[3] Custom JDK
==============================================================================
Enter choice (1): 3
WARNING: JDK must be installed on all hosts and JAVA_HOME must be valid on all hosts.
WARNING: JCE Policy files are required for configuring Kerberos security. If you plan to use Kerberos,please make sure JCE Unlimited Strength Jurisdiction Policy Files are valid on all hosts.
Path to JAVA_HOME: /usr/java/jdk
Validating JDK on Ambari Server...done.
Completing setup...
Configuring database...
Enter advanced database configuration [y/n] (n)? y
Configuring database...
==============================================================================
Choose one of the following options:
[1] - PostgreSQL (Embedded)
[2] - Oracle
[3] - MySQL / MariaDB
[4] - PostgreSQL
[5] - Microsoft SQL Server (Tech Preview)
[6] - SQL Anywhere
[7] - BDB
==============================================================================
Enter choice (1): 3
Hostname (localhost): hdpca-node1
Port (3306):
Database name (ambari):
Username (ambari):
Enter Database Password (bigdata):
Configuring ambari database...
Copying JDBC drivers to server resources...
Configuring remote database connection properties...
WARNING: Before starting Ambari Server, you must run the following DDL against the database to create the schema: /var/lib/ambari-server/resources/Ambari-DDL-MySQL-CREATE.sql
Proceed with configuring remote database connection properties [y/n] (y)?
Extracting system views...
ambari-admin-2.4.2.0.136.jar
............
Adjusting ambari-server permissions and ownership...
Ambari Server 'setup' completed successfully.

# ambari-server start
[root@ambari ~]# ambari-server start
Using python  /usr/bin/python
Starting ambari-server
Ambari Server running with administrator privileges.
Organizing resource files at /var/lib/ambari-server/resources...
Ambari database consistency check started...
No errors were found.
Ambari database consistency check finished
Server PID at: /var/run/ambari-server/ambari-server.pid
Server out at: /var/log/ambari-server/ambari-server.out
Server log at: /var/log/ambari-server/ambari-server.log
Waiting for server start....................
Ambari Server 'start' completed successfully.

ambari-server status
ambari-server stop

http://192.168.56.10:8080

## Finally
http://docs.hortonworks.com/HDPDocuments/Ambari-2.0.0.0/Ambari_Doc_Suite/ADS_v200.html#reff123c19f-f2b8-429f-bdaf-3535df363080
http://docs.hortonworks.com/HDPDocuments/Ambari-2.0.0.0/Ambari_Doc_Suite/ADS_v200.html#ref-848b09cc-db45-4a2c-b8f7-3617987c53f2


