#!/bin/bash
source HOSTS
ip_foreman="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"

hostnamectl set-hostname $foreman_hostname

grep $foreman_hostname /etc/hosts || echo "$ip_foreman $foreman_hostname" >> /etc/hosts
yum -y install https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install https://yum.theforeman.org/releases/1.15/el7/x86_64/foreman-release.rpm
yum -y install foreman-installer

foreman-installer --enable-foreman-compute-libvirt --foreman-proxy-tftp=false --foreman-proxy-puppet=false

systemctl stop firewalld
systemctl disable firewalld

hammer template list | grep centos_finish ||
  hammer template create --file Template_Scripts/centos_finish --type finish --name centos_finish

su -c "ls /usr/share/foreman/.ssh/id_rsa.pub || ssh-keygen -t rsa -f /usr/share/foreman/.ssh/id_rsa -q -P \"\"" -s /bin/bash foreman

#hammer compute-resource list | grep lenovo.libvirtd ||
#  hammer compute-resource create --provider Libvirt --name lenovo.libvirtd --url qemu+ssh://root@192.168.111.252/system
