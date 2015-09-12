class mysql-server::server {
	$root_pass = $mysql_root_password
	$packages = ['mariadb-server','mariadb','expect','ntp','ntpdate']
	package{ $packages:
		ensure => present,
		allow_virtual => true,
	}

	service{ 'mariadb':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Package[$packages]
	}

	file{ 'mysql_secure_silent':
		ensure => present,
		content => template('mysql-server/mysql_secure_silent.erb'),
		path => '/etc/my.cnf.d/mysql_secure_silent',
		owner => 'root',
		group => 'root',
		mode => '0755',
		require => Package[$packages]
	}

	exec{ 'set-password':
		command => "/etc/my.cnf.d/mysql_secure_silent",
		path => '/bin:/usr/bin:/usr/sbin:/sbin',
		unless => "mysql -u root -p$root_pass -e \"show databases\"",
		require => [
			Service['mariadb'],
			File['mysql_secure_silent']
		]
	}
}
