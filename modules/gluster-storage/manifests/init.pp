class gluster-storage {
	$packages = ['glusterfs','glusterfs-fuse','glusterfs-server']

	package{ $packages:
		ensure => present,
	}
	->
	service{ 'glusterd':
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
	}
}
