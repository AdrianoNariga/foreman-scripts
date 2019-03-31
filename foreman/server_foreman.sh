#!/bin/bash
source $1
ip_foreman="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"
hostnamectl set-hostname $foreman_hostname
grep $foreman_hostname /etc/hosts || echo "$ip_foreman $foreman_hostname" >> /etc/hosts
source shell-functions/installer-repo.sh

foreman-installer \
	--foreman-organizations-enabled=false \
	--foreman-locations-enabled=false \
	--enable-foreman-compute-libvirt \
	--foreman-proxy-tftp=false \
	--foreman-proxy-puppet=false \
	--enable-foreman-plugin-remote-execution

get_so -s | grep CentOS && {
        systemctl stop firewalld
        systemctl disable firewalld
}

hammer os create --name Debian --architectures x86_64 \
	    --family Debian --major 9 --minor 3 --release-name stretch --description "Debian 9.3.0"

hammer os create --name CoreOS --architectures x86_64 \
	    --family Coreos --major 1437 --minor 2.0 --description "CoreOS Beta 1437"

hammer template list | grep -q centos_finish ||
  hammer template create --file Template_Scripts/centos_finish --type finish --name centos_finish

hammer template list | grep -q debian9_finish ||
  hammer template create --file Template_Scripts/debian9_finish --type finish --name debian9_finish

hammer template list | grep -q coreos_finish ||
  hammer template create --file Template_Scripts/coreos_finish --type finish --name coreos_finish

hammer template list | grep -q "remote_ssh" ||
  hammer template create --file Template_Scripts/remote_ssh.erb --type snippet --name remote_ssh

test -f /usr/share/foreman/.ssh/id_rsa.pub || ssh-keygen -t rsa -f /usr/share/foreman/.ssh/id_rsa -q -P \"\"
cat > /usr/share/foreman/.ssh/config << EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
chown -R foreman. /usr/share/foreman/.ssh
chmod 0700 /usr/share/foreman/.ssh
chmod 0600 /usr/share/foreman/.ssh/config

hammer compute-resource list | grep -q $libvirt_host ||
  hammer compute-resource create --provider Libvirt --name $libvirt_host --url qemu+ssh://$libvirt_user@$libvirt_host/system
