class docker::swarm inherits docker{
	service{'firewalld':
		ensure   => stopped,
		provider => 'systemd',
	}

        exec{ 'docker_init':
                path => '/usr/bin:/usr/sbin:/bin:/sbin',
                command => "docker swarm init > /root/swarm",
                unless => "docker node ls",
        }
}
