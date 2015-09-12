class postgresq::lset-password {
	exec { 'change-file':
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
		command => "echo \"local all all ident\" > /etc/postgresql/$version/main/pg_hba.conf ;
			    service postgresql restart", 
		unless => "psql -U postgres -c \"\"",
		environment => "PGPASSWORD=$pass",
		notify => Exec['set-password']
	}

	exec { 'set-password':
		path => '/bin/:/usr/bin',
		command => "psql -c \"alter user postgres with password '$pass';\"",
		user => 'postgres',
		require => Exec['change-file'],
		refreshonly => true,
		notify => File['pg_hba.conf']
	}

}
