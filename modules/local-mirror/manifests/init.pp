class local-mirror {
	define centos_repo($repo = $title,$repo_ip){
		$local_repo = $repo_ip
		file { $repo:
			ensure => present,
			mode => 0644,
			owner => 'root',
			group => 'root',
			content => template("local-mirror/repo.erb"),
			path => "/etc/yum.repos.d/$repo-homejab.repo",
		}
	}
	define rm_repo($repo = $title){
		file { $repo:
			ensure => absent,
			path => "/etc/yum.repos.d/$repo.repo",
		}
	}

	define deb_repo($repo = $title,$repo_ip){
		$local_repo = $repo_ip
		file { 'sources.list':
			ensure => present,
			mode => 0644,
			owner => 'root',
			group => 'root',
			content => template("local-mirror/debian.erb"),
			path => "/etc/apt/sources.list",
		}
	}
}
