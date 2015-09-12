class zabbix::create-db inherits zabbix::centos-psql {
	file { 'initdb-zabbix-pg':
		ensure => present,
		content => template('zabbix/initdb-zabbix-pg.erb'),
		path => '/root/initdb-zabbix-pg',
		mode => '0644',
		owner => 'root',
		group => 'root',
	}

	file { 'test-initdb':
		ensure => present,
		content => template('zabbix/test-initdb.erb'),
		path => '/root/test-initdb',
		mode => '0755',
		owner => 'root',
		group => 'root'
	}

	exec { 'initdb-zabbix-pg':
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
		environment => "PGPASSWORD=$db_pass",
		command => "psql -h $db_host -U postgres -f /root/initdb-zabbix-pg",
		unless => '/root/test-initdb',
		require => [
			File['test-initdb'],File ['initdb-zabbix-pg']
		]
	}

}
