class basics-confs::off-repo::redhat::openstack8{
	$local_repo = '192.168.111.5'
	$repo = 'openstack-8'
	$label = 'RH Openstack 8'
	$_path = 'rhel-7-server-openstack-8-rpms'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("basics-confs/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo-homejab.repo",
	}
}
