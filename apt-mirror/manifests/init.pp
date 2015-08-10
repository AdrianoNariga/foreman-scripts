class apt-mirror {
	$path_mirror = $path_mirror
	package{ ['apt-mirror','apache2']:
		ensure => present,
		allow_virtual => true
	}

	file{ 'mirror-list':
		ensure => present,
		content => template('apt-mirror/mirror.list.erb'),
		path => '/etc/apt/mirror.list',
		mode => '0644',
		owner => 'root',
		group => 'root'
	}
}
