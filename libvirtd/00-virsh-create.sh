#!/bin/bash
name=foreman.local
smart_proxys="dhcp.local dns.local tftp.local puppet.local"

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
	ram=512
	ls /var/lib/libvirt/images/disks/$name || \
	  cp /var/lib/libvirt/images/templates/centos /var/lib/libvirt/images/disks/$name
	sync
	
	virsh list --all | grep $name || \
	  virt-install -n $name -r $ram --vcpus 1 \
	    -w bridge=br0,model=virtio --noautoconsole --import \
	    --disk path=/var/lib/libvirt/images/disks/$name,device=disk,bus=virtio \
	    --graphics type=spice --os-type linux --os-variant rhl7.3
done

prepare_instances(){
	vms="192.168.111.137 192.168.111.138 192.168.111.139 192.168.111.140"
	for i in $vms
	do
		ssh -t root@$i '
		yum install vim git -y ; git clone https://github.com/narigacdo/home-jab.git ; bash /root/home-jab/foreman/set_fixed_ip.sh'
	done
}
