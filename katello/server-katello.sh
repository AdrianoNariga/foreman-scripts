#!/bin/bash
source $1

hostnamectl set-hostname $foreman_hostname

yum -y localinstall http://fedorapeople.org/groups/katello/releases/yum/3.6/katello/el7/x86_64/katello-repos-latest.rpm
yum -y localinstall http://yum.theforeman.org/releases/1.17/el7/x86_64/foreman-release.rpm
yum -y localinstall https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y localinstall http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install foreman-release-scl python-djangoyum
yum -y install katello yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce

foreman-installer --scenario katello \
	--enable-foreman-compute-libvirt \
	--enable-foreman-compute-openstack \
	--enable-foreman-compute-vmware \
	--enable-foreman-plugin-ansible \
	--enable-foreman-proxy-plugin-ansible \
	--foreman-proxy-dhcp=true \
	--foreman-proxy-dhcp-interface=$dhcp_iface \
	--foreman-proxy-dhcp-gateway=$gateway \
	--foreman-proxy-dhcp-range="$range" \
	--foreman-proxy-dhcp-nameservers="$dns" \
	--foreman-proxy-dhcp-pxeserver="$ip_tftp" \
	--foreman-proxy-tftp=true \
	--foreman-proxy-tftp-servername=$ip_tftp \
	--foreman-proxy-dns=true \
	--foreman-proxy-dns-interface=$dns_iface \
	--foreman-proxy-dns-zone=$zona_name \
	--foreman-proxy-dns-reverse=$reverse.in-addr.arpa \
	--foreman-proxy-dns-forwarders=$dns_forward \
	--foreman-proxy-dns-forwarders=8.8.4.4

systemctl stop firewalld
systemctl disable firewalld

hammer organization create --name home
hammer location create --name stc
hammer location add-domain --domain home.stc --name stc
hammer organization add-domain --domain home.stc --name home
hammer organization add-location --location stc --name home
hammer organization add-smart-proxy --smart-proxy $HOSTNAME --name home
hammer location add-smart-proxy --smart-proxy $HOSTNAME --name stc
hammer user create \
	--auth-source-id 1 \
	--admin true \
	--locations stc \
	--default-location stc \
	--organizations home \
	--default-organization home \
	--firstname Nariga \
	--lastname Adriano \
	--mail nariga@home.stc \
	--login nariga \
	--password 'VuDa22)$cld'

hammer compute-resource create --provider Libvirt \
	--name vostro \
	--organizations home \
	--locations stc \
	--display-type SPICE \
	--set-console-password false \
	--url qemu+ssh://nariga@192.168.111.251/system

hammer compute-resource create --provider Libvirt \
	--name lenovo \
	--organizations home \
	--locations stc \
	--display-type SPICE \
	--set-console-password false \
	--url qemu+ssh://root@192.168.111.252/system

hammer os create --name Ubuntu \
	--architectures x86_64 \
	--family Debian \
	--major 16 --minor 04 \
	--release-name "xenial" \
	--description "Ubuntu Xenial"

hammer os create --name Ubuntu \
	--architectures x86_64 \
	--family Debian \
	--major 18 --minor 04 \
	--release-name "bionic" \
	--description "Ubuntu Bionic"

hammer os create --name Debian \
	--architectures x86_64 \
	--family Debian \
	--major 9 --minor 4 \
	--release-name "stretch" \
	--description "Debian Stretch"

hammer os create --name RedHat \
	--architectures x86_64 \
	--family Redhat \
	--major 7 --minor 4 \
	--description "RHEL Server 7.4"

hammer os create --name CentOS \
	--architectures x86_64 \
	--family Redhat \
	--major 6 --minor 9 \
	--description "CentOS 6.9"

hammer compute-resource image create \
	--compute-resource lenovo \
	--architecture x86_64 \
	--name centos7 \
	--operatingsystem "CentOS 7.4.1708" \
	--username root --password '123' \
	--user-data false \
	--uuid /home/libvirt/templates/centos

hammer compute-resource image create \
	--compute-resource lenovo \
	--architecture x86_64 \
	--name rhel7 \
	--operatingsystem "RHEL Server 7.4" \
	--username root --password '123' \
	--user-data false \
	--uuid /home/libvirt/templates/rhel

hammer compute-resource image create \
	--compute-resource lenovo \
	--architecture x86_64 \
	--name centos6 \
	--operatingsystem "CentOS 6.9" \
	--username root --password '123' \
	--user-data false \
	--uuid /home/libvirt/templates/centos6

hammer compute-resource image create \
	--compute-resource lenovo \
	--architecture x86_64 \
	--name debian9 \
	--operatingsystem "Debian Stretch" \
	--username root --password '123' \
	--user-data false \
	--uuid /home/libvirt/templates/debian9

hammer compute-resource image create \
	--compute-resource lenovo \
	--architecture x86_64 \
	--name ubuntu16 \
	--operatingsystem "Ubuntu Xenial" \
	--username root --password '123' \
	--user-data false \
	--uuid /home/libvirt/templates/ubuntu

hammer compute-resource image create \
	--compute-resource lenovo \
	--architecture x86_64 \
	--name ubuntu18 \
	--operatingsystem "Ubuntu Bionic" \
	--username root --password '123' \
	--user-data false \
	--uuid /home/libvirt/templates/ubuntu18
