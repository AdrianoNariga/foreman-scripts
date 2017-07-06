#!/bin/bash
foreman_name=manager
domain="home.jab"
smart_proxys="dhcp dns tftp puppet"

virsh list --all | grep running | awk '{print $2}' | while read i
do
	virsh destroy $i
	virsh undefine $i --remove-all-storage
done
