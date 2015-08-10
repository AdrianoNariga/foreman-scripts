class mini-dlna {
	$path_midias = $path_midias
	$name_server = $name_server
	package{ 'minidlna':
		ensure => present
	}
	->
	file{ '/var/log/minidlna':
		ensure => directory
	}
	->
	file{ 'force_scan':
		ensure => present,
		content => "sysctl fs.inotify.max_user_watches=66538",
		path => '/root/script',
		mode => 0744,
		owner => 'root',
		group => 'root',	
	}
	->
	file{ 'conf':
		ensure => present,
		content => template("mini-dlna/minidlna.conf.erb"),
		path => '/etc/minidlna.conf',
		mode => '0644',
		owner => 'root',
		group => 'root',
	}
	~>
	service{ 'minidlna':
		ensure => running,
	}
}
