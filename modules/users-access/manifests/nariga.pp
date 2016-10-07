class users-access::nariga {
	$key_ssh = $nariga_ssh_keys
	$usuario = 'nariga'

	user { $usuario:
		ensure => present,
		gid => 'users',
		groups => ['users','puppet'],
		home => "/home/$usuario",
		managehome => true,
		uid => 1001,
		shell => '/bin/bash',
		comment => 'usuario de gerencia',
		password => '$1$LvVBgnce$XCM6TqqeG6SUl5QK0MvN2.',
		password_max_age => '99999',
		password_min_age => '0',
	}

	file{ "/home/$usuario":
		ensure => directory,
		owner => $usuario,
		group => 'users',
		mode => 0750,
		require => User[$usuario],
	}

	file{ "/home/$usuario/.ssh":
		ensure => directory,
		owner => $usuario,
		group => 'users',
		mode => '0700',
		require => File["/home/$usuario"]
	}

	file{ "/home/$usuario/.screenrc":
		ensure => present,
		owner => $usuario,
		source => 'puppet:///modules/users-access/screenrc',
		group => 'users',
		mode => '0644',
		require => File["/home/$usuario"]
	}

	file{ "/home/$usuario/.ssh/authorized_keys":
		ensure => present,
		content => $key_ssh,
		owner => $usuario,
		group => 'users',
		mode => '0644',
		require => File["/home/$usuario/.ssh"]
	}

	file{ "/etc/sudoers.d/$usuario":
		ensure => present,
		content => "$usuario  ALL=(ALL) NOPASSWD:ALL",
		owner => 'root',
		group => 'root',
		mode => '644'
	}
}
