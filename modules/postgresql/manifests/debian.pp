class postgresql::debian {
	$packages = ['postgresql','postgresql-client']
	package { $packages:
		ensure => present,
		allow_virtual => true,
	}
	->
	file { 'pg_hba.conf':
		ensure => present,
		source => 'puppet:///modules/postgresql/pg_hba.conf',
		path => '/etc/postgresql/9.4/main/pg_hba.conf',
		mode => '0640',
		owner => 'postgres',
		group => 'postgres',
	}
	~>
	service { 'postgresql':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
