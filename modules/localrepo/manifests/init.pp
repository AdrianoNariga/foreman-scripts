class localrepo {
#	define localrepo($repo = $title, $local_path, $local_repo = '192.168.111.251'){
#                file{ $repo:
#                        ensure => present,
#                        mode => 0644,
#                        owner => 'root',
#                        group => 'root',
#                        content => template("localrepo/$operatingsystem.erp"),
#                        path => "/etc/yum.repos.d/$repo.repo",
#                }
#        }
#
}
