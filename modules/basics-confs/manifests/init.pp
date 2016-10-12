class basics-confs {
        if $operatingsystem == 'Debian' {
		$packages = ['screen','git','vim']
        }
        elsif $operatingsystem == 'Ubuntu' {
		$packages = ['screen','git','vim']
        }
        elsif $operatingsystem == 'CentOS' {
		$packages = ['screen','git','vim-enhanced','telnet']
        }

	package { $packages:
		ensure => present,
	}
}
