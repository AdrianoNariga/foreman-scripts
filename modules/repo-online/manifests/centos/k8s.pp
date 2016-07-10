class repo-online::centos::k8s{
	$repo = 'k8s'
	$base_url = 'http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/'
	file { $repo:
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		content => template("repo-online/$operatingsystem.erp"),
		path => "/etc/yum.repos.d/$repo.repo",
	}
}
