# allowSnapshot
[hdfs@hdp-1002 ~]$ hdfs dfsadmin -allowSnapshot /user/hdfs/src/src
Allowing snaphot on /user/hdfs/src succeeded

# createSnapsshot
[hdfs@hdp-1002 ~]$ hdfs dfs -createSnapshot /user/hdfs/src s0
Created snapshot /user/hdfs/src/.snapshot/s0

#recovery test
# create f1,f2,f3 three files
[hdfs@hdp-1002 ~]$ hdfs dfs -touchz /user/hdfs/src/tmp/f{1,2,3}
#createSnapshot s1
[hdfs@hdp-1002 ~]$ hdfs dfs -createSnapshot /user/hdfs/src s1
Created snapshot /user/hdfs/src/.snapshot/s1
 
# both HDFS and s1 including f1,f2,f3 files
# HDFS:
[hdfs@hdp-1002 ~]$ hdfs dfs -ls -R /user/hdfs/src/tmp
-rw-r--r--   3 hdfs hadoop          0 2016-01-19 10:59 /user/hdfs/src/tmp/f1
-rw-r--r--   3 hdfs hadoop          0 2016-01-19 10:59 /user/hdfs/src/tmp/f2
-rw-r--r--   3 hdfs hadoop          0 2016-01-19 10:59 /user/hdfs/src/tmp/f3
# Snapshot:
[hdfs@hdp-1002 ~]$ hdfs dfs -ls -R /user/hdfs/src/.snapshot/s1/tmp
-rw-r--r--   3 hdfs hadoop          0 2016-01-19 10:59 /user/hdfs/src/.snapshot/s1/tmp/f1
-rw-r--r--   3 hdfs hadoop          0 2016-01-19 10:59 /user/hdfs/src/.snapshot/s1/tmp/f2
-rw-r--r--   3 hdfs hadoop          0 2016-01-19 10:59 /user/hdfs/src/.snapshot/s1/tmp/f3
 
# delete f3
[hdfs@hdp-1002 ~]$ hdfs dfs -rm /user/hdfs/src/tmp/f3
16/01/19 11:02:11 INFO fs.TrashPolicyDefault: Namenode trash configuration: Deletion interval = 60 minutes, Emptier interval = 60 minutes.
Moved: 'hdfs://nameservice1/user/hdfs/src/tmp/f3' to trash at: hdfs://nameservice1/user/hdfs/src/.Trash/Current
 
# f3 in HDFS is deleted, But in s1 is still there
# HDFS:
[hdfs@hdp-1002 ~]$ hdfs dfs -ls -R /user/hdfs/src/
drwxr-xr-x   - hdfs           hadoop          0 2016-01-19 11:02 /user/hdfs/src/tmp
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/tmp/f1
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/tmp/f2
 
# snapshot:
[hdfs@hdp-1002 ~]$ hdfs dfs -ls -R /user/hdfs/src/.snapshot
drwxr-xr-x   - hdfs           hadoop          0 2016-01-19 09:54 /user/hdfs/src/.snapshot/s0/tmp
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 09:51 /user/hdfs/src/.snapshot/s0/tmp/f1
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 09:51 /user/hdfs/src/.snapshot/s0/tmp/f2
drwxr-xr-x   - hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/.snapshot/s1/tmp
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/.snapshot/s1/tmp/f1
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/.snapshot/s1/tmp/f2
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/.snapshot/s1/tmp/f3
 
# recovery
[hdfs@hdp-1002 ~]$ hdfs dfs -cp /user/hdfs/src/.snapshot/s1/tmp/f3 /user/hdfs/src/tmp/f3
[hdfs@hdp-1002 ~]$ hdfs dfs -ls -R /user/hdfs/src
drwxr-xr-x   - hdfs           hadoop          0 2016-01-19 11:06 /user/hdfs/src/tmp
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/tmp/f1
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 10:59 /user/hdfs/src/tmp/f2
-rw-r--r--   3 hdfs           hadoop          0 2016-01-19 11:06 /user/hdfs/src/tmp/f3
 
# RO snapshot cannot be modified
[hdfs@hdp-1002 ~]$ hdfs dfs -touchz /user/hdfs/src/.snapshot/s1/f4
touchz: Modification on a read-only snapshot is disallowed
Change snapshot name
[hdfs@hdp-1002 ~]$ hdfs dfs -renameSnapshot /user/hdfs/src s0 s_init
[hdfs@hdp-1002 ~]$ hdfs dfs -ls /user/hdfs/src/.snapshot/
Found 2 items
drwxr-xr-x   - hdfs hadoop          0 2016-01-19 11:00 /user/hdfs/src/.snapshot/s1
drwxr-xr-x   - hdfs hadoop          0 2016-01-19 10:53 /user/hdfs/src/.snapshot/s_init
list snapshottable dir
[hdfs@hdp-1002 ~]$ hdfs lsSnapshottableDir
drwxr-xr-x 0 hdfs hadoop 0 2016-01-19 11:06 2 65536 /user/hdfs/src
diff the snapshot
[hdfs@hdp-1002 ~]$ hdfs snapshotDiff /user/hdfs/src s_init s1
Difference between snapshot s_init and snapshot s1 under directory /user/hdfs/src:
M       ./tmp
+       ./tmp/f1
+       ./tmp/f2
+       ./tmp/f3
-       ./tmp/f1
-       ./tmp/f2

# delete sanpshot
[hdfs@hdp-1002 ~]$ hdfs dfs -deleteSnapshot  /user/hdfs/src s_init
[hdfs@hdp-1002 ~]$ hdfs dfs -ls /user/hdfs/src/.snapshot/
Found 1 items
drwxr-xr-x   - hdfs hadoop          0 2016-01-19 11:00 /user/hdfs/src/.snapshot/s1

# close snapshot
[hdfs@hdp-1002 ~]$ hdfs dfsadmin -disallowSnapshot /user/hdfs/src
disallowSnapshot: The directory /user/hdfs/src has snapshot(s). Please redo the operation after removing all the snapshots.
 
# cannot close when you have snapshot
[hdfs@hdp-1002 ~]$ hdfs dfs -deleteSnapshot /user/hdfs/src s1
[hdfs@hdp-1002 ~]$ hdfs dfsadmin -disallowSnapshot /user/hdfs/src
Disallowing snaphot on /user/hdfs/src succeeded