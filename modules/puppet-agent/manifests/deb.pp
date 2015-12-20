class puppet-agent::deb {
	include zabbix::agent
	file { 'sources.list':
		ensure => present,
		source => "puppet:///modules/puppet-agent/$operatingsystem.list",
		path => '/etc/apt/sources.list',
		mode => 0644,
		owner => 'root',
		group => 'root'
	}
	file { 'puppet.list':
		ensure => present,
		source => "puppet:///modules/puppet-agent/puppet.$operatingsystem",
		path => '/etc/apt/sources.list.d/puppetlabs.list',
		mode => 0644,
		owner => 'root',
		group => 'root'
	}
	file { 'repository.deb':
		ensure => present,
		source => "puppet:///modules/puppet-agent/repo-$operatingsystem.deb",
		path => '/root/puppetlabs-repo.deb',
		mode => 0644,
		owner => 'root',
		group => 'root'
	}
	file { 'zabbix.list':
                ensure => present,
		source => "puppet:///modules/puppet-agent/zabbix.$operatingsystem",
                path => '/etc/apt/sources.list.d/zabbix.list',
                mode => 0644,
                owner => 'root',
                group => 'root',
                require => Exec['install-repo']
        }
	->
	exec { 'install-pkg':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'dpkg -i /root/puppetlabs-repo.deb',
		unless => 'dpkg -l puppetlabs-release'
	}
	~>
	exec { 'apt-update':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'apt-get update',
		subscribe => File['puppet.list','sources.list'],
		refreshonly => true
	}
}
