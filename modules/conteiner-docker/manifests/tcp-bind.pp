class conteiner-docker::tcp-bind inherits conteiner-docker{
	file { 'docker':
		ensure => present,
		source => "puppet:///modules/conteiner-docker/conf-$operatingsystem",
		path => "/etc/sysconfig/docker",
		mode => 0644,
		owner => 'root',
		group => 'root',
		require => Package[$packages],
		notify => Service['docker']
	}
}
