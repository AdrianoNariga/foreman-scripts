class basics-confs {
	$packages = ['screen']
	package { $packages:
		ensure => present,
	}
}
