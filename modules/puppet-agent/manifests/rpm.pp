class puppet-agent::rpm {
	exec { 'puppetlabs-repo':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm',
		unless => 'yum repolist | grep puppetlabs'
	}
}
