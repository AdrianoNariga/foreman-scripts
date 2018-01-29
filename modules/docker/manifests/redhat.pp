class docker::redhat {
	$packages = 'docker'

	exec { 'add-repo':
                path => '/bin:/usr/bin',
		command => 'subscription-manager repos --enable=rhel-7-server-extras-rpms',
                unless => 'yum repolist | grep server-extras-rpms',
	}
}
