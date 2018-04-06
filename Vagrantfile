Vagrant.configure("2") do |config|

  masterdisk = 'master/dockerdata.vdi'
  node01disk = 'node01/dockerdata.vdi'

  config.vm.define "node01" do |node|
    node.vm.box = "ubuntu/xenial64"
    node.vm.hostname = "node01"
    node.vm.network "private_network", ip: "192.168.99.201"
    node.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "2048"
      vb.cpus = 1
      if not File.exists?(node01disk)
        vb.customize ['createmedium',  'disk', '--filename', node01disk, '--size', '40960', '--variant', 'Standard']
        vb.customize ['storageattach', :id,  '--storagectl', 'SCSI', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', node01disk]
      end
    end
    node.vm.provision "shell", path: "provision-node.sh"
  end

  config.vm.define "master" do |master|
    master.vm.box = "ubuntu/xenial64"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.99.200"
    master.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "2048"
      vb.cpus = 1
      if not File.exists?(masterdisk)
        vb.customize ['createmedium',  'disk', '--filename', masterdisk, '--size', '40960', '--variant', 'Standard']
        vb.customize ['storageattach', :id,  '--storagectl', 'SCSI', '--port', 2, '--device', 0, '--type', 'hdd', '--medium', masterdisk]
      end
    end
    master.vm.provision "shell", path: "provision-master.sh"
    master.vm.provision "shell", path: "provision-kubespray.sh"
  end

end
