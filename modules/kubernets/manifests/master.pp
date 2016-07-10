class kubernets::master{
	$pkgs = ['kubernetes','flannel','etcd']
	$services = ['etcd','kube-apiserver','kube-controller-manager','kube-scheduler']
	package { $pkgs:
		ensure => present,
		allow_virtual => true
	}
	->
        file{ 'config':
                ensure => present,
                content => template("kubernets/config.erb"),
                path => '/etc/kubernetes/config',
                mode => '0644',
                owner => 'root',
                group => 'root',
		notify => Service[$services]
        }
	->
        file{ 'apiserver':
                ensure => present,
                content => template("kubernets/apiserver.erb"),
                path => '/etc/kubernetes/apiserver',
                mode => '0644',
                owner => 'root',
                group => 'root',
		notify => Service[$services]
        }
	->
        file{ 'etcd.conf':
                ensure => present,
                content => template("kubernets/etcd.conf.erb"),
                path => '/etc/etcd/etcd.conf',
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
	->
        file{ 'flannel-config.json':
                ensure => present,
                content => template("kubernets/flannel-config.json.erb"),
                path => '/etc/etcd/flannel-config.json',
                mode => '0644',
                owner => 'root',
                group => 'root',
        }
	~>
	exec{ 'etcd-net':
		path => '/usr/bin:/usr/sbin:/bin:/sbin',
		command => "etcdctl set /atomic.io/network/config < /etc/etcd/flannel-config.json",
		subscribe => File['flannel-config.json'],
		refreshonly => true
	}
}
