class openstack-build::dashboard inherits openstack-build{
	package { 'openstack-dashboard':
		ensure => present
	}

#	file { 'local_settings':
#		ensure => present,
#		path => "/etc/glance/glance-api.conf",
#		content => template("openstack-build/glance-api.conf.erb"),
#		owner => 'root',
#		group => 'glance',
#		mode => 0640,
#		require => Package['openstack-glance']
#	}

	service{ ['httpd']:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Package['openstack-dashboard']
	}
}
