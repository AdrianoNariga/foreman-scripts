class localrepo::redhat::optional{
        $local_repo = '192.168.111.251'

        yumrepo { 'localoptional':
                enabled  => 1,
                descr    => 'optional packages',
                baseurl  => "http://$local_repo/rhel/rhel-7-server-optional-rpms",
                gpgcheck => 0,
        }
}
