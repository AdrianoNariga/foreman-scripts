class localrepo::redhat::core{
        $local_repo = '192.168.111.251'

        yumrepo { 'localcore':
                enabled  => 1,
                descr    => 'core packages',
                baseurl  => "http://$local_repo/rhel/rhel-7-server-rpms",
                gpgcheck => 0,
        }
}
