class utilsconfs::gitlabaccess {
        exec { 'route-to-vpn':
                path    => '/bin:/usr/bin:/usr/sbin:/sbin',
                unless  => "ip r s | grep 192.168.21.0",
                command => "ip route add 192.168.21.0/28 via 192.168.111.252",
        }

        host { 'gitlab.home.jab':
                ip => '192.168.21.1',
                host_aliases => 'gitlab',
        }
}
