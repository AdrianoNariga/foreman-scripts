class apache-php::centos {
	require apache-php::administrator
	file { 'cgi-bin':
		ensure => directory,
		source => 'puppet:///modules/apache-php/cgi-bin',
		path => '/home/administrator/cgi-bin',
		recurse => true,
		mode => '0755',
		owner => 'administrator',
		group => 'administrator',
	}
}
