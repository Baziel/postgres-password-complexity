# Vagrantfile to create a machine for  webserver server1
# machine server1
#
# bdl 20230217 v0.01
#

$default_network_interface = `ip route | awk '/^default/ {printf "%s", $5; exit 0}'`
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure("2") do |config|

  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end

  required_plugins = %w( vagrant-disksize )
  _retry = false
  required_plugins.each do |plugin|
      unless Vagrant.has_plugin? plugin
          system "vagrant plugin install #{plugin}"
          _retry=true
      end
  end

  if (_retry)
      exec "vagrant " + ARGV.join(' ')
  end

  config.vm.box = "rockylinux/10"
  config.vm.box_check_update = false
  
  #config.vm.provision "file", source: "./barman.conf", destination: "/tmp/barman.conf"
  #config.vm.provision "file", source: "./backup_barman", destination: "/tmp/backup_barman"
  #config.vm.provision "file", source: "./server6-postgres17.conf", destination: "/tmp/server6-postgres17.conf"
  #config.vm.provision "file", source: "./logrotate_barman", destination: "/tmp/logrotate_barman"

  config.vm.provision "file", source: "./systemctloverride", destination: "/tmp/systemctloverride"
  config.vm.provision "file", source: "./pg_hba.conf", destination: "/tmp/pg_hba.conf"

  config.vm.provision "file", source: "./postgres.sh", destination: "/tmp/postgres.sh"
  #config.vm.provision "file", source: "./postgres1.sh", destination: "/tmp/postgres1.sh"
  config.vm.provision "file", source: "./postgres2.sh", destination: "/tmp/postgres2.sh"

  config.vm.provision "file", source: "./postgresql.conf", destination: "/tmp/postgresql.conf"
  config.vm.provision "file", source: "./postgresql1.conf", destination: "/tmp/postgresql1.conf"
  config.vm.provision "file", source: "./postgresql2.conf", destination: "/tmp/postgresql2.conf"
  config.vm.provision "file", source: "./postgresql4.conf", destination: "/tmp/postgresql4.conf"

  config.vm.provision "file", source: "./testscript.sql", destination: "/tmp/testscript.sql"
  config.vm.provision "file", source: "./testscript1.sql", destination: "/tmp/testscript1.sql"
  config.vm.provision "file", source: "./testscript2.sql", destination: "/tmp/testscript2.sql"
  config.vm.provision "file", source: "./testscript3.sql", destination: "/tmp/testscript3.sql"
  config.vm.provision "file", source: "./testscript4.sql", destination: "/tmp/testscript4.sql"
  config.vm.provision "file", source: "./testscript4a.sql", destination: "/tmp/testscript4a.sql"
  config.vm.provision "file", source: "./testscript4.sh", destination: "/tmp/testscript4.sh"
  config.vm.provision "file", source: "./testscript5.sql", destination: "/tmp/testscript5.sql"
  config.vm.provision "file", source: "./testscript5.sh", destination: "/tmp/testscript5.sh"
  config.vm.provision "file", source: "./testscript6.sql", destination: "/tmp/testscript6.sql"
  config.vm.provision "file", source: "./testscript6.sh", destination: "/tmp/testscript6.sh"

  config.vm.provision "file", source: "./pci01_before.sql", destination: "/tmp/pci01_before.sql"
  config.vm.provision "file", source: "./pci01_behind.sql", destination: "/tmp/pci01_behind.sql"
  config.vm.provision "file", source: "./pci02_before.sql", destination: "/tmp/pci02_before.sql"
  config.vm.provision "file", source: "./pci02_behind.sql", destination: "/tmp/pci02_behind.sql"
  config.vm.provision "file", source: "./pci03_before.sql", destination: "/tmp/pci03_before.sql"
  config.vm.provision "file", source: "./pci03_behind.sql", destination: "/tmp/pci03_behind.sql"
  config.vm.provision "file", source: "./pci04_before.sql", destination: "/tmp/pci04_before.sql"
  config.vm.provision "file", source: "./pci04_behind.sql", destination: "/tmp/pci04_behind.sql"
  config.vm.provision "file", source: "./pci05_before.sql", destination: "/tmp/pci05_before.sql"
  config.vm.provision "file", source: "./pci05_behind.sql", destination: "/tmp/pci05_behind.sql"
  config.vm.provision "file", source: "./pci06_before.sql", destination: "/tmp/pci06_before.sql"
  config.vm.provision "file", source: "./pci06_behind.sql", destination: "/tmp/pci06_behind.sql"

  config.vm.provision "file", source: "./pci_password_check_rules_0.1.sql", destination: "/tmp/pci_password_check_rules_0.1.sql"
  config.vm.provision "file", source: "./pci_password_check_rules_0.2_up_0.1-0.2.sql", destination: "/tmp/pci_password_check_rules_0.2_up_0.1-0.2.sql"
  config.vm.provision "file", source: "./pci_password_check_rules_0.3_up_0.2-0.3.sql", destination: "/tmp/pci_password_check_rules_0.3_up_0.2-0.3.sql"
  config.vm.provision "file", source: "./pci_password_check_rules_0.4_up_0.3-0.4.sql", destination: "/tmp/pci_password_check_rules_0.4_up_0.3-0.4.sql"
  config.vm.provision "file", source: "./pci_password_check_rules_0.5_up_0.4-0.5.sql", destination: "/tmp/pci_password_check_rules_0.5_up_0.4-0.5.sql"
  config.vm.provision "file", source: "./pci_password_check_rules_0.6_up_0.5-0.6.sql", destination: "/tmp/pci_password_check_rules_0.6_up_0.5-0.6.sql"

  config.vm.provision :"shell", :privileged => true, :path => "provisioning.sh"

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.ssh.insert_key = false


  config.vm.provider "virtualbox" do |v|
    v.name = "server8"
    v.customize ["modifyvm", :id, "--chipset", "ich9"]
    v.cpus = 2
	v.memory = 4096
  end

  config.vm.hostname = "server8.baziel.com"
    # Specify the interface when creating the public network
    config.vm.network "public_network", bridge: "enp1s0", ip: "192.168.1.28", netmask: "255.255.0.0"
  # config.vm.network "public_network", use_dhcp_assigned_default_route:true
  #config.vm.network "public_network", bridge: "enp1s0", ip: "192.168.1.21", netmask: "255.255.0.0"


end

