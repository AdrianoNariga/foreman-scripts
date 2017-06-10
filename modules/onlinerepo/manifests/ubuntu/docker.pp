class onlinerepo::ubuntu::docker{
	exec { 'key-add':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D',
		unless => 'apt-key finger | grep -q Docker'
	}
	->
	file { 'docker.list':
		ensure => present,
		mode => 0644,
                owner => 'root',
		group => 'root',
		source => "puppet:///modules/onlinerepo/docker.list",
		path => "/etc/apt/sources.list.d/docker.list",
	}
}
