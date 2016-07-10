class kubernets {
#	class { 'selinux':
#		mode => 'permissive'
#	}

	service{ 'firewalld':
		ensure => stopped,
		enable => false
	}
}
