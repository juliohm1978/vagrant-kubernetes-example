#!/bin/bash

cd /opt
wget 'https://github.com/kubernetes-incubator/kubespray/archive/v2.4.0.tar.gz' -O k.tgz

tar -xzf k.tgz
rm k.tgz
mv kubespray-* kubespray

rm -fr /opt/kubespray/inventory/*
cp -vr /vagrant/kubespray/* /opt/kubespray/inventory/
cd /opt/kubespray

ansible-playbook cluster.yml -b -i inventory/hosts.ini
