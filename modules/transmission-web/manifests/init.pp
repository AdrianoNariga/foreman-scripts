class transmission-web {
	$pkgs = ['transmission-cli','transmission-common','transmission-daemon']
	$completes = $completes
	$downloads = $downloads
	package{ $pkgs:
		ensure => present,
		allow_virtual => true,
	}

	file{ [$completes,$downloads]:
		ensure => directory,
		owner => 'debian-transmission',
		group => 'debian-transmission',
		mode => 0755,
	}

	file{ ['/home/debian-transmission',
	       '/home/debian-transmission/.config',
	       '/home/debian-transmission/.config/transmission-daemon']:
		ensure => directory,
		owner => 'debian-transmission',
		group => 'debian-transmission',
		mode => 0755,
		force => true,
		recurse => true,
		require => Package[$pkgs]
	}

	file{ 'conf-transmission':
		ensure => present,
		content => template("transmission-web/settings.json.erb"),
		path => "/etc/transmission-daemon/settings.json",
		owner => 'debian-transmission',
		group => 'debian-transmission',
		mode => 0600,
#		notify => Service['transmission-daemon'],
		require => [
			Package[$pkgs],
			File[$completes,$downloads,
			"/home/debian-transmission/.config/transmission-daemon"]
		]
	}

#	service { 'transmission-daemon':
#		ensure => stopped,
#		enable => true,
#		hasrestart => true,
#		hasstatus => true,
#		require => File['conf-transmission']
#	}
}
