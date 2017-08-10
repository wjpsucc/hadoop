# 1) install vertualbox
# Virtualbox issue
# Unable to load R3 module C:\Program Files\VirtualBox/VBoxDD.DLL (VBoxDD): GetLastError=1790 (VERR_UNRESOLVED_ERROR).破解主题
# 2) install centos 7.1
# 3) Additional function for virtualbox
# 4) Java 8 install
# download jdk
tar zxvf jdk -C /usr/java/
ln -s /usr/java/jdkXXX /usr/java/jdk
# jce
mv -i ${JAVA_HOME}/jre/lib/security/local_policy.jar{,.org}
mv -i ${JAVA_HOME}/jre/lib/security/US_export_policy.jar{,.org}
cp local_policy.jar US_export_policy.jar ${JAVA_HOME}/jre/lib/security/

# 5) python pip install
yum -y install epel-release
yum install -y python-pip

# 6) scala 2.10.4
# download the tar file and untar, set environment variable
wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz
tar -zxvf scala-2.10.4.tgz -C /opt/
ln -s /opt/scala-2.10.4 /opt/scala

# 7) maven
wget http://ftp.riken.jp/net/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.zip
unzip apache-maven-3.3.9-bin.zip
mv apache-maven-3.3.9 /opt/maven
ln -s /opt/maven/bin/mvn /usr/bin/mvn
vi /etc/profile.d/maven.sh
--------------------------------------
#!/bin/bash
MAVEN_HOME=/opt/maven
PATH=$MAVEN_HOME/bin:$PATH
export PATH MAVEN_HOME
export CLASSPATH=.
--------------------------------------
chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh
mvn -version
echo $MAVEN_HOME

# 8) git
yum install -y git

# 9) sbt
wget https://dl.bintray.com/sbt/native-packages/sbt/0.13.9/sbt-0.13.9.zip
unzip sbt-0.13.9.zip
mv sbt /opt/sbt

ln -s /opt/sbt/bin/sbt /usr/bin/sbt
vi /etc/profile.d/sbt.sh
--------------------------------------
#!/bin/bash
SBT_HOME=/opt/sbt
PATH=$SBT_HOME/bin:$PATH
export PATH SBT_HOME
export CLASSPATH=.
--------------------------------------
chmod +x /etc/profile.d/sbt.sh
source /etc/profile.d/sbt.sh

# 10) ant
wget http://ftp.meisei-u.ac.jp/mirror/apache/dist//ant/binaries/apache-ant-1.9.6-bin.zip
unzip apache-ant-1.9.6-bin.zip
mv apache-ant-1.9.6 /opt/ant
ln -s /opt/ant/bin/ant /usr/bin/ant

vi /etc/profile.d/ant.sh
--------------------------------------
#!/bin/bash
ANT_HOME=/opt/ant
PATH=$ANT_HOME/bin:$PATH
export PATH ANT_HOME
export CLASSPATH=.
--------------------------------------
chmod +x /etc/profile.d/ant.sh
source /etc/profile.d/ant.sh
ant -version
echo $ANT_HOME

# 11) Tomcat
wget http://ftp.meisei-u.ac.jp/mirror/apache/dist/tomcat/tomcat-8/v8.0.30/bin/apache-tomcat-8.0.30.zip
unzip apache-tomcat-8.0.30.zip
mv apache-tomcat-8.0.30 /opt/tomcat
vi /etc/profile.d/tomcat.sh
--------------------------------------
#!/bin/bash
CATALINA_HOME=/opt/tomcat
PATH=$CATALINA_HOME/bin:$PATH
export PATH CATALINA_HOME
export CLASSPATH=.
--------------------------------------
chmod +x /etc/profile.d/tomcat.sh
source /etc/profile.d/tomcat.sh
chmod +x $CATALINA_HOME/bin/startup.sh
chmod +x $CATALINA_HOME/bin/shutdown.sh
chmod +x $CATALINA_HOME/bin/catalina.sh
cd $CATALINA_HOME/bin
./startup.sh

# 12) http
yum -y install httpd
service httpd start
service httpd status

# 13) /etc/profile
--------------------------------------
export JAVA_HOME=/usr/java/jdk
export CLASSPATH=".:$JAVA_HOME/lib:$JAVA_HOME/jre/lib$CLASSPATH"
export SCALA_HOME=/opt/scala
export PATH=$JAVA_HOME/bin:$SCALA_HOME/bin:$PATH
--------------------------------------



