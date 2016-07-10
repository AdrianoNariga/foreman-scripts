class repo-offline::redhat::extras{
	$local_repo = '192.168.111.5'
	$repo = 'extras'
	$_path = 'rhel-7-server-extras-rpms'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("repo-offline/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo.repo",
	}
}
