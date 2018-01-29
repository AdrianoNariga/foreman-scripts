class docker {

	if $operatingsystem == 'Debian' {
                include docker::debian
	        $packages = 'docker-ce'
	}
	elsif $operatingsystem == 'Ubuntu' {
                include docker::ubuntu
	        $packages = 'docker-ce'
	}
	elsif $operatingsystem == 'CentOS' {
                include docker::centos
	        $packages = 'docker-ce'
	}
	elsif $operatingsystem == 'RedHat' {
                include docker::redhat
                $packages = 'docker'
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
