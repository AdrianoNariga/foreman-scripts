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
