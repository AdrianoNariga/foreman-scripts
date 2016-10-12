class basics-confs {
	$packages = ['screen','vim','git']
	package { $packages:
		ensure => present,
	}
}
