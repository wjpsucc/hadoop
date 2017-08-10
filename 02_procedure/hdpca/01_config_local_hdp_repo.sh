# 01 Configure a local HDP repository

## Author:** Linou.Zhang
## Create Time:** 2017/7/31


## Menu
#	1. httpd service installation
#	2. download tarballs
#	3. untar tarballs to http directory
#	4. prepare local repository for ambari

## Body

###	1. httpd service installation
yum install -y httpd
#service httpd start
#service httpd status
systemctl start httpd.service
systemctl status httpd.service


###	2. download tarballs
wget http://s3.amazonaws.com/public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.5.3.0/HDP-2.5.3.0-centos7-rpm.tar.gz
wget http://s3.amazonaws.com/public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz
wget http://s3.amazonaws.com/public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.2.0/ambari-2.4.2.0-centos7.tar.gz

###	3. untar tarballs to http directory
tar -zxvf HDP-UTILS-1.1.0.21-centos7.tar.gz -C /var/www/html/
tar -zxvf HDP-2.4-latest-centos7-rpm.tar.gz -C /var/www/html/
tar -zxvf AMBARI-2.4.1.0-22-centos7.tar.gz -C /var/www/html/

###	4. prepare local repository for ambari
vim /etc/yum.repos.d/ambari.repo
[Updates-ambari-2.5.1.0]
name=ambari-2.5.1.0-Updates
baseurl=http://192.168.56.10/hdp/ambari/centos7/
gpgcheck=1
gpgkey=http://public-repo-1.hortonworks.com/ambari/centos7/RPM-GPG-KEY/RPM-GPG-KEY-Jenkins
enabled=1
priority=1

### Test repo
yum clean all
yum makecache
yum search ambari

## Finally
http://docs.hortonworks.com/HDPDocuments/Ambari-2.1.0.0/bk_Installing_HDP_AMB/content/_using_a_local_repository.html