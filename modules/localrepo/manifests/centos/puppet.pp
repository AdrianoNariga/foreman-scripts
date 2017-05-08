class localrepo::centos::puppet{
        $local_repo = '192.168.111.251'

        yumrepo { 'localpuppet':
                enabled  => 1,
                descr    => 'puppet packages',
                baseurl  => "http://$local_repo/centos/puppetlabs-pc1",
                gpgcheck => 0,
        }
}
