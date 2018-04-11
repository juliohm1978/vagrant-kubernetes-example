# Vagrant Kubernetes Example

This project presents a simple example of how Vagrant can be used to launch a small Kubernetes cluster. While `minikube` and `kubeadm` are great, even faster alternatives, this project should also give beginners the first steps on how to setup a Kubernetes cluster on bare metal.

Provisoned VMs are based on `ubuntu/xenial64` boxes and Kubernetes is installed with the help of [Ansible 2.5](https://www.ansible.com/) and [Kubespray 2.4.0](https://github.com/kubernetes-incubator/kubespray).

> **IMPORTANT NOTE:** This is intended for testing purposes and should not be taken, as is, to production environments or any other with a security sensitive context. It is merely intended to be a starting point for people who wish to experience a Kubernetes installation process that more closely resembles a real environment.

## Launching a new cluster

You will need [Vagrant](https://www.vagrantup.com/docs/installation/) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed locally to launch the virtual machines.

To provision the cluster:

```bash
git clone https://github.com/juliohm1978/vagrant-kubernetes-example.git
cd vagrant-kubernetes-example
vagrant up
```

This will likely take several minutes to complete, so be patient. Initial provisioning includes:

* Creating two virtual machines (master and node)
* Adding additional disks to VMs to serve as storage for `/var/lib/docker` (40GB VID disks)
* Installing dependencies (ansible, wget, pythong, etc.)
* Downloadin Kubespray
* Configuring SSH keys for Kubespray
* Launching Kubespray installation

Once the cluster is up and running you can access the master node and start playing with Kubernetes.

```bash
vagrant ssh master

vagrant@master:~$
vagrant@master:~$ sudo su -

root@master:~#
root@master:~# kubectl get nodes

NAME      STATUS    ROLES     AGE       VERSION
master    Ready     master    2m        v1.10.0+coreos.0
node01    Ready     node      2m        v1.10.0+coreos.0
```

## Customizing

The `Vagrantfile` file is quite standard. You can easily modify that to give VMs more resources (CPU, memory, etc). The included version provisions:

* 1 Master node with 1 CPU and 2GB RAM
* 1 Worker node with 1 CPU and 2GB RAM

Both will have an extra 40GB disk used as a dedicated partition mounted at `/var/lib/docker`. After provisioning, you will find those disks at:

* `master/dockerdata.vdi`
* `node01/dockerdata.vdi`

Disks are created with `Standard` variant, so they will begin small and grow as Docker pulls various images used in the cluster.

### Making a single node cluster

You can easily convert this setup into a single node cluster by making a few changes.

Modify `kubespray/hosts.ini`:

* Remove `node01` from the inventory.
* Remove `node01` from the `[kube-node]` group.
* Include `master` in the `[kube-node]` group.

Modify `Vagrantfile` and comment or remove the `config.vm.define` block that provisions `node01`.

```Vagrantfile
## remove this block
# config.vm.define "node01" do |node|
#   ...
# end
```

For a single node cluster, Kubespray will open the master node to receive pods and deployments.

## Cleanup

To remove all VMs and restart from scratch, the standard vagrant destroy should be enough.

```bash
vagrant destroy -f
```

Destrying the cluster will also remove `*/dockerdata.vdi` disks cerated during provisioning.
