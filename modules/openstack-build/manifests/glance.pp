class openstack-build::glance inherits openstack-build{
	package { 'openstack-glance':
		ensure => present
	}

	file { 'glance-api.conf':
		ensure => present,
		path => "/etc/glance/glance-api.conf",
		content => template("openstack-build/glance-api.conf.erb"),
		owner => 'root',
		group => 'glance',
		mode => 0640,
		require => Package['openstack-glance']
	}
	file { 'glance-registry.conf':
		ensure => present,
		path => "/etc/glance/glance-registry.conf",
		content => template("openstack-build/glance-registry.conf.erb"),
		owner => 'root',
		group => 'glance',
		mode => 0640,
		require => Package['openstack-glance']
	}

	exec{ 'populate-db':
		command => 'glance-manage db_sync ; chown -R glance. /var/log/glance',
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		unless => "mysql -u glance -h $db_host -p$ps_glance_db glance -e \"select * from images;;\"",
		require => File['glance-registry.conf']
	}

	service{ ['openstack-glance-api','openstack-glance-registry']:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Exec['populate-db']
	}
}
