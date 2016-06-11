class basics-confs::off-repo::redhat::openstack7{
	$local_repo = '192.168.111.5'
	$repo = 'openstack-7'
	$label = 'RH Openstack 7'
	$_path = 'rhel-7-server-openstack-7.0-rpms'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("basics-confs/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo-homejab.repo",
	}
}
