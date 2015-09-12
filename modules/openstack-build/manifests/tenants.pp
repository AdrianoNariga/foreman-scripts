class openstack-build::tenants inherits openstack-build::keystone{
	$controller = $controller

	createProject{ 'admin':
		description => 'Admin Project',
		require => Service['openstack-keystone']
	}
	createProject{ 'service':
		description => 'Service Project',
		require => [
			Service['openstack-keystone'],
			CreateProject['admin']
		]
	}

	serviceProject{ 'admin':
		pass => $admin_password,
		service => 'keystone',
		type => 'identity',
		description => 'OpenStack Identity',
		require => [
			Service['openstack-keystone'],
			CreateProject['service']
		]
	}
	serviceProject{ 'glance':
		project => 'service',
		pass => $admin_password,
		service => 'glance',
		type => 'image',
		description => 'OpenStack Imagem',
		require => [
			Service['openstack-keystone'],
			ServiceProject['admin']
		]
	}

	addRule{ 'admin':
		require => [
			Service['openstack-keystone'],
			ServiceProject['admin']
		]
	}

	addRule{ 'Member':
		require => [
			Service['openstack-keystone'],
			ServiceProject['glance']
		]
	}

	createEndpoint{ 'identity':
		server => $controller,
		public => '5000',
		internal => '5000',
		admin => '35357',
		require => [
			Service['openstack-keystone'],
			AddRule['Member']
		]
	}

	createEndpoint{ 'image':
		server => $controller,
		public => '9292',
		internal => '9292',
		admin => '9292',
		require => [
			Service['openstack-keystone'],
			CreateEndpoint['identity']
		]
	}
}
