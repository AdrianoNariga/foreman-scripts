class mysql-server::remote_root inherits mysql-server::server {
	$access = $root_from_access
	exec{ 'root-access':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => "mysql -u root -p$root_pass --execute \"GRANT ALL PRIVILEGES ON *.* TO \'root\'@\'$access\' IDENTIFIED BY \'$root_pass\';\"",
		unless => "mysql -u root -p$root_pass --execute \"SELECT host, user, password FROM mysql.user WHERE host = \'$access\';\" | grep $access",
		require => Exec['set-password']
	}
}
