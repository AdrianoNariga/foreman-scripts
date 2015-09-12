class postgresql {
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
		default: { }
	}
}
