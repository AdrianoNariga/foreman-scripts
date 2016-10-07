class repo-offline::centos::puppet{
	repo-offline{ 'puppetlabs-deps':
		local_path => 'puppetlabs-deps',
	}

	repo-offline{ 'puppetlabs-products':
		local_path => 'puppetlabs-products',
	}
}
