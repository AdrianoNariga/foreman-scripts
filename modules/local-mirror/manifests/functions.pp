class local-mirror::functions {
	define centos_repos($repository,$local_repo){
		$repo = ['base','update']
                file { "$title-$repo":
                        ensure => present,
			mode => 0644,
			owner => 'root',
			group => 'root',
                        content => template("local-mirror/repo.erb"),
                        path => "/etc/yum.repos.d/$repo-homejab.repo",
                }
        }
}
