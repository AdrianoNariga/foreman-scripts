class localrepo::redhat::extras{
        $local_repo = '192.168.111.251'

        yumrepo { 'localextras':
                enabled  => 1,
                descr    => 'core packages',
                baseurl  => "http://$local_repo/rhel/rhel-7-server-extras-rpms",
                gpgcheck => 0,
        }

}
