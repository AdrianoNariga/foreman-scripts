class libvirt-kvm::foreman {
	$storage_path = $storage_path
	$key_ssh = $foreman_key
	$user = 'foreman'
	if $operatingsystem == 'Debian' {
		$group = 'libvirt'
        } else{
		$group = 'libvirtd'
	}
	user { $user:
		ensure           => 'present',
		gid              => $group,
		home             => "/home/$user",
		managehome => true,
		password         => '!!',
		password_max_age => '99999',
		password_min_age => '0',
		shell            => '/bin/bash',
	}
	->
	file{ "/home/$user":
		ensure => directory,
		owner => $user,
		group => $group,
		mode => 0750,
	}
	->	
	file{ "/home/$user/.ssh":
		ensure => directory,
		owner => $user,
		group => 'users',
		mode => '0700',
	}
	->
	file{ "/home/$user/.ssh/authorized_keys":
		ensure => present,
		content => $key_ssh,
		owner => $user,
		group => 'users',
		mode => '0644',
	}
	->
	file{ $storage_path:
		ensure => directory,
		owner => 'root',
		group => 'root',
		mode => '0755',
	}
	->
	file{ ["$storage_path/templates","$storage_path/disks","$storage_path/isos"]:
		ensure => directory,
		owner => 'root',
		group => 'root',
		mode => '0755',
	}
}
