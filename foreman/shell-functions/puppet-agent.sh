
cat > /etc/puppetlabs/puppet/puppet.conf << EOF
[main]
    basemodulepath = /etc/puppetlabs/code/environments/common:/etc/puppetlabs/code/modules:/opt/puppetlabs/puppet/modules
    environmentpath = /etc/puppetlabs/code/environments
    hiera_config = \$confdir/hiera.yaml
    hostprivkey = \$privatekeydir/\$certname.pem { mode = 640 }
    logdir = /var/log/puppetlabs/puppet
    pluginfactsource = puppet:///pluginfacts
    pluginsource = puppet:///plugins
    privatekeydir = \$ssldir/private_keys { group = service }
    reports = foreman
    rundir = /var/run/puppetlabs
    show_diff = false
    ssldir = /etc/puppetlabs/puppet/ssl
    vardir = /opt/puppetlabs/puppet/cache

[agent]
pluginsync      = true
report          = true
ignoreschedules = true
ca_server       = $foreman_hostname
certname        = $proxy_hostname
environment     = production
server          = $puppet_hostname
EOF

systemctl restart puppet
systemctl enable puppet
