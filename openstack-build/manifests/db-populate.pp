class openstack-build::db-populate inherits openstack-build::mysql-server{
	db-structure{ 'keystone':
		server => $keystone,
		pass_db =>  $ps_keystone_db,
		root_pass => $root_pass
	}

	db-structure{ 'glance':
		server => $glance,
		pass_db =>  $ps_glance_db,
		root_pass => $root_pass
	}

	db-structure{ 'nova':
		server => $nova,
		pass_db =>  $ps_nova_db,
		root_pass => $root_pass
	}

	db-structure{ 'neutron':
		server => $neutron,
		pass_db =>  $ps_neutron_db,
		root_pass => $root_pass
	}

	db-structure{ 'cinder':
		server => $cinder,
		pass_db =>  $ps_cinder_db,
		root_pass => $root_pass
	}

	db-structure{ 'heat':
		server => $heat,
		pass_db =>  $ps_heat_db,
		root_pass => $root_pass
	}
}
