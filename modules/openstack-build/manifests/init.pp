class openstack-build {
	$version = 'kilo'
	file{ 'repository':
		ensure => present,
		source => "puppet:///modules/openstack-build/rdo-release-$version.rpm",
		path => "/root/rdo-release-$version.rpm",
		mode => '0644',
		owner => 'root',
		group => 'root',
	}

	exec{ 'install-repo-rdo':
		command => "yum install -y /root/rdo-release-$version.rpm",
		path => '/bin:/usr/bin:/sbin:/usr/sbin',
		unless => "yum repolist | grep openstack-$version",
		require => File['repository']
	}

	package{ 'mariadb':
		ensure => present
	}
### mysql database and user

	define db-structure($server, $name_db = $title, $user_db = $title, $pass_db, $root_pass){
		Class['openstack-build::mysql-server'] -> Db-structure[$title]

		exec{ "$title-database":
			unless => "mysql -u root -p$root_pass -e \"show databases;\" | grep $name_db",
			command => "mysql -u root -p$root_pass -e \"create database $name_db;\"",
			path => '/usr/bin:/usr/sbin:/bin:/sbin',
		}

		exec{ "$title-user":
			unless => "mysql -u root -p$root_pass $name_db -e \"SHOW GRANTS FOR '$user_db'@'$server'\"",
			command => "mysql -u root -p$root_pass -e \
				   \"grant all privileges on $name_db.* to $user_db@\'$server\' identified by \'$pass_db\';
		  	   	flush privileges;\"",
			path => '/usr/bin:/usr/sbin:/bin:/sbin',
			require => Exec["$title-database"],
		}
	}

### estrutura de serviços openstack 
	$db_host = $ip_mysql
	$admin_password = 'csdrwerwqwe'

	$keystone = $keystone
	$ps_keystone_db = $keystone_pass
	$glance = $glance
	$ps_glance_db = $glance_pass
	$nova = $nova
	$ps_nova_db = $nova_pass
	$neutron = $neutron
	$ps_neutron_db = $neutron_pass
	$cinder = $cinder
	$ps_cinder_db = $cinder_pass
	$heat = $heat
	$ps_heat_db = $heat_pass
	define serviceProject($project = $title, $user = $title, $pass, $service, $type, $description = $title){
		$enviroment = ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"]
		$path = '/bin:/usr/bin:/sbin:/usr/sbin'

		exec{ "$title-projectUser":
			environment => $enviroment,
			path => $path,
			command => "openstack user create --project $project --password $pass $user",
			unless => "openstack user list | grep $user"
		}

		exec{ "$title-ruleUser":
			environment => $enviroment,
			path => $path,
			command => "openstack role add --project $project --user $user admin",
			unless => "openstack role list --user $user --project $project",
			require => Exec["$title-projectUser"]
		}

		exec{ "$title-service":
			environment => $enviroment,
			path => $path,
			command => "openstack service create --name $user --description \"$description\" $type",
			unless => "openstack service list | grep $user",
			require => Exec["$title-ruleUser"]
		}
	}
### estrutura de serviços openstack
### criação de usuarios separados
	define userProject($project, $pass, $user){
		exec{ "$title-projectUser":
			environment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack user create --project $project --password $pass $user",
			unless => "openstack user list | grep $user"
		}

	}
### criação de rules separado
	define userRule($project, $user){
		exec{ "$title-userRule":
			environment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack role add --project $project --user $user admin",
			unless => "openstack role list | grep $user"
		}

	}
### adição de rules
	define addRule($ruleName = $title){
		exec{ "$title-rule":
			environment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack role create $ruleName",
			unless => "openstack role list | grep $ruleName"
		}
	}
### criação de serviços
	define serviceCreate($service = $title, $description, $type){
		exec{ "$title-service":
			environment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack service create --name $service --description \"$description\" $type",
			unless => "openstack service list | grep $service",
		}
	}
### criação de projetos
	define createProject($projectName = $title, $description){
		exec{ "$title-project":
			environment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack project create --description \"$description\" $projectName",
			unless => "openstack project list | grep $projectName"
		}
	}
### criação de endpoint
	define createEndpoint($server, $api = $title, $public, $internal, $admin){
		exec{ "$title-endpoint":
			environment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack endpoint create --publicurl http://$server:$public/v2.0 \\
				    --internalurl http://$server:$internal/v2.0 \\
				    --adminurl http://$server:$admin/v2.0 --region RegionOne $api",
			unless => "openstack endpoint list | grep $api",
		}
	}
}
