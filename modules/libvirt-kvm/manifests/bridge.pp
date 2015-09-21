class libvirt-kvm::bridge{
	$bridge = $bridge_port
	require libvirt-kvm::server

	file { 'iface-conf':
		content => template("libvirt-kvm/iface.$operatingsystem.erb"),
		path => $path,
		mode => 0644,
		group => 'root',
		user => 'root',
	}
}
