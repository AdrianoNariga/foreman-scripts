class apache-php::fcgid-enable inherits apache-php::apache-lasted{
	exec { 'fcgid-enable':
		path => '/bin:/sbin:/usr/bin:/usr/sbin',
		command => 'a2enmod fcgid',
		unless => 'ls -l /etc/apache2/mods-enabled/ | grep fcgid',
		require => Package[$packages]
	}
}
