class localrepo::redhat::openstack10{
        $local_repo = $local_repo

        yumrepo { 'localopenstack':
                enabled  => 1,
                descr    => 'openstack packages',
                baseurl  => "$local_repo/rhel-7-server-openstack-10-rpms",
                gpgcheck => 0,
        }
}
