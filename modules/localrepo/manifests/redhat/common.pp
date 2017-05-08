class repo-offline::redhat::common{
        $local_repo = '192.168.111.251'

        yumrepo { 'localcommon':
                enabled  => 1,
                descr    => 'common packages',
                baseurl  => "http://$local_repo/rhel/rhel-7-server-rh-common-rpms",
                gpgcheck => 0,
        }
}
