# 添加节点
# 1.修改host 
  和普通的datanode一样。添加namenode的ip 

# 2.修改namenode的配置文件conf/slaves 
echo "192.168.56.12" >> /etc/hadoop/conf/slaves

# 3.在新节点的机器上，启动服务 
./bin/hadoop-daemon.sh start datanode
./bin/hadoop-daemon.sh start tasktracker(hadoop1)
./bin/yarn-daemon.sh start nodemanager(hadoop2)

#4.均衡block 
./bin/start-balancer.sh
# 1）如果不balance，那么cluster会把新的数据都存放在新的node上，这样会降低mapred的工作效率 
# 2）设置平衡阈值，默认是10%，值越低各节点越平衡，但消耗时间也更长 
./bin/start-balancer.sh -threshold 5
# 3）设置balance的带宽，默认只有1M/s
 　　dfs.balance.bandwidthPerSec  
 　　1048576  
 　　  
 　　　　Specifies the maximum amount of bandwidth that each datanode   
 　　　　can utilize for the balancing purpose in term of   
 　　　　the number of bytes per second.   
 　　
# 注意： 
# 1. 必须确保slave的firewall已关闭; 
# 2. 确保新的slave的ip已经添加到master及其他slaves的/etc/hosts中，反之也要将master及其他slave的ip添加到新的slave的/etc/hosts中


# 删除节点
# 1.集群配置 
#   修改conf/hdfs-site.xml文件
   
 　　dfs.hosts.exclude  
 　　/data/soft/hadoop/conf/excludes  
 　　Names a file that contains a list of hosts that are   
 　　not permitted to connect to the namenode.  The full pathname of the   
 　　file must be specified.  If the value is empty, no hosts are   
 　　excluded.
# 2 确定要下架的机器 
dfs.hosts.exclude定义的文件内容为,每个需要下线的机器，一行一个。这个将阻止他们去连接Namenode。如： 
slave-003  
slave-004

# 3.强制重新加载配置 
./bin/hadoop dfsadmin  -refreshNodes
# 它会在后台进行Block块的移动 

# 4.关闭节点 
# 等待刚刚的操作结束后，需要下架的机器就可以安全的关闭了。 
[root@master hadoop]# ./bin/hadoop dfsadmin -report
# 可以查看到现在集群上连接的节点 
# 正在执行Decommission，会显示： 
Decommission Status : Decommission in progress  

# 执行完毕后，会显示： 
Decommission Status : Decommissioned
# 5.再次编辑excludes文件 
#一旦完成了机器下架，它们就可以从excludes文件移除了 
#登录要下架的机器，会发现DataNode进程没有了，但是TaskTracker依然存在，需要手工处理一下