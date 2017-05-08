class localrepo::centos::epel{
        $local_repo = '192.168.111.251'

        yumrepo { 'localepel':
                enabled  => 1,
                descr    => 'epel packages',
                baseurl  => "http://$local_repo/centos/epel",
                gpgcheck => 0,
        }

        yumrepo { 'epel'
                ensure => absent
        }
}
