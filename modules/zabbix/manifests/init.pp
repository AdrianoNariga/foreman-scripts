class zabbix {
	$packages = 'zabbix-ce'

	if $operatingsystem == 'Debian' {
                include zabbix::debian
	}
	elsif $operatingsystem == 'Ubuntu' {
                include zabbix::ubuntu
	}
	elsif $operatingsystem == 'CentOS' {
                include zabbix::centos
	}

#	package { $packages: ensure => present }
#	->
#	service { 'zabbix':
#		ensure => running,
#		hasstatus => true,
#		hasrestart => true,
#		enable => true,
#	}
}
