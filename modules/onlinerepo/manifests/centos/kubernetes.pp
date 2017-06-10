class onlinerepo::centos::kubernetes{
        yumrepo { 'kubernetes':
                enabled  => 1,
                descr    => 'Kubernetes',
                baseurl  => "https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64",
                gpgcheck => 0,
        }
}
