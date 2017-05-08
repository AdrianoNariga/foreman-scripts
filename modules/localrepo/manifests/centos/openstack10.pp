class localrepo::centos::openstack10{
        $local_repo = '192.168.111.251'

        yumrepo { 'localopenstack':
                enabled  => 1,
                descr    => 'openstack packages',
                baseurl  => "http://$local_repo/centos/centos-openstack-newton",
                gpgcheck => 0,
        }

        yumrepo { 'centos-openstack-newton':
                ensure => absent
        }
}
