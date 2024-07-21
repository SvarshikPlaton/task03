# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "oracle-linux-1" do |oracle|
    oracle.vm.box = "generic/oracle9"
    oracle.vm.hostname = "oracle-linux"
    oracle.vm.network "private_network", ip: "192.168.56.102"
    oracle.vm.network "forwarded_port", guest: 3300, host: 3300

    oracle.vm.provision "shell", path: "install_db.sh"
    oracle.vm.provision "shell", path: "encryption_at_rest.sh"
    oracle.vm.provision "shell", path: "encryption_in_transit.sh"
    oracle.vm.provision "shell", path: "set_config.sh"
  end

end