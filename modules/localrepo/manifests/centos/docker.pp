class localrepo::centos::docker{
        $local_repo = '192.168.111.251'

        yumrepo { 'localdocker':
                enabled  => 1,
                descr    => 'docker packages',
                baseurl  => "http://$local_repo/centos/dockerrepo",
                gpgcheck => 0,
        }

}
