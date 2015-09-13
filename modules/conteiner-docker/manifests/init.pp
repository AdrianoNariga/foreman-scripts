class conteiner-docker {
	if $operatingsystem == 'Debian' {
		$packages = ''
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
	service { 'docker':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
