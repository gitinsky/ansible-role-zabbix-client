# -*- mode: ruby -*-
# vi: set ft=ruby :

# defaultbox = "precise64"
defaultbox = "ubuntu/trusty64"
box = ENV['BOX'] || defaultbox
ENV['ANSIBLE_ROLES_PATH'] = "../../roles"

Vagrant.configure(2) do |config|

  config.vm.box = box
  if box == defaultbox
  end
  
  config.vm.define "zabbix_client14" do |zabbix_client_cfg|
    # zabbix_client_cfg.vm.network :forwarded_port, host: 8014, guest: 80
    zabbix_client_cfg.vm.provider :virtualbox do |v|
      v.name = "zabbix_client-14.04"
      # v.memory = 2048
      # v.gui = true
    end
  end
  
  config.vm.define "zabbix_client12" do |zabbix_client12_cfg|
    zabbix_client12_cfg.vm.box='ubuntu/precise64'
    # zabbix_client12_cfg.vm.network :forwarded_port, host: 8012, guest: 80
    zabbix_client12_cfg.vm.provider :virtualbox do |v|
      v.name = "zabbix_client-12.04"
      # v.memory = 2048
      # v.gui = true
    end
  end
  
  config.vm.provision :ansible do |ansible|
    ansible.playbook = "examples/zabbix-client.yml"
    # ansible.verbose = "vvv"
    ansible.sudo = true
    # ansible.tags = ['debug']
    ansible.groups = {
      "zabbix-client" => ["zabbix_client14"],
    }
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "examples/zabbix-client.yml"
    # ansible.verbose = "vvv"
    ansible.sudo = true
    # ansible.tags = ['debug']
    ansible.groups = {
      "zabbix-client" => ["zabbix_client12"],
    }
  end
  
end
