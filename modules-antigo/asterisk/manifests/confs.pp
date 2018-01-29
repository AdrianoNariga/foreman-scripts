class asterisk-nag::confs {
	file { 'asterisk':
		ensure => directory,
		path => '/etc/asterisk',
		owner => 'asterisk',
		group => 'asterisk',
		mode => '0771',
	}

	file { 'sip.conf':
		ensure => present,
		source => 'puppet:///modules/asterisk-nag/sip.conf',
		path => '/etc/asterisk/sip.conf',
		owner => 'asterisk',
		group => 'asterisk',
		mode => '0664',
		require => File['asterisk'],
		notify => Exec['sip-reload'],
	}

	exec { 'asterisk -rx "sip reload"':
		path => '/bin:/usr/bin:/usr/sbin',
		alias => 'sip-reload',
		subscribe => File['sip.conf']
	}

	file { 'extensions.conf':
		ensure => present,
		source => 'puppet:///modules/asterisk-nag/extensions.conf',
		path => '/etc/asterisk/extensions.conf',
		owner => 'asterisk',
		group => 'asterisk',
		mode => '0664',
		require => File['asterisk'],
		notify => Exec['dial-plan']
	}

	exec { 'asterisk -rx "dialplan reload"':
		path => '/bin:/usr/bin:/usr/sbin',
		alias => 'dial-plan',
		subscribe => File['extensions.conf']
	}
}
