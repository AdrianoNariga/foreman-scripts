#!/bin/bash
foreman_name=manager
domain="home.jab"
smart_proxys="dhcp dns tftp puppet"

path_disks="/home/libvirt/disks/"
path_templates="/home/libvirt/templates/"

image_foreman=centos
image_proxyes=debian9

test -f $path_disks/$foreman_name.$domain || \
  cp $path_templates/$image_foreman $path_disks/$foreman_name.$domain
sync

virsh list --all | grep $foreman_name.$domain || \
  virt-install -n $foreman_name.$domain -r 4096 --vcpus 2 \
    -w bridge=br0,model=virtio --noautoconsole --import \
    --disk path=$path_disks/$foreman_name.$domain,device=disk,bus=virtio \
    --graphics type=spice --os-type linux --os-variant rhl7.3

for name in $smart_proxys
do
	ram=256
	test -f $path_disks/$name.$domain || \
	  cp $path_templates/$image_proxyes $path_disks/$name.$domain
	sync
	
	virsh list --all | grep $name.$domain || \
	  virt-install -n $name.$domain -r $ram --vcpus 1 \
	    -w bridge=br0,model=virtio --noautoconsole --import \
	    --disk path=$path_disks/$name.$domain,device=disk,bus=virtio \
	    --graphics type=spice --os-type linux --os-variant rhl7.3
done

prepare_instances(){
	vms="192.168.111.144 192.168.111.145 192.168.111.146 192.168.111.147 192.168.111.148"
	for i in $vms
	do
		ssh -t root@$i '
		yum install vim git -y ; git clone https://github.com/narigacdo/home-jab.git ; bash /root/home-jab/libvirtd/set_fixed_ip.sh ; init 0'
	done
}

set_mem_cpu(){
	for i in tftp.local dns.local dhcp.local
	do
		virsh destroy $i
		virsh setmaxmem $i 262144 --config
		virsh setmem $i 262144 --config
		virsh start $i
	done
}
