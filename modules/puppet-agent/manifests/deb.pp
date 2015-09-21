class puppet-agent::deb {
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
	->
	exec { 'install-pkg':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'dpkg -i /root/puppetlabs-repo.deb',
		unless => 'dpkg -l puppetlabs-release'
	}
	~>
	exec { 'apt-update':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'aptitude update',
		subscribe => File['puppet.list','sources.list'],
		refreshonly => true
	}
}