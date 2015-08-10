class openstack-build::memcached{
	package{ 'memcached':
		ensure => present,
		allow_virtual => true
	}

	service{ 'memcached':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Package['memcached']
	}
}
