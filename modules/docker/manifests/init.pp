class docker {
	$packages = 'docker-ce'

	if $operatingsystem == 'Debian' {
                include docker::debian
	}
	elsif $operatingsystem == 'Ubuntu' {
                include docker::ubuntu
	}
	elsif $operatingsystem == 'CentOS' {
                include docker::centos
	}

	package { $packages: ensure => present }
	->
	service { 'docker':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
