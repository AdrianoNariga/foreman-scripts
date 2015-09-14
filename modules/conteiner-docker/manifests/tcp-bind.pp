class conteiner-docker::tcp-bind inherits conteiner-docker{
	if $operatingsystem == 'Debian' {
		$path_conf = '/etc/default/docker'
	}
	elsif $operatingsystem == 'Ubuntu' {
	}
	elsif $operatingsystem == 'CentOS' {
		$path_conf = '/etc/sysconfig/docker'
	}
	file { 'docker':
		ensure => present,
		source => "puppet:///modules/conteiner-docker/conf-$operatingsystem",
		path => $path_conf,
		mode => 0644,
		owner => 'root',
		group => 'root',
		require => Package[$packages],
		notify => Service['docker']
	}
}
