class postgresql::debian {
	file { 'pgdg.list':
		ensure => present,
		source => 'puppet:///modules/postgresql-nag/pgdg.list',
		path => '/etc/apt/sources.list.d/pgdg.list',
		mode => '0644',
		owner => 'root',
		group => 'root',
	}

	file { 'keypgdg-deb.asc':
		ensure => present,
		source => 'puppet:///modules/postgresql-nag/keypgdg-deb.asc',
		path => '/etc/apt/sources.list.d/keypgdg-deb.asc',
		mode => '0644',
		owner => 'root',
		group => 'root',
	}

	exec { 'add-key':
		path => '/bin/:/usr/bin/:/sbin/:/usr/sbin',
		command => 'apt-key add /etc/apt/sources.list.d/keypgdg-deb.asc ; aptitude update',
		unless => 'apt-key list | grep PostgreSQL',
		require => [
			File['pgdg.list'],
			File['keypgdg-deb.asc'],
		],
	}

	package { 'postgresql-9.3':
		ensure => present,
		allow_virtual => true,
		require => Exec['add-key']
	}

	file { 'pg_hba.conf':
		ensure => present,
		source => 'puppet:///modules/postgresql-nag/pg_hba.conf',
		path => '/etc/postgresql/9.3/main/pg_hba.conf',
		mode => '0640',
		owner => 'postgres',
		group => 'postgres',
		require => Package['postgresql-9.3'],
		notify => Service['postgresql']
	}

	service { 'postgresql':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => File['pg_hba.conf'],
	}
}
