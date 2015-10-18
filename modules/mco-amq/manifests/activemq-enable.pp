class mco-amq::activemq-enable {        
	exec { 'enable-instance':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'ln -s /etc/activemq/instances-available/main /etc/activemq/instances-enabled/main',
		unless => "ls /etc/activemq/instances-enabled/main/activemq.xml",
		require => Package['activemq']
	}
}
