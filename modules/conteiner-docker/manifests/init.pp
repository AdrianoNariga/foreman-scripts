class conteiner-docker {
	if $operatingsystem == 'Debian' {
		$packages = 'docker.io'
	}
	elsif $operatingsystem == 'Ubuntu' {
		$packages = 'docker.io'
	}
	elsif $operatingsystem == 'CentOS' {
		$packages = 'docker'
	}

	package { $packages:
		ensure => present,
	}
	->
	service { $packages:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
