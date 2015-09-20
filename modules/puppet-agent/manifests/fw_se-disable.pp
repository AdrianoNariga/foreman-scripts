class puppet-agent::fw_se-disable {
	exec{ 'selinux-disable':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'setenforce permissive',
		unless => "sestatus | grep \'Current mode\' | grep permissive"
	}
	->
	file { 'selinux.config':
		ensure => present,
		source => 'puppet:///modules/puppet-agent/selinux.config',
		path => '/etc/selinux/config',
		mode => 0644,
		owner => 'root',
		group => 'root'
	}
	->
	service { 'firewalld':
		ensure => stopped,
		enable => false,
		hasstatus => true,
	}
}
