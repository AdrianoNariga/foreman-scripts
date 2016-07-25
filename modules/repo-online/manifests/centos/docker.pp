class repo-online::centos::docker{
	$repo = 'dockerrepo'
	$base_url = 'http://yum.dockerproject.org/repo/main/centos/7/'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("repo-online/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo.repo",
	}
}
