# install vagrant


# vagrantfile
Vagrant.configure("2") do |config|
  config.vm.define :centos do |centos|
    centos.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--name", "centos", "--memory", "512"]
    end
    centos.vm.box = "centos/7"
    centos.vm.hostname = "centos"
    centos.vm.network :private_network, ip: "192.168.56.20"
  end

  config.vm.define :redis do |redis|
    redis.vm.provider "virtualbox" do |v|
          v.customize ["modifyvm", :id, "--name", "redis", "--memory", "512"]
    end
    redis.vm.box = "centos/7"
    redis.vm.hostname = "redis"
    redis.vm.network :private_network, ip: "192.168.33.11"
  end
end


# init 
cd ~/vagrant
vagrant init centos/7

# start
vagrant up


# login to
vagrant ssh centos

# close
vagrant halt

# destory
vagrant destory [name|id]
