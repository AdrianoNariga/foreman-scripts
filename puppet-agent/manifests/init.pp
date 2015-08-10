class puppet-agent {
	$puppet_ca_server = $puppet_ca_server
	$puppetmaster = $puppetmaster
	if $operatingsystem == 'Debian' {
		include puppet-agent::debian
	}
	elsif $operatingsystem == 'Ubuntu' {
		include puppet-agent::ubuntu
	}
	elsif $operatingsystem == 'CentOS' {
		include puppet-agent::centos
	}

	package{ 'puppet':
		ensure => present,
	}
	->
	file{ 'puppet.conf':
		ensure => present,
		content => template("puppet-agent/puppet.agent.erb"),
		path => '/etc/puppet/puppet.conf',
		owner => 'root',
		group => 'root',
		mode => 0644,
	}
	~>
	service{ 'puppet':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true
	}
}
