class repo-offline::redhat::core{
	$local_repo = '192.168.111.5'
	$repo = 'core'
	$_path = 'rhel-7-server-rpms'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("repo-offline/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo.repo",
	}
}
