class localrepo::centos::extras{
        $local_repo = '192.168.111.251'

        yumrepo { 'localextras':
                enabled  => 1,
                descr    => 'extras packages',
                baseurl  => "http://$local_repo/centos/extras",
                gpgcheck => 0,
        }
}
