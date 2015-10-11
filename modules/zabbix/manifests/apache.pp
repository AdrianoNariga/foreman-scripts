class zabbix::apache inherits zabbix::centos-psql{
	if $operatingsystem == 'Debian' { }
	elsif $operatingsystem == 'Ubuntu' { }
	elsif $operatingsystem == 'CentOS' {
		$web_pkgs = ['httpd','php','php-devel','php-gd','php-ctype','php-xml','php-xmlreader',
			     'php-session','php-mbstring','php-gettext','php-pgsql','zabbix-web-pgsql']
		$lib_pkgs = ['OpenIPMI','OpenIPMI-devel','flex','libxml2','libxml2-devel',
			     'curl-devel','libssh2','libssh2-devel']
		$snmp_pkgs = ['net-snmp','net-snmp-devel','net-snmp-libs','net-snmp-perl',
			      'net-snmp-python','net-snmp-utils','perl-SNMP_Session']	
	}

	package { $web_pkgs:
		ensure => present,
		allow_virtual => true,
		notify => Service['httpd'],
#		require => Exec['install-repo-zabbix']
	}

	package { $lib_pkgs:
		ensure => present,
		allow_virtual => true,
	}

	package { $snmp_pkgs:
		ensure => present,
		allow_virtual => true
	}

	file { 'php.ini':
		ensure => present,
		source => 'puppet:///modules/zabbix/php.ini',
		path => '/etc/php.ini',
		mode => '0644',
		owner => 'root',
		group => 'root',
		require => Package['php'],
		notify => Service['httpd']
	}

	service { 'httpd':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => [
			File['php.ini'],
			Service['zabbix-server']
		]
	}

	exec { 'permissive-se':
		command => 'setenforce permissive',
		path => '/bin:/sbin:/usr/sbin:/usr/bin',
		unless => 'sestatus | grep permissive',
	}
}
