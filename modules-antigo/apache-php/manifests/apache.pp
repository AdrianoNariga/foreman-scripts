class apache-php::apache{
	require build-init
	if $operatingsystem == 'Debian' {
		$packages = ['php5','php5-common','php5-odbc','php5-ldap','php5-intl','php5-imagick',
			     'php5-gmp','php5-mcrypt','apache2','apache2-bin','libapache2-mod-fcgid',
			     'apache2-mpm-worker','php5-cgi','php5-curl','php5-gd','php5-mysql','php5-xsl']
		$name_service = 'apache2'
		$default_conf = '/etc/apache2/apache2.conf'
		include apache-php::administrator
		include apache-php::fcgid-enable
	}
	elsif $operatingsystem == 'Ubuntu' {
		$packages = ['php5','php5-common','php5-odbc','php5-ldap','php5-intl','php5-imagick',
			     'php5-gmp','php5-mcrypt','apache2','apache2-bin','libapache2-mod-fcgid',
			     'apache2-mpm-worker','php5-cgi','php5-curl','php5-gd','php5-mysql','php5-xsl']
		$name_service = 'apache2'
		$default_conf = '/etc/apache2/apache2.conf'
		include apache-php::administrator
		include apache-php::fcgid-enable
	}
	elsif $operatingsystem == 'CentOS' {
		require build-init::centos
		$packages = ['httpd','php','php-mbstring','php-pear','php-fpm','php-mysql','php-devel',
			     'php-gd','php-mcrypt','php-xml','php-php-gettext','mod_ldap','mod_fcgid']
		$name_service = 'httpd'
		$default_conf = "/etc/$name_service/conf/$name_service.conf"
		include apache-php::centos
	}

	package { $packages:
		ensure => present,
	}
	->
	file { 'directory-sites':
		ensure => directory,
		path => "/etc/$name_service/sites/",
		mode => '0755',
		owner => 'root',
		group => 'root',
	}
	->
	file { 'directory-clientes':
		ensure => directory,
		path => "/etc/$name_service/sites/clientes/",
		mode => '0755',
		owner => 'root',
		group => 'root',
	}
	->
	file { 'default-file-conf':
		ensure => present,
		source => "puppet:///modules/apache-php/$name_service.lasted",
		path => $default_conf,
		owner => 'root',
		group => 'root',
		notify => Service[$name_service]
	}
	->
	file { 'dominio-conf':
		ensure => present,
		source => "puppet:///modules/apache-php/dominio.conf.$operatingsystem",
		path => "/etc/$name_service/sites/clientes/dominio.conf",
		owner => 'root',
		group => 'root',
	}
	~>
	service { $name_service:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
