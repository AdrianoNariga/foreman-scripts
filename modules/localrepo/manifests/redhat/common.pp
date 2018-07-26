class localrepo::redhat::common{
        $local_repo = $local_repo

        yumrepo { 'localcommon':
                enabled  => 1,
                descr    => 'common packages',
                baseurl  => "$local_repo/rhel-7-server-rh-common-rpms",
                gpgcheck => 0,
        }
}
