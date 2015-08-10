class puppet-agent {
	if $operatingsystem == 'Debian' {
		include puppet-agent::debian
	}
	elsif $operatingsystem == 'Ubuntu' {
		include puppet-agent::ubuntu
	}
	elsif $operatingsystem == 'CentOS' {
		include puppet-agent::centos
	}

}
