class repo-offline::redhat::common{
	$local_repo = '192.168.111.5'
	$repo = 'common'
	$_path = 'rhel-7-server-rh-common-rpms'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("repo-offline/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo.repo",
	}
}
