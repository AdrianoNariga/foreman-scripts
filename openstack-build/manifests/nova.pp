class openstack-build::nova inherits openstack-build{
	$memcache = 'ops-heat'
	$rabbitmq = 'ops-heat'
	package { 'openstack-nova':
		ensure => present
	}

	file { 'nova.conf':
		ensure => present,
		path => "/etc/nova/nova.conf",
		content => template("openstack-build/nova.conf.erb"),
		owner => 'root',
		group => 'nova',
		mode => 0640,
		require => Package['openstack-nova']
	}
	file { 'ifcfg-dummy0':
		ensure => present,
		path => "/etc/sysconfig/network-scripts/ifcfg-dummy0",
		source => 'puppet:///modules/openstack-build/ifcfg-dummy0',
		owner => 'root',
		group => 'root',
		mode => 0640,
	}
	file { 'dummy.conf':
		ensure => present,
		path => "/etc/modprobe.d/dummy.conf",
		content => "alias dummy0 dummy",
		owner => 'root',
		group => 'nova',
		mode => 0640,
	}

	exec{ 'up-dummy0':
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		command => 'ifup dummy0',
		unless => 'ip a s | grep dummy0',
		require => File['dummy.conf', 'ifcfg-dummy0']
	}

	exec{ 'populate-db':
		command => 'nova-manage db sync ; chown -R nova. /var/log/nova',
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		unless => "mysql -u nova -h $db_host -p$ps_nova_db nova -e \"select * from instances;\"",
		require => File['nova.conf']
	}

	$services = 'openstack-nova'
	service{ ["$services-api","$services-objectstore","$services-conductor","$services-scheduler","$services-cert","$services-consoleauth","$services-compute","$services-network"]:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Exec['populate-db']
	}
}
