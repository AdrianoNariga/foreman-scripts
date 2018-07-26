class localrepo::redhat::optional{
        $local_repo = $local_repo

        yumrepo { 'localoptional':
                enabled  => 1,
                descr    => 'optional packages',
                baseurl  => "$local_repo/rhel-7-server-optional-rpms",
                gpgcheck => 0,
        }
}
