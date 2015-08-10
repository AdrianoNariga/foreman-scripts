class openstack-build::keystone inherits openstack-build{
	$admin_token = $admin_token
	$packages = ['openstack-keystone','openstack-utils','python-openstackclient',]

	package{ $packages:
		ensure => present,
		allow_virtual => true,
		require => Exec['install-repo-rdo']
	}

	file{ 'keystone.conf':
		ensure => present,
		content => template("openstack-build/keystone.conf.erb"),
		path => '/etc/keystone/keystone.conf',
		mode => '0640',
		owner => 'root',
		group => 'keystone',
		require => Package[$packages]
	}

	exec{ 'gen-keys':
		command => 'keystone-manage pki_setup --keystone-user keystone --keystone-group keystone ;
			    rm /var/log/keystone/keystone.log',
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		unless => 'ls /etc/keystone/ssl/certs/signing_cert.pem',
		require => [
			File['keystone.conf'],
			Package[$packages]
		]
	}

	exec{ 'populate-db':
		command => 'keystone-manage db_sync',
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		unless => "mysql -u keystone -h $db_host -p$ps_keystone_db keystone -e \"select * from domain;\"",
		require => [
			Exec['gen-keys'],
			File['keystone.conf']
		]
	}

	file{ 'keystone.log':
		ensure => present,
		path => '/var/log/keystone/keystone.log',
		owner => 'root',
		group => 'keystone',
		mode => 0665,
		require => [
			Package[$packages],
			Exec['populate-db']
		]
	}

	service{ 'openstack-keystone':
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => [
			File['keystone.conf','keystone.log'],
			Exec['gen-keys']
		]
	}
}
