class localrepo::redhat::extras{
        $local_repo = $local_repo

        yumrepo { 'localextras':
                enabled  => 1,
                descr    => 'core packages',
                baseurl  => "$local_repo/rhel-7-server-extras-rpms",
                gpgcheck => 0,
        }

}
