# docker install ################################################
sudo yum remove docker \
  docker-common \
  docker-selinux \
  docker-engine

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum makecache fast

sudo yum install docker-ce -y

 # list docker repo
yum list docker-ce.x86_64  --showduplicates | sort -r

sudo systemctl start docker


# deploy docker registry################################################
docker pull registry

mkdir -p /opt/data/registry
docker run -d -p 5000:5000 -v /opt/data/registry:/tmp/registry registry
docker ps
docker exec -it  796(container_id)  /bin/bash

# test
docker pull busybox
docker tag busybox 192.168.56.20:5000/busybox
docker push 192.168.56.20:5000/busybox

# check registry
curl 192.168.56.20:5000/v2/_catalog


# issue:
cat /etc/sysconfig/docker
ADD_REGISTRY='--add-registry 192.168.56.20:5000'
INSECURE_REGISTRY='--insecure-registry 192.168.56.20:5000'

cat /etc/docker/daemon.json
{ "insecure-registries":["192.168.56.20:5000"] }


# docker私有仓库管理系统harbor的部署使用 ################################################

# 一、harbor管理界面的部署安装
# 1) download
wget https://github.com/vmware/harbor/releases/download/v1.1.2/harbor-offline-installer-v1.1.2.tgz


# 2) 安装docker和docker-compose
yum -y install epel-release
yum install -y python-pip
pip install docker-compose

# 3) 解压缩下载好的harbor文件，cd harbor，修改docker-compose.yml和harbor.cfg两个文件

docker-compose.yml
port:
   -5000:5000

harbor.cfg


# 4) update
./prepare

# 5) install
./install.sh

docker-compose ps
docker-compose up -d               ###后台启动，如果容器不存在根据镜像自动创建
docker-compose down   -v         ###停止容器并删除容器
docker-compose start                 ###启动容器，容器不存在就无法启动，不会自动创建镜像
docker-compose stop                 ###停止容器

# 6) login
http://192.168.56.20


# docker file

# docker image

# 