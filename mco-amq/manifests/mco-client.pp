class mco-amq::mco-client inherits mco-amq {
	if $operatingsystem == 'Debian' {
		$packages = 'mcollective-client'
	}
	elsif $operatingsystem == 'Ubuntu' {
		$packages = ['mcollective-client','mcollective-puppet-client','mcollective-filemgr-client','mcollective-iptables-client',
			     'mcollective-nettest-client','mcollective-package-client','mcollective-shell-client']
	}
	elsif $operatingsystem == 'CentOS' {
		$packages = ['mcollective-client','mcollective-puppet-client','mcollective-filemgr-client','mcollective-iptables-client',
			     'mcollective-nettest-client','mcollective-package-client','mcollective-shell-client']
	}

	package{ $packages:
		ensure => present,
		allow_virtual => true
	}

	file{ 'client.cfg':
		ensure => present,
		content => template("mco-amq/mcollective.$operatingsystem.erb"),
		path => '/etc/mcollective/client.cfg',
		owner => 'root',
		group => 'root',
		mode => '0640',
		require => Package['mcollective-client'],
	}
}
