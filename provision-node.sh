#!/bin/bash

mkdir -p /var/lib/docker
sudo mkfs.ext4 /dev/sdc
echo '/dev/sdc /var/lib/docker ext4 defaults 0 2' >> /etc/fstab
mount /dev/sdc /var/lib/docker

sudo apt-get install -y \
  avahi-daemon libnss-mdns \

cat /vagrant/master.id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

