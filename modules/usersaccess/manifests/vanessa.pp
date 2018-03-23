class usersaccess::vanessa {
	$key_ssh = $vanessa_ssh_keys
	$usuario = 'vanessa'

	user { $usuario:
		ensure => present,
		gid => 'vanessa',
		groups => ['netdev'],
		home => "/home/$usuario",
		managehome => true,
		uid => 1002,
		shell => '/bin/bash',
		comment => 'Vanessa Santos',
		password => '$1$LvVBgnce$XCM6TqqeG6SUl5QK0MvN2.',
		password_max_age => '99999',
		password_min_age => '0',
	}

	file{ "/home/$usuario":
		ensure => directory,
		owner => $usuario,
		group => 'users',
		mode => '0750',
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
		source => 'puppet:///modules/usersaccess/screenrc',
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
}
