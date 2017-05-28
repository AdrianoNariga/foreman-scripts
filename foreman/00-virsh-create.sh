#!/bin/bash
name=foreman.local
smart_proxys="proxy.local puppet.local"

ls /var/lib/libvirt/images/disks/$name || \
  cp /var/lib/libvirt/images/templates/centos /var/lib/libvirt/images/disks/$name
sync

virsh list --all | grep $name || \
  virt-install -n $name -r 2048 --vcpus 1 \
    -w bridge=br0,model=virtio --noautoconsole --import \
    --disk path=/var/lib/libvirt/images/disks/$name,device=disk,bus=virtio \
    --graphics type=spice --os-type linux --os-variant rhl7.3


for name in $smart_proxys
do
	ram=1024
	ls /var/lib/libvirt/images/disks/$name || \
	  cp /var/lib/libvirt/images/templates/centos /var/lib/libvirt/images/disks/$name
	sync
	
	virsh list --all | grep $name || \
	  virt-install -n $name -r $ram --vcpus 1 \
	    -w bridge=br0,model=virtio --noautoconsole --import \
	    --disk path=/var/lib/libvirt/images/disks/$name,device=disk,bus=virtio \
	    --graphics type=spice --os-type linux --os-variant rhl7.3
done
