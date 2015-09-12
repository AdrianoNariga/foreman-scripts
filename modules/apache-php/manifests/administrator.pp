class apache-php::administrator {
	file { 'administrator':
		ensure => directory,
		path => '/home/administrator',
		mode => '0755',
		owner => 'administrator',
		group => 'administrator',
	}
	->
	file { 'log-sites':
		ensure => directory,
		path => '/home/administrator/logs',
		mode => '0755',
		owner => 'administrator',
		group => 'administrator',
	}
	->
	file { 'htdocs-sites':
		ensure => directory,
		path => '/home/administrator/htdocs',
		mode => '0755',
		owner => 'administrator',
		group => 'administrator',
	}
}
