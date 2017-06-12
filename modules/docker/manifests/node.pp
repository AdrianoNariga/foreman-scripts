class docker::node inherits docker{
	$swarm_token = $swarm_token
	$swarm_master = $swarm_master
        exec{ 'docker_node':
                path => '/usr/bin:/usr/sbin:/bin:/sbin',
                command => "docker swarm join --token $swarm_token $swarm_master:2377 > /root/swarm_status",
                unless => 'grep "This node joined" /root/swarm_status',
        }
}
