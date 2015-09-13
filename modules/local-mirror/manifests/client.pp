class local-mirror::client inherits local-mirror::functions {

	define centos_repo($repo = $title){
		$local_repo = '192.168.111.5'
		file { $repo:
			ensure => present,
			mode => 0644,
			owner => 'root',
			group => 'root',
			content => template("local-mirror/repo.erb"),
			path => "/etc/yum.repos.d/$repo-homejab.repo",
		}
	}

	centos_repo{ ['base','extras','updates','centosplus','epel','puppetlabs-deps','puppetlabs-products']: }
}
