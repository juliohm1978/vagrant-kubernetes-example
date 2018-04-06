#!/bin/bash

mkdir -p /var/lib/docker
sudo mkfs.ext4 /dev/sdc
echo '/dev/sdc /var/lib/docker ext4 defaults 0 2' >> /etc/fstab
mount /dev/sdc /var/lib/docker

apt-get install -y \
  software-properties-common \
  avahi-daemon libnss-mdns \
  nfs-common cifs-utils \
  python-netaddr \
  wget \

apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y ansible

cp -vr /vagrant/master.id_rsa /root/.ssh/id_rsa
cp -vr /vagrant/master.id_rsa.pub /root/.ssh/id_rsa.pub
cp -vr /vagrant/master.id_rsa /home/vagrant/.ssh/id_rsa
cp -vr /vagrant/master.id_rsa.pub /home/vagrant/.ssh/id_rsa.pub
chown -R vagrant.vagrant /home/vagrant/.ssh
cat /vagrant/master.id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

