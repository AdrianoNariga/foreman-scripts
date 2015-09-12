class integrated-squid::kerberos inherits integrated-squid {
	file{ 'krb5.conf':
		ensure => present,
		content => template("integrated-squid/krb5.conf.erb"),
		path => '/etc/krb5.conf',
		mode => 0644,
		owner => 'root',
		group => 'root',
		require => Package[$packages]
	}
}
