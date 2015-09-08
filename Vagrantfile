# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.box_check_update = false

  config.vm.network 'private_network', type: 'dhcp'

  config.vm.provider 'virtualbox' do |v|
    v.memory = 8192
    v.cpus = 4
  end

  config.ssh.forward_agent = true

  config.vm.provision 'shell', path: 'provisions/base.sh'
end
