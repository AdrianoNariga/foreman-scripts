class openstack-build::rabbitmq-server{
	$pass_guest = 'password'
# pacote erlang talvez nao seja preciso
	package{ ['rabbitmq-server']:
		ensure => present,
		allow_virtual => true,
	}

# o servico rabbitmq-server nao inicia com o selinux ativo
	service{ 'rabbitmq-server':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => [
			Package['rabbitmq-server'],
			Exec['permissive-se']
		]
	}

	exec{ 'permissive-se':
		command => 'setenforce permissive',
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		unless => 'sestatus | grep permissive'
	}

	exec{ 'change_pass':
		command => "rabbitmqctl change_password guest $pass_guest ;
			    echo \"$pass_guest\" > /etc/rabbitmq/guest_pass",
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		unless => "grep $pass_guest /etc/rabbitmq/guest_pass",
		require => Service['rabbitmq-server']
	}
}
