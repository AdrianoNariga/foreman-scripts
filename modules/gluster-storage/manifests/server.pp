class gluster-storage::server {
	$packages = ['glusterfs','glusterfs-fuse','glusterfs-server']

	file { 'add-repo':
		ensure => present,
		source => 'puppet:///modules/gluster-storage/glusterfs-epel.repo',
		path => '/etc/yum.repos.d/glusterfs-epel.repo',
		mode => 0644,
		owner => 'root',
		group => 'root',
	}
	->
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
