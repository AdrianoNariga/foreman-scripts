class apache-php {
	$phpversion = $53_54_lasted

	file { "sources.list":
		ensure => present,
		path => '/etc/apt/sources.list',
		source => "puppet:///modules/apache-php/sources.$phpversion",
		mode => '0644',
		owner => 'root',
		group => 'root',
		notify => Exec['update'],
	}

	exec { 'update':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'aptitude update',
		subscribe => File["sources.list"],
		refreshonly => true,
	}
}
