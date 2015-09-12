class openstack-build::definitions::mysql-databases {
	define db-structure($server, $name_db = $title, $user_db = $title, $pass_db, $root_pass){
		Class['openstack-build::mysql-server'] -> Db-structure[$title]

		exec{ "$title-database":
			unless => "mysql -u root -p$root_pass -e \"show databases;\" | grep $name_db",
			command => "mysql -u root -p$root_pass -e \"create database $name_db;\"",
			path => '/usr/bin:/usr/sbin:/bin:/sbin',
		}

		exec{ "$title-user":
			unless => "mysql -u root -p$root_pass $name_db -e \"SHOW GRANTS FOR '$user_db'@'$server'\"",
			command => "mysql -u root -p$root_pass -e \
				   \"grant all privileges on $name_db.* to $user_db@\'$server\' identified by \'$pass_db\';
		  	   	flush privileges;\"",
			path => '/usr/bin:/usr/sbin:/bin:/sbin',
			require => Exec["$title-database"],
		}
	}
}
