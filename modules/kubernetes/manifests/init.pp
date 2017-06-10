class kubernetes{

	$packages = ['kubelet','kubeadm'.'kubernetes-cni']
	package { $packages:
		ensure => present,
	}
}
