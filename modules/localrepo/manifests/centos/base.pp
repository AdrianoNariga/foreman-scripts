class localrepo::centos::base{
	$local_repo = '192.168.111.251'

	yumrepo { 'localbase':
		enabled  => 1,
		descr    => 'base packages',
		baseurl  => "http://$local_repo/centos/base",
		gpgcheck => 0,
	}

}
