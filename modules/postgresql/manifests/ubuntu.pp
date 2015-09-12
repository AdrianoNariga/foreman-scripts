class postgresql::ubuntu inherits postgresql{
	$version = '9.3'
	package { ['postgresql','postgresql-contrib']:
		ensure => present,
		allow_virtual => true,
	}

	file { 'pg_hba.conf':
		ensure => present,
		source => 'puppet:///modules/postgresql/pg_hba.conf',
		path => "/etc/postgresql/$version/main/pg_hba.conf",
		mode => '0640',
		owner => 'postgres',
		group => 'postgres',
		notify => Service['postgresql'],
		require => [
			Package["postgresql"],
			Exec['change-file']
		]
	}

	file { 'postgresql.conf':
		ensure => present,
		source => 'puppet:///modules/postgresql/postgresql.conf',
		path => "/etc/postgresql/$version/main/postgresql.conf",
		mode => '0640',
		owner => 'postgres',
		group => 'postgres',
		notify => Service['postgresql'],
		require => Package["postgresql"],
	}


	service { 'postgresql':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => File['pg_hba.conf'],
	}

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
