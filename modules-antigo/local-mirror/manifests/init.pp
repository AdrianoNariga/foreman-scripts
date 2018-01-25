class local-mirror {
	$local_repo = '192.168.111.5'

	if $operatingsystem == 'Debian' {
		include local-mirror::client-deb
	}
	elsif $operatingsystem == 'Ubuntu' {
		include local-mirror::client-deb
	}
	elsif $operatingsystem == 'CentOS' {
		include local-mirror::client-rpm
	}
}
