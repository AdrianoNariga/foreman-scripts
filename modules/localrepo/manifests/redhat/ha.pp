class localrepo::redhat::ha{
        $local_repo = '192.168.111.251'

        yumrepo { 'localha':
                enabled  => 1,
                descr    => 'core packages',
                baseurl  => "http://$local_repo/rhel/rhel-ha-for-rhel-7-server-rpms",
                gpgcheck => 0,
        }
}
