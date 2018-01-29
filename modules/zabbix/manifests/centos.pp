class zabbix::centos {
	$dependencies = [ 'zabbix-server-pgsql','zabbix-web-pgsql','zabbix-agent','postgresql-server' ]

	exec { 'add-repo':
                path => '/bin:/usr/bin',
		command => 'rpm -i http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm',
                unless => 'rpm -qa | grep zabbix-release',
	}
        ->
        package { $dependencies: ensure => present }
        ->
	exec { 'init-db':
                path => '/bin:/usr/bin',
		command => 'postgresql-setup initdb',
                subscribe => Package['postgresql-server'],
                refreshonly => true
	}
        ->
        service { 'postgresql':
               ensure => running,
               hasstatus => true,
               hasrestart => true,
               enable => true,
       }
}
