class docker::centos {
	$dependencies = [ 'yum-utils','device-mapper-persistent-data','lvm2' ]
	$packages = 'docker-ce'

        package { $dependencies: ensure => present }
        ->
	exec { 'add-repo':
                path => '/bin:/usr/bin',
		command => 'yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo',
		subscribe => Package[ $dependencies ],
		refreshonly => true
	}
}
