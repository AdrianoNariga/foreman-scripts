class puppet-agent::rpm {

#	define rm_repo($repo = $title){
#		file { $repo:
#			ensure => absent,
#			path => "/etc/yum.repos.d/$repo-homejab.repo",
#		}
#	}

#	rm_repo{ [['base','extras','updates','centosplus','epel','puppetlabs-deps','puppetlabs-products']:]:
	
	exec { 'puppetlabs-repo':
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		command => 'rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm',
		unless => 'yum repolist | grep puppetlabs'
	}

}
