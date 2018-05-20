#!/bin/bash
for i in vostro lenovo
do
	hammer compute-resource image create \
	        --compute-resource $i \
	        --architecture x86_64 \
	        --name centos7 \
	        --operatingsystem "CentOS 7.5.1804" \
	        --username root --password '123' \
	        --user-data false \
	        --uuid /home/libvirt/templates/centos
	
	hammer compute-resource image create \
	        --compute-resource $i \
	        --architecture x86_64 \
	        --name rhel7 \
	        --operatingsystem "RHEL Server 7.4" \
	        --username root --password '123' \
	        --user-data false \
	        --uuid /home/libvirt/templates/rhel
	
	hammer compute-resource image create \
	        --compute-resource $i \
	        --architecture x86_64 \
	        --name centos6 \
	        --operatingsystem "CentOS 6.9" \
	        --username root --password '123' \
	        --user-data false \
	        --uuid /home/libvirt/templates/centos6
	
	hammer compute-resource image create \
	        --compute-resource $i \
	        --architecture x86_64 \
	        --name debian9 \
	        --operatingsystem "Debian Stretch" \
	        --username root --password '123' \
	        --user-data false \
	        --uuid /home/libvirt/templates/debian9
	
	hammer compute-resource image create \
	        --compute-resource $i \
	        --architecture x86_64 \
	        --name ubuntu16 \
	        --operatingsystem "Ubuntu Xenial" \
	        --username root --password '123' \
	        --user-data false \
	        --uuid /home/libvirt/templates/ubuntu16
	
	hammer compute-resource image create \
	        --compute-resource $i \
	        --architecture x86_64 \
	        --name ubuntu18 \
	        --operatingsystem "Ubuntu Bionic" \
	        --username root --password '123' \
	        --user-data false \
	        --uuid /home/libvirt/templates/ubuntu18
done
