# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu-12.04"

    config.vm.network :private_network, ip: "33.33.33.30"

    # config.vm.network :forwarded_port, guest: 80, host: 8000

    config.vm.synced_folder ".", "/home/vagrant/vagrant-magento", :nfs => true

    config.vm.provision :puppet do |puppet|
        # puppet.options = "-vd"
        puppet.options = "-v"
        puppet.manifests_path = "puppet"
        puppet.manifest_file  = "base.pp"
        puppet.module_path = "puppet/modules"
    end

    config.vm.provider "virtualbox" do |my_vm|
        my_vm.customize ["modifyvm", :id, "--memory", "2048"]
    end
end
