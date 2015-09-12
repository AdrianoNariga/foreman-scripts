class integrated-squid::squid3 inherits integrated-squid {
	require integrated-squid::samba
	user { 'proxy':
		ensure           => 'present',
		comment          => 'proxy',
		gid              => '13',
		groups           => ['winbindd_priv'],
		home             => '/bin',
		password         => '*',
		password_max_age => '99999',
		password_min_age => '0',
		shell            => '/usr/sbin/nologin',
		uid              => '13',
	}
	->
	file { 'winbind':
		ensure => present,
		source => 'puppet:///modules/integrated-squid/winbind',
		path => '/etc/init.d/winbind',
		owner => 'root',
		group => 'root',
		mode => 0755
	}
	~>
	exec { 'refresh-daemon':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'systemctl daemon-reload',
		subscribe => File['winbind'],
		refreshonly => true
	}
	->
	file { 'bloqueios':
		ensure => directory,
		source => 'puppet:///modules/integrated-squid/txt_lists',
		path => '/etc/squid3/txt_lists',
		recurse => true,
		owner => 'proxy'
	}
	->
	file { 'squid.conf':
		ensure => present,
		content => template('integrated-squid/squid.conf.erb'),
		path => '/etc/squid3/squid.conf',
		owner => 'root',
		group => 'root',
		mode => 0644
	}
	~>
	service { 'squid3':
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
	}
}
