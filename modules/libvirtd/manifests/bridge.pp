class libvirtd::bridge{
	$bridge = $bridge_port
	$ip = $bridge_ip
	$mask = $bridge_mask
	$gw = $default_gw
	$dns = $nameservers

	$path = '/etc/network/interfaces'
	require libvirtd::server

	file { 'iface-conf':
		ensure => present,
		content => template("libvirtd/iface.$operatingsystem.erb"),
		path => $path,
		mode => 0644,
		group => 'root',
		owner => 'root',
	}
}
