class postgresql {
	$pass = $postgres_pass
	case $operatingsystem {
		Debian: {
			include postgresql::debian
		}
		CentOS: {
			include postgresql::centos
		}
		Ubuntu: {
			include postgresql::ubuntu
		}
		OpenSuSE: {
			include postgresql::opensuse
		}
		default: { }
	}
}
