class openstack-build::definitions::keytone-tenant{

	define serviceProject($project = $title, $user, $pass, $service, $type, $description = $title){
		$enviroment = ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"]
		$path = '/bin:/usr/bin:/sbin:/usr/sbin'

		exec{ "$title-projectUser":
			enviroment => $enviroment,
			path => $path,
			command => "openstack user create --project $project --password $pass $user",
#			unless => 
		}

		exec{ "$title-ruleUser":
			enviroment => $enviroment,
			path => $path,
			command => "openstack role add --project $project --user $user admin",
#			unless =>
			require => Exec["$title-projectUser"]
		}

		exec{ "$title-service":
			enviroment => $enviroment,
			path => $path,
			command => "openstack service create --name $service --description $description $type",
#			unless =>
			require => Exec["$title-ruleUser"]
		}
	}

	define addRule($ruleName = $title){
		exec{ "$title-rule":
			enviroment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack role create $ruleName",
			unless => "openstack role list | grep $ruleName"
		}
	}

	define createProject($projectName = $title, $description){
		exec{ "$title-project":
			enviroment => ["OS_TOKEN=$admin_token","OS_URL=http://$ipaddress:35357/v2.0/"],
			path => '/bin:/usr/bin:/sbin:/usr/sbin',
			command => "openstack project create --description \"$description\" $projectName",
			unless => "openstack project list | grep $projectName"
		}
	}
}
