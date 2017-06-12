class kubernetes{

	$packages = ['kubelet','kubeadm','kubernetes-cni']
	package { $packages:
		ensure => present,
	}

        exec{ 'se_permissive':
                path => '/usr/bin:/usr/sbin:/bin:/sbin',
                command => "setenforce permissive",
                unless => "getenforce | grep -i ermissive",
        }
}
