class mco-amq::mco-server inherits mco-amq {
	require puppet-agent

	if $operatingsystem == 'Debian' {
		$packages = ['mcollective','mcollective-puppet-agent','mcollective-filemgr-agent','mcollective-iptables-agent',
			'mcollective-nettest-agent','mcollective-package-agent','mcollective-shell-agent']
	}
	elsif $operatingsystem == 'Ubuntu' {
		if $operatingsystemrelease == '14.04' {
			$packages = ['mcollective','mcollective-puppet-agent','mcollective-filemgr-agent','mcollective-iptables-agent',
			'mcollective-nettest-agent','mcollective-package-agent','mcollective-shell-agent']
		}
		elsif $operatingsystemrelease == '15.10' or $operatingsystemrelease == '16.04' {
			$packages = ['mcollective','mcollective-plugins-puppetd','mcollective-plugins-filemgr',
			'mcollective-plugins-iptables','mcollective-plugins-nettest','mcollective-plugins-package']	
		}
	}
	elsif $operatingsystem == 'CentOS' {
		$packages = ['mcollective','mcollective-puppet-agent','mcollective-filemgr-agent','mcollective-iptables-agent',
			'mcollective-nettest-agent','mcollective-package-agent','mcollective-shell-agent']
	}
	elsif $operatingsystem == 'RedHat' {
		$packages = ['mcollective','mcollective-puppet-agent','mcollective-filemgr-agent','mcollective-iptables-agent',
			'mcollective-nettest-agent','mcollective-package-agent','mcollective-shell-agent']
	}

	package{ $packages:
		ensure => present,
		allow_virtual => true
	}

	file{ 'server.cfg':
		ensure => present,
		content => template("mco-amq/mcollective.$operatingsystem.erb"),
		path => '/etc/mcollective/server.cfg',
		owner => 'root',
		group => 'root',
		mode => '0640',
		require => Package[$packages],
		notify => Service['mcollective']
	}

	service{ 'mcollective':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => [
			File['server.cfg'],
			Package[$packages]
		]
	}
}
