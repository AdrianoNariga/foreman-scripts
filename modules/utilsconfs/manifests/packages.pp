class utilsconfs::packages {
        $dependencies = [ 'vim','git' ]
        package { $dependencies: ensure => present }
}
