class kubernetes::master{

        exec{ 'kube_adm':
                path => '/usr/bin:/usr/sbin:/bin:/sbin',
                command => "kubeadm init",
                unless => "getenforce | grep -i ermissive",
        }
}
