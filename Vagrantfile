Vagrant.configure("2") do |config|

  config.vagrant.plugins = "vagrant-vbguest"
  config.vm.provision "shell", inline: "sudo yum update -y"
  config.vm.provision "shell", inline: "sudo yum localinstall -y https://yum.puppet.com/puppet6-release-el-7.noarch.rpm"
  config.vm.provision "shell", inline: "sudo yum install -y puppet-agent"

  config.vm.define "proxy" do |server|
    server.vm.box = "centos/7"
    server.vm.hostname = 'proxy'
    server.vm.network :private_network, ip: "192.168.150.101"
    server.vm.network :private_network, ip: "10.10.10.1"
    server.vm.network :private_network, ip: "20.20.20.1"
    server.vm.provider :virtualbox do |v|
       v.customize ["modifyvm", :id, "--memory", 1024]
    end
  end

  config.vm.define "client1" do |server|
    server.vm.box = "centos/7"
    server.vm.hostname = 'client1'
    server.vm.network :private_network, ip: "10.10.10.10"
    server.vm.provider :virtualbox do |v|
         v.customize ["modifyvm", :id, "--memory", 512]
    end
  end
  
  config.vm.define "client2" do |server|
    server.vm.box = "centos/7"
    server.vm.hostname = 'client2'
    server.vm.network :private_network, ip: "20.20.20.20"
    server.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", 512]
    end
  end

  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "site.pp"
    puppet.options = "--verbose"
  end
end
