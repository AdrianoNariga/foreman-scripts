#!/bin/bash
foreman_name=manager
domain="home.lab"

vm_so1="$foreman_name tftp puppet"
vm_so2="dhcp dns"

smart_proxys="$vm_so1 $vm_so2"

path_disks="/home/libvirt/disks/"
path_templates="/home/libvirt/templates/"

for name in $vm_so1
do
	ram=256
	cpu=1

	echo $name | grep $foreman_name && ram=4092 && cpu=2
	echo $name | grep puppet && ram=1024 && cpu=1

	test -f $path_disks/$name.$domain || \
	  cp $path_templates/centos $path_disks/$name.$domain
	sync
	
	virsh list --all | grep $name.$domain || \
	  virt-install -n $name.$domain -r $ram --vcpus $cpu \
	    -w network=foreman,model=virtio --noautoconsole --import \
	    --disk path=$path_disks/$name.$domain,device=disk,bus=virtio \
	    --graphics type=spice --os-type linux --os-variant rhl7.3
done

for name in $vm_so2
do
	ram=256
	test -f $path_disks/$name.$domain || \
	  cp $path_templates/debian9 $path_disks/$name.$domain
	sync
	
	virsh list --all | grep $name.$domain || \
	  virt-install -n $name.$domain -r $ram --vcpus 1 \
	    -w network=foreman,model=virtio --noautoconsole --import \
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
