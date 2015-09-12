class asterisk-nag::repo-centos {
	package { 'dnsmasq':
		ensure => present,
		allow_virtual => 'true'
	}

	file { 'asterisknow-version-3.0.1-2_centos6.noarch.rpm':
		ensure => present,
		source => 'puppet:///modules/asterisk-nag/asterisknow-version-3.0.1-2_centos6.noarch.rpm',
		path => '/root/asterisknow-version-3.0.1-2_centos6.noarch.rpm',
		owner => 'root',
		group => 'root',
		mode => '0644',
		alias => 'rpm-repo',
		require => Package['dnsmasq']
	}

	exec { 'rpm -Uvh /root/asterisknow-version-3.0.1-2_centos6.noarch.rpm':
		alias => 'repo-install',
		path => '/bin/:/usr/bin',
		unless => 'rpm -q asterisknow-version-3.0.1-2_centos6.noarch',
		require => File['rpm-repo']
	}

	package { ['asterisk','asterisk-configs']:
		ensure => present,
		install_options => ['--enablerepo=asterisk-11'],
		allow_virtual => 'true',
		require => Exec['repo-install']
	}

	package { ['dahdi-linux','dahdi-tools','libpri']:
		ensure => present,
		allow_virtual => 'true',
		require => Package['asterisk-configs']
	}

	service { 'asterisk':
		ensure => running,
		enable => 'true',
		hasrestart => 'true',
		hasstatus => 'true',
		require => Package['dahdi-tools']
	}
}
