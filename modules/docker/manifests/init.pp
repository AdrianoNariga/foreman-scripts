class docker {
	if $operatingsystem == 'Debian' {
		$packages = 'docker-engine'
	}
	elsif $operatingsystem == 'Ubuntu' {
		$dependencies = [ 'apt-transport-https', 'ca-certificates', 'curl', 'software-properties-common' ]
		$packages = 'docker-ce'
	}
	elsif $operatingsystem == 'CentOS' {
		$packages = 'docker-engine'
	}

	exec { 'apt-key docker':
		path    => '/bin:/usr/bin',
		unless  => "apt-key list | grep '${key}' | grep -v expired",
		command => 'add-apt-repository \
   		    \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   		    $(lsb_release -cs) stable\"',
	}
	->
	$key = '0EBFCD88'
	exec { 'apt-key docker':
		path    => '/bin:/usr/bin',
		unless  => "apt-key list | grep '${key}' | grep -v expired",
		command => "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && apt-key fingerprint ${key}",
	}
	->	
	package { $dependencies: ensure => present }
	->
	package { $packages: ensure => present }
	->
	service { 'docker':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
