class postgresql::centos {
	$packages = ['postgresql','postgresql-libs','postgresql-plperl','postgresql-plpython','postgresql-server']
	package { $packages:
		ensure => present,
	}
	->
	exec { 'init-base':
		path => '/bin/:/usr/bin/:/sbin/:/usr/sbin',
		command => 'postgresql-setup initdb',
		unless => 'postgresql-check-db-dir /var/lib/pgsql/data/',
	}
	->
	file { 'pg_hba.conf':
		ensure => present,
		source => 'puppet:///modules/postgresql/pg_hba.conf',
		path => '/var/lib/pgsql/data/pg_hba.conf',
		mode => '0600',
		owner => 'postgres',
		group => 'postgres',
	}
	~>
	service { "postgresql":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
