class zabbix::centos-psql inherits zabbix{
	$firewall = 'firewalld'
	$srv_zabbix_pkg = ['zabbix-server-pgsql','zabbix','postgresql','zabbix-get']
	$cmd_populate = "psql -h $db_host -U $us_zbb $db_zbb < /usr/share/doc/zabbix-server-pgsql-$zabbix_version/create/schema.sql ;
			 psql -h $db_host -U $us_zbb $db_zbb < /usr/share/doc/zabbix-server-pgsql-$zabbix_version/create/images.sql ;
			 psql -h $db_host -U $us_zbb $db_zbb < /usr/share/doc/zabbix-server-pgsql-$zabbix_version/create/data.sql"

	if $db_pass != '0' {
		include zabbix::create-db
	}

#	file { 'repo':
#		ensure => present,
#		source => "puppet:///modules/zabbix/repo-$operatingsystem",
#		path => '/root/repositorio-zabbix.rpm',
#		mode => '0644',
#		owner => 'root',
#		group => 'root'
#	}

#	exec { 'install-repo-zabbix':
#		path => '/bin:/usr/bin:/sbin:/usr/sbin',
#		command => 'rpm -i /root/repositorio-zabbix.rpm',
#		unless => 'yum repolist | grep "Zabbix Official"',
#		require => File['repo']
#	}
#	->
	package { $srv_zabbix_pkg:
		ensure => present,
		allow_virtual => true,
	}
	->
	exec { 'db-populate':
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
		environment => "PGPASSWORD=$pass_db_zbb",
		command => $cmd_populate,
		unless => "psql -h $db_host -U $us_zbb $db_zbb -c \"\d\" | grep application_template",
#		require => Exec['initdb-zabbix-pg']
	}
	->
	file { 'zabbix_server.conf':
		ensure => present,
		content => template('zabbix/zabbix_server.conf.erb'),
		path => '/etc/zabbix/zabbix_server.conf',
		mode => '0640',
		owner => 'root',
		group => 'zabbix',
	}
	~>
	service { 'zabbix-server':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
