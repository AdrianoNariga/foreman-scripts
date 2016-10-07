class puppet-agent {
	$puppet_ca_server = $puppet_ca_server
	$puppetmaster = $puppetmaster

	package{ 'puppet':
		ensure => present,
		allow_virtual => true
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
