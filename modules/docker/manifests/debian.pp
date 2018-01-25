class docker::debian {
	$dependencies = [ 'apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common','gnupg2' ]
	$packages = 'docker-ce'
	$key = '0EBFCD88'

        package { $dependencies: ensure => present }
        ->
	file { 'docker.list':
  		path => '/etc/apt/sources.list.d/docker.list',
		content => "deb [arch=amd64] https://download.docker.com/linux/debian jessie stable"
	}
        ->
	exec { 'apt-key docker':
		path    => '/bin:/usr/bin',
		unless  => "apt-key list | grep Docker",
		command => "curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -",
	}
        ->
	exec { 'apt-get-update':
		command => '/usr/bin/apt-get update',
		subscribe => File['docker.list'],
		refreshonly => true
	}
}
