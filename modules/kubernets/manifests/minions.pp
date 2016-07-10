class kubernets::minions{
	$pkgs = ['kubernetes','flannel']
	$services = ['kube-proxy','kubelet','docker','flanneld']
	$k8s_master = $k8s_master

	host { $fqdn:
		ip => $ipaddress_eth0,
		host_aliases => $hostname,
	}

	package { $pkgs:
		ensure => present,
	}
	->
	file{ 'config':
		ensure => present,
		content => template("kubernets/minion-config.erb"),
		path => '/etc/kubernetes/config',
		mode => '0644',
		owner => 'root',
		group => 'root',
		notify => Service[$services]
	}
	->
	file{ 'kubelet':
		ensure => present,
		content => template("kubernets/kubelet.erb"),
		path => '/etc/kubernetes/kubelet',
		mode => '0644',
		owner => 'root',
		group => 'root',
		notify => Service[$services]
	}
	->
	file{ 'flanneld':
		ensure => present,
		content => template("kubernets/flanneld.erb"),
		path => '/etc/sysconfig/flanneld',
		mode => '0644',
		owner => 'root',
		group => 'root',
	}
	~>
	service{ $services:
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
	}
}
