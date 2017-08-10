# Install HDP using the Ambari install wizard

# **Author:** Linou.Zhang
# **Create Time:** 2017/7/31


### 0. Start ambari-agent on all nodes before deploy
ambari-agent  start

###	1. Log In to Apache Ambari
```
url: http://192.168.56.10:8080
username/passwd: admin/admin
```	
###	2. Launching the Ambari Install Wizard
# From the Ambari Welcome page, choose Launch Install Wizard.

###	3. Name Your Cluster
# Input a name for the cluster you want to create
# Next


###	4. Select Version
# select the software version and method of delivery for your cluster
# 4.1 Choosing Stack
# 4.2 Choosing Version
# 4.3 Choosing Repositories
```
http://192.168.56.10/hdp/HDP/centos7/
http://192.168.56.10/hdp/HDP-UTILS-1.1.0.21-centos7/
```
# 4.4 Advanced Options

###	5. Install Options
# Use the Target Hosts text box to enter your list of host names

###	6. Confirm Hosts
 correct hosts for your cluster 
 check those hosts to make sure they have the correct directories, packages, and processes required to continue the install.

###	7. Choose Services
run the following command on ambari server:
```
ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar
```

###	8. Assign Masters

###	9. Assign Slaves and Clients

###	10. Customize Services

###	11. Review

###	12. Install, Start and Test

###	13. Complete

## Finally
http://docs.hortonworks.com/HDPDocuments/Ambari-2.1.0.0/bk_Installing_HDP_AMB/content/ch_Deploy_and_Configure_a_HDP_Cluster.html

