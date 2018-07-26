class localrepo::redhat::ha{
        $local_repo = $local_repo

        yumrepo { 'localha':
                enabled  => 1,
                descr    => 'core packages',
                baseurl  => "$local_repo/rhel-ha-for-rhel-7-server-rpms",
                gpgcheck => 0,
        }
}
