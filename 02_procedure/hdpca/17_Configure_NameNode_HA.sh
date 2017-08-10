# Need
# Namenode, Journalnode, Zookeeper

https://docs.hortonworks.com/HDPDocuments/Ambari-2.1.2.1/bk_Ambari_Users_Guide/content/_how_to_configure_namenode_high_availability.html


# How To Configure NameNode High Availability
# 1. Check to make sure you have at least three hosts in your cluster and are running at least three ZooKeeper servers.
# 1. Check to make sure that the HDFS and ZooKeeper services are not in Maintenance Mode.
     These services will be stopped and started when enabling NameNode HA. Maintenance Mode will prevent those start and stop operations from occurring. If the HDFS or ZooKeeper services are in Maintenance Mode the NameNode HA wizard will not complete successfully.
# 1. In Ambari Web, select Services > HDFS > Summary.
# 1. Select Service Actions and choose Enable NameNode HA.
# 1. The Enable HA Wizard launches. This wizard describes the set of automated and manual steps you must take to set up NameNode high availability.
# 1. Get Started : This step gives you an overview of the process and allows you to select a Nameservice ID. You use this Nameservice ID instead of the NameNode FQDN once HA has been set up. Click Next to proceed.

# 1. Select Hosts : Select a host for the additional NameNode and the JournalNodes. The wizard suggest options that you can adjust using the drop-down lists. Click Next to proceed.

# 1. Review : Confirm your host selections and click Next.

# 1. Create Checkpoints : Follow the instructions in the step. You need to log in to your current NameNode host to run the commands to put your NameNode into safe mode and create a checkpoint. When Ambari detects success, the message on the bottom of the window changes. Click Next.

# 1. Configure Components : The wizard configures your components, displaying progress bars to let you track the steps. Click Next to continue.

# 1. Initialize JournalNodes : Follow the instructions in the step. You need to login to your current NameNode host to run the command to initialize the JournalNodes. When Ambari detects success, the message on the bottom of the window changes. Click Next.

# 1. Start Components : The wizard starts the ZooKeeper servers and the NameNode, displaying progress bars to let you track the steps. Click Next to continue.

# 1. Initialize Metadata : Follow the instructions in the step. For this step you must log in to both the current NameNode and the additional NameNode. Make sure you are logged in to the correct host for each command. Click Next when you have completed the two commands. A Confirmation pop-up window displays, reminding you to do both steps. Click OK to confirm.

# 1. Finalize HA Setup : The wizard the setup, displaying progress bars to let you track the steps. Click Done to finish the wizard. After the Ambari Web GUI reloads, you may see some alert notifications. Wait a few minutes until the services come back up. If necessary, restart any components using Ambari Web.

# 1. If you are using Hive, you must manually change the Hive Metastore FS root to point to the Nameservice URI instead of the NameNode URI. You created the Nameservice ID in the Get Started step.
Check the current FS root. On the Hive host:
hive --config /etc/hive/conf.server --service metatool -listFSRoot
The output looks similar to the following: Listing FS Roots... hdfs://<namenode-host>/apps/hive/warehouse
Use this command to change the FS root:
$ hive --config /etc/hive/conf.server --service metatool -updateLocation <new-location><old-location>
For example, where the Nameservice ID is mycluster:
$ hive --config /etc/hive/conf.server --service metatool -updateLocation hdfs://mycluster/apps/hive/warehouse hdfs://c6401.ambari.apache.org/apps/hive/warehouse
The output looks similar to the following:
Successfully updated the following locations...Updated X records in SDS table
# 1. Adjust the ZooKeeper Failover Controller retries setting for your environment.
Browse to Services > HDFS > Configs >Advanced core-site.
Set ha.failover-controller.active-standby-elector.zk.op.retries=120