class libvirt-kvm::server {
	if $operatingsystem == 'Debian' {
		$packages = ['qemu-kvm','libvirt-bin','virtinst','bridge-utils']
		$libvirtd = 'libvirtd'
	}
	elsif $operatingsystem == 'Ubuntu' {
		$packages = ['qemu-kvm','libvirt-bin virtinst','bridge-utils']
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
		source => "puppet:///modules/libvirt-kvm/libvirtd.$operatingsystem",
		path => "/etc/libvirt/libvirtd.conf",
		mode => 0644,
		owner => 'root',
		group => 'root'
	}
	~>
	service { $libvirtd:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true
	}
}
