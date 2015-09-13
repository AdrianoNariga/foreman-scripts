class local-mirror::client inherits local-mirror {
	centos_repo{ ['base','extras','updates','centosplus','epel','puppetlabs-deps','puppetlabs-products']:
		repo_ip => '192.168.111.5'
	}
	rm_repo{ ['extra-homejab','puppet-deps-homejab','puppet-homejab','puppetlabs',
		  'update-homejab','CentOS-Base','CentOS-CR','CentOS-Debuginfo','CentOS-fasttrack',
		  'CentOS-Sources','CentOS-Vault','epel-testing']: }

	file { '/etc/yum.repos.d/epel.repo':
		ensure => absent,
	}
}
