class zabbix {
	$db_host = $db_host
	$db_pass = $pass_postgres
	$pass_db_zbb = $zabbix_pass
	$us_zbb	= $zabbix_user
	$db_zbb = $zabbix_db
	$zabbix_version = $zabbix_version
	case $operatingsystem {
		Debian: { }
		CentOS: {
			include zabbix::centos-psql
		}
		Ubuntu: { }
		OpenSuSE: { }
		default: { }
	}
}
