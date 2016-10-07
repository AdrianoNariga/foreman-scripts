class repo-offline {
	define repo-offline($repo = $title, $local_path, $local_repo = '192.168.111.5'){
                file{ $repo:
                        ensure => present,
                        mode => 0644,
                        owner => 'root',
                        group => 'root',
                        content => template("repo-offline/$operatingsystem.erp"),
                        path => "/etc/yum.repos.d/$repo.repo",
                }
        }

}
