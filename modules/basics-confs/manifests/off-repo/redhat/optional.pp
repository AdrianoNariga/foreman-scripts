class basics-confs::off-repo::redhat::optional{
	$local_repo = '192.168.111.5'
	$repo = 'optional'
	$label = 'RH optional'
	$_path = 'rhel-7-server-optional-rpms'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("basics-confs/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo-homejab.repo",
	}
}
