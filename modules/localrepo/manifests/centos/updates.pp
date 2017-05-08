class localrepo::centos::updates{
        $local_repo = '192.168.111.251'

        yumrepo { 'localupdates':
                enabled  => 1,
                descr    => 'updates packages',
                baseurl  => "http://$local_repo/centos/updates",
                gpgcheck => 0,
        }

        yumrepo { 'updates':
                ensure => absent
        }
}
