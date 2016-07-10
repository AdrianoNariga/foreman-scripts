class kubernets::minions{
	$pkgs = ['kubernetes','flannel']
	package { $pkgs:
		ensure => present,
		allow_virtual => true,
	}
}
