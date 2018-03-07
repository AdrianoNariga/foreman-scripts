#!/bin/bash
hosts="
dhcp.home.jab
dns.home.jab
manager.home.jab
puppet.home.jab
tftp.home.jab"

for i in $hosts
do
	virsh snapshot-create-as --domain $i --name "foreman1.15"
done
