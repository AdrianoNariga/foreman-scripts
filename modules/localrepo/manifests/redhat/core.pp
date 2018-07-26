class localrepo::redhat::core{
        $local_repo = $local_repo

        yumrepo { 'localcore':
                enabled  => 1,
                descr    => 'core packages',
                baseurl  => "$local_repo/rhel-7-server-rpms",
                gpgcheck => 0,
        }
}
