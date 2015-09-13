class puppet-agent::deb {
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
		subscribe => File['puppet.list'],
		refreshonly => true
	}
}
