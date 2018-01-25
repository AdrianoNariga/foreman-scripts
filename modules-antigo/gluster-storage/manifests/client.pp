class gluster-storage::client {
	$packages = ['glusterfs','glusterfs-fuse']

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
}
