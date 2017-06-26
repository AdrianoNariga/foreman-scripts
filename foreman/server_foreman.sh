#!/bin/bash
source HOSTS
ip_foreman="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"

hostnamectl set-hostname $foreman_hostname

grep $foreman_hostname /etc/hosts || echo "$ip_foreman $foreman_hostname" >> /etc/hosts

source shell-functions/installer-repo.sh

foreman-installer \
	--enable-foreman-compute-libvirt \
	--foreman-proxy-tftp=false \
	--foreman-proxy-puppet=false \
	--enable-foreman-plugin-remote-execution

systemctl stop firewalld
systemctl disable firewalld

hammer os create --name Debian --architectures x86_64 \
	    --family Debian --major 9 --minor 0 --release-name stretch --description "Debian 9.0.0"

hammer os create --name CoreOS --architectures x86_64 \
	    --family CoreOS --major 1437 --minor 2.0 --description "CoreOS Beta 1437"

hammer template list | grep centos_finish ||
  hammer template create --file Template_Scripts/centos_finish --type finish --name centos_finish

hammer template list | grep debian9_finish ||
  hammer template create --file Template_Scripts/debian9_finish --type finish --name debian9_finish

hammer template list | grep coreos_finish ||
  hammer template create --file Template_Scripts/coreos_finish --type finish --name coreos_finish

su -c "ls /usr/share/foreman/.ssh/id_rsa.pub || ssh-keygen -t rsa -f /usr/share/foreman/.ssh/id_rsa -q -P \"\"" -s /bin/bash foreman
su -c "ssh-copy-id $libvirt_user@$libvirt_host" -s /bin/bash foreman

hammer compute-resource list | grep $libvirt_host ||
  hammer compute-resource create --provider Libvirt --name $libvirt_host --url qemu+ssh://$libvirt_user@$libvirt_host/system
