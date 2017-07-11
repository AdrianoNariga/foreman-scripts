#!/bin/bash
# compute profile	host group
# - CPU 1		- x86_64
# - Memory 2GB		- set root pass
# - Network br0		- parameters
# - Disk 30 GB		  - ansible_ssh_key
# exemplo		  - remote_execution_create_user
#			  - remote_execution_ssh_keys
#			  - remote_execution_ssh_user
# script debian test-name

centos(){
	name_host=$1
	hammer host create \
	  --hostgroup=default \
	  --compute-resource=192.168.111.252 \
	  --compute-profile=default \
	  --compute-attributes="start=1" \
	  --operatingsystem="CentOS Linux 7.3.1611" \
	  --provision-method="build" \
	  --pxe-loader="PXELinux BIOS" \
	  --medium="CentOS mirror" \
	  --partition-table="Kickstart default" \
	  --name="$name_host"
}

debian(){
	name_host=$1
	hammer host create \
	  --hostgroup=default \
	  --compute-resource=192.168.111.252 \
	  --compute-profile=default \
	  --compute-attributes="start=1" \
	  --operatingsystem="Debian 9.0.0" \
	  --provision-method="build" \
	  --pxe-loader="PXELinux BIOS" \
	  --medium="Debian mirror" \
	  --partition-table="Preseed custom LVM" \
	  --name="$name_host"
}

case $1 in
	debian) debian $2 ;;
	centos) centos $2 ;;
esac
