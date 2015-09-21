class libvirt-kvm::bridge{
	$bridge = $bridge_port
	$ip = $bridge_ip
	$mask = $bridge_mask
	$gw = $default_gw
	$dns = $nameservers

	$path = '/etc/network/interfaces'
	require libvirt-kvm::server

	file { 'iface-conf':
		ensure => present,
		content => template("libvirt-kvm/iface.$operatingsystem.erb"),
		path => $path,
		mode => 0644,
		group => 'root',
		owner => 'root',
	}
}
