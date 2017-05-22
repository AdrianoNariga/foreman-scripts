class libvirtd::server {
	if $operatingsystem == 'Debian' {
		if $lsbdistid != 'elementary OS' {			
			$packages = ['qemu-kvm','libvirt-bin','virtinst','bridge-utils']
			$libvirtd = 'libvirtd'
                }
		else{
			$packages = ['qemu-kvm','libvirt-bin','virtinst','bridge-utils']
			$libvirtd = 'libvirt-bin'
		}
	}
	elsif $operatingsystem == 'Ubuntu' {
		$packages = ['qemu-kvm','libvirt-bin','virtinst','bridge-utils']
		$libvirtd = 'libvirt-bin'
	}
	elsif $operatingsystem == 'CentOS' {
		$packages = ['qemu-kvm','libvirt','virt-install','bridge-utils']
		$libvirtd = 'libvirtd'
	}

	package{ $packages:
		ensure => present,
	}
	->
	group { 'libvirt':
		ensure => 'present',
	}
	->
	file{ 'config':
		ensure => present,
		source => "puppet:///modules/libvirtd/libvirtd.$operatingsystem",
		path => "/etc/libvirt/libvirtd.conf",
		mode => 0644,
		owner => 'root',
		group => 'root'
	}
	~>
	service { $libvirtd:
		provider => "systemd",
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true
	}
}
