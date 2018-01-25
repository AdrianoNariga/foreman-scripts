class integrated-squid::samba inherits integrated-squid {
	file{ 'smb.conf':
		ensure => present,
		content => template("integrated-squid/smb.conf.erb"),
		path => '/etc/samba/smb.conf',
		mode => 0644,
		owner => 'root',
		group => 'root',
		require => Package[$packages]
	}
	~>
	exec { 'join-host':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => "net ads join -U $adm_domain%\'$adm_password\'",
		unless => 'wbinfo -u | grep administrator'
	}
	~>
	service { ['smbd','nmbd','winbind']:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
