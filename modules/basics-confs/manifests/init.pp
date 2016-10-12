class basics-confs {
	$packages = ['screen','git','vim-enhanced']
	package { $packages:
		ensure => present,
	}
}
