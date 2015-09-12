class apache-php::phpinfo {
	file { 'phpinfo':
		ensure => present,
		source => 'puppet:///modules/apache-php/phpinfo.php',
		path => '/home/administrator/htdocs/phpinfo.php',
		owner => 'administrator',
		group => 'administrator',
		mode => '0644',
	}
}
