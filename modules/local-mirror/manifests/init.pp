class local-mirror {
	$path_mirror = $path_mirror
	if $operatingsystem == 'Debian' {
		$packages = 'apt-mirror'
		$path = '/etc/apt/mirror.list'
		$mode = '0644'
	}
	elsif $operatingsystem == 'Ubuntu' {
		$packages = 'apt-mirror'
		$path = '/etc/apt/mirror.list'
		$mode = '0644'
	}
	elsif $operatingsystem == 'CentOS' {
		$packages = ['createrepo','yum-utils']
		$path = "$path_mirror/reposync"
		$mode = '0755'
	}

	package{ $packages:
		ensure => present,
	}

	file{ 'mirror-list':
		ensure => present,
		content => template("local-mirror/mirror.$operatingsystem.erb"),
		path => $path,
		mode => $mode,
		owner => 'root',
		group => 'root'
	}
}
