class postgresql::centos {
	$pgsql_version = '9.4'
	$pgsql_v = '94'
	$pass = '123'

$cmd_initdb = "rm -rf /var/lib/pgsql/$pgsql_version/data/* ; /usr/pgsql-$pgsql_version/bin/postgresql$pgsql_v-setup initdb ; systemctl restart postgresql-9.4.service"
$unless_initdb = "/usr/pgsql-$pgsql_version/bin/postgresql$pgsql_v-check-db-dir /var/lib/pgsql/$pgsql_version/data/"

	file { 'rpm-repo':
		source => "puppet:///modules/postgresql-nag/pgdg-$operatingsystemmajrelease-$pgsql_version.noarch.rpm",
		path => '/root/pgdg-centos.noarch.rpm',
		mode => '0644',
		owner => 'root',
		group => 'root',
	}

	exec { 'install-repo':
		path => '/bin/:/usr/bin/:/sbin/:/usr/sbin',
		command => 'rpm -i /root/pgdg-centos.noarch.rpm',
		unless => 'yum repolist | grep PostgreSQL',
		require => File['rpm-repo']
	}

	package { ["postgresql$pgsql_v-server","postgresql$pgsql_v-libs"]:
		ensure => present,
		allow_virtual => true,
		require => Exec['install-repo'],
	}

	exec { 'init-base':
		path => '/bin/:/usr/bin/:/sbin/:/usr/sbin',
		command => $cmd_initdb,
		unless => $unless_initdb,
		require => Package["postgresql$pgsql_v-server"],
		notify => Exec['set-password']
	}

	service { "postgresql-$pgsql_version":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Exec['init-base']
	}

	exec { 'set-password':
		path => '/bin/:/usr/bin',
		command => "psql -c \"alter user postgres with password '$pass';\"",
		environment => "PGPASSWORD=$pass",
		unless => "psql -c \"\"",
		user => 'postgres',
		require => Exec['init-base'],
		before => File['pg_hba.conf']
	}

	file { 'pg_hba.conf':
		ensure => present,
		source => 'puppet:///modules/postgresql-nag/pg_hba.conf',
		path => '/var/lib/pgsql/9.4/data/pg_hba.conf',
		mode => '0600',
		owner => 'postgres',
		group => 'postgres',
		require => [
			Package["postgresql$pgsql_v-server"],
			Exec['set-password']
		],
		notify => Service["postgresql-$pgsql_version"]
	}

	file { 'postgresql.conf':
		ensure => present,
		source => 'puppet:///modules/postgresql-nag/postgresql.conf',
		path => "/var/lib/pgsql/$pgsql_version/data/postgresql.conf",
		mode => '0600',
		owner => 'postgres',
		group => 'postgres',
		require => [
			Package["postgresql$pgsql_v-server"],
			Exec['init-base']
		],
		notify => Service["postgresql-$pgsql_version"]
	}


}
