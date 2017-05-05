class users-access::root {
	$key_ssh = $root_key_ssh
	user { 'root':
		ensure => present,
		gid => 'root',
		home => '/root',
		uid => 0,
		shell => '/bin/bash',
		comment => 'usuario master',
		password => '$1$uRUXNp8y$1rEGwDpdXD.iHiJUU6w2E1',
		password_max_age => '99999',
		password_min_age => '0',
	}

	file{ '/root/.ssh':
		ensure => directory,
		owner => 'root',
		group => 'root',
		mode => '0700',
		require => User['root']
	}

	file{ '/root/.ssh/authorized_keys':
		ensure => present,
		content => $key_ssh,
		owner => 'root',
		group => 'root',
		mode => '0644',
		require => File['/root/.ssh']
	}
}
