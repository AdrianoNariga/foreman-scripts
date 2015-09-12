class mysql-server {
	$root_pass = $mysql_root_password
	if $operatingsystem == 'Debian' {
		$packages = ['mariadb-server','mariadb-client','expect']
		$path_cfg = '/etc/mysql'
		$service = 'mysql'
	}
	elsif $operatingsystem == 'Ubuntu' {
		$packages = ['mariadb-server','mariadb-client','expect']
		$path_cfg = '/etc/mysql'
		$service = 'mysql'
	}
	elsif $operatingsystem == 'CentOS' {
		$packages = ['mariadb-server','mariadb','expect']
		$path_cfg = '/etc/my.cnf.d'
		$service = 'mariadb'
	}

	package{ $packages:
		ensure => present,
	}
	->
	file{ 'mysql_secure_silent':
		ensure => present,
		content => template('mysql-server/mysql_secure_silent.erb'),
		path => "$path_cfg/mysql_secure_silent",
		owner => 'root',
		group => 'root',
		mode => '0755',
		require => Package[$packages],
		notify => Exec['set-password']
	}
	~>
	service{ $service:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Package[$packages]
	}
	~>
	exec{ 'set-password':
		command => "$path_cfg/mysql_secure_silent",
		path => '/bin:/usr/bin:/usr/sbin:/sbin',
		unless => "mysql -u root -p$root_pass -e \"show databases\"",
	}
}
