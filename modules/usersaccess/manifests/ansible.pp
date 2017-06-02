class usersaccess::ansible {
	$key_ssh = $key_ssh
	$usuario = 'ansible'

	user { $usuario:
		ensure => present,
		gid => 'users',
		home => "/home/$usuario",
		managehome => true,
		uid => 1002,
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
		mode => '0644'
	}
}
