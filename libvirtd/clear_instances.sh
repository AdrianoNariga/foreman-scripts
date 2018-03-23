#!/bin/bash
foreman_name=manager
domain="home.lab"
smart_proxys="dhcp dns tftp puppet"

virsh list --all | egrep 'running|shut' | awk '{print $2}' | while read i
do
	virsh snapshot-delete $i --current
	virsh destroy $i
	virsh undefine $i --remove-all-storage
done
