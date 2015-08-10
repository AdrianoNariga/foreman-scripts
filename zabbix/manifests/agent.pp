class zabbix::agent {
	$zabbix_version = '2.4.4'
	$zabbix_server = $zabbix_server
	if $operatingsystem == 'Debian' {
		$cmd_install_repo = 'dpkg -i /root/repo.pkg ; apt-get update'
		$unless_install = 'ls -l /etc/apt/sources.list.d/zabbix.list'
	}
	elsif $operatingsystem == 'Ubuntu' {
		$cmd_install_repo = 'dpkg -i /root/repo.pkg ; apt-get update'
		$unless_install = 'ls -l /etc/apt/sources.list.d/zabbix.list'
	}
	elsif $operatingsystem == 'CentOS' {
		$cmd_install_repo = 'rpm -i /root/repo.pkg'
		$unless_install = 'yum repolist | grep zabbix'
	}

	file{ 'repo-zabbix':
		ensure => present,
		source => "puppet:///modules/zabbix/repo-$operatingsystem",
		path => '/root/repo.pkg',
		mode => '0644',
		owner => 'root',
		group => 'root',
	}

	exec{ 'install-repo':
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		command => $cmd_install_repo,
		unless => $unless_install,
		require => File['repo-zabbix'],
	}

	package{ 'zabbix-agent':
		ensure => present,
		allow_virtual => true,
		require => Exec['install-repo']
	}

	file{ 'zabbix-agent':
		ensure => present,
		content => template("zabbix/$operatingsystem-agentd.conf.erb"),
		path => '/etc/zabbix/zabbix_agentd.conf',
		mode => '0644',
		owner => 'root',
		group => 'root',
		require => Package['zabbix-agent'],
		notify => Service['zabbix-agent']
	}

	service{ 'zabbix-agent':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => File['zabbix-agent']
	}
}
