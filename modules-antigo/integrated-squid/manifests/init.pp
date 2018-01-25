class integrated-squid {
	$workgroup = $workgroup
	$up_domaindc = $up_domaindc
	$domain_dc = $domain_dc
	$dc_dnsname = $dc_dnsname
	$adm_domain = $adm_domain
	$adm_password = $adm_password
	$visible_name = $visible_name
	$network_access = $network_access
	$packages = ['squid3','krb5-user','libkrb5-3',
			'ldap-utils','libsasl2-2','libsasl2-modules',
			'libsasl2-modules-gssapi-mit','samba','winbind',
			'samba-common-bin','smbclient']
	package{ $packages:
		ensure => present
	}
}
