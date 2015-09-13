class puppet-agent {
	$puppet_ca_server = $puppet_ca_server
	$puppetmaster = $puppetmaster
	$enable_local_repo = $enable_local_repo
	if $operatingsystem == 'Debian' {
		if $lsbdistid != 'elementary OS' {
			if $enable_local_repo == 'yes'{
				include local-mirror::client-deb
			}
			else { include puppet-agent::deb }
		}
	}
	elsif $operatingsystem == 'Ubuntu' {
		if $enable_local_repo == 'yes'{
			include local-mirror::client-deb
		}
		else { include puppet-agent::deb }
	}
	elsif $operatingsystem == 'CentOS' {
		if $enable_local_repo == 'yes'{
			include local-mirror::client-rpm
		}
		else { include puppet-agent::rpm }
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
