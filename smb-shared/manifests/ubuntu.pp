class smb-shared::ubuntu inherits smb-shared {
	if $operatingsystem == Ubuntu {
		$smb_pkgs = ['samba','samba-client','samba-common','samba-libs','samba-testsuite','samba-vfs-modules']
		$smb_services = ['smbd','nmbd']
	}
	elsif $operatingsystem == Debian {
		$smb_pkgs = ['samba','samba-common','samba-libs','samba-testsuite','samba-vfs-modules']
		$smb_services = ['smbd','nmbd']
	}

	file { 'shared_dir':
		ensure => directory,
		path => $shared_dir,
		mode => 0777,
		owner => 'root',
		group => 'users',
	}

	package { $smb_pkgs:
		ensure => present,
		allow_virtual => true
	}

	file { 'smb.conf':
		ensure => present,
		content => template("smb-shared/smb-$operatingsystem.erb"),
		path => '/etc/samba/smb.conf',
		owner => 'root',
		group => 'root',
		mode => 0644,
		require => Package[$smb_pkgs],
		notify => Service[$smb_services]
	}

	service{ $smb_services:
		ensure => running,
		hasrestart => true,
		hasstatus => true,
		enable => true,
		require => File['smb.conf']
	}
}
