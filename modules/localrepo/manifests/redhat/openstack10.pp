class localrepo::redhat::openstack10{
        $local_repo = '192.168.111.251'

        yumrepo { 'localopenstack':
                enabled  => 1,
                descr    => 'openstack packages',
                baseurl  => "http://$local_repo/rhel/rhel-7-server-openstack-10-rpms",
                gpgcheck => 0,
        }
}
