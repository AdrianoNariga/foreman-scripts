class zabbix::win-agent{
	$zabbix_server = '192.168.111.7'
	file { 'zabbix-directory':
		ensure => directory,
		source => 'puppet:///modules/zabbix/zabbix_windows',
		path => 'C:\zabbix',
		owner => 'Administrator',
		group => 'Administrators',
		mode => 0775,
		recurse => true,
	}

	file{ 'zabbix-agent':
		ensure => present,
		content => template("zabbix/$operatingsystem-agentd.conf.erb"),
		path => 'C:\zabbix\zabbix_agentd.conf',
		mode => '0644',
		owner => 'Administrator',
		group => 'Administrators',
		require => File['zabbix-directory'],
		notify => Service['Zabbix Agent']
	}

	exec{ 'enable-server':
		command => 'c:\zabbix\zabbix_agentd.exe -i -c c:\zabbix\zabbix_agentd.conf',
		require => File['zabbix-agent'],
		subscribe => File['zabbix-agent'],
		refreshonly => true
	}

	service{ 'Zabbix Agent':
		ensure => running,
		enable => true
	}
}
