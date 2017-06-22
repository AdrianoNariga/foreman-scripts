#!/bin/bash
source HOSTS

ssh -t $ip_foreman 'foreman-installer --enable-foreman-plugin-ansible ; systemctl restart httpd'
yum -y install python-requests
foreman-installer --enable-foreman-proxy-plugin-ansible

# Testar
#file_conf="/usr/lib/pythen2.7/site-packages/ansible/plugins/callback/foreman.py"
#sed -i "s/http:\/\/localhost:3000/https:\/\/$foreman_hostname/g" $file_conf
#sed -i "s/\/etc\/foreman\/client_cert.pem/\/etc\/puppetlabs\/puppet\/ssl\/certs\/$foreman_hostname.pem/g" $file_conf
#sed -i "s/\/etc\/foreman\/client_key.pem/\/etc\/puppetlabs\/puppet\/ssl\/private_keys/$foreman_hostname.pem/g" $file_conf
#sed -i "s/\'FOREMAN_SSL_VERIFY\'\, \"1\"/\'FOREMAN_SSL_VERIFY\'\, \"\/etc\/puppetlabs\/puppet\/ssl\/certs\/ca.pem\"/g" $file_conf

#mkdir -p /etc/ansible/.plugins/callback_plugins/
#wget https://raw.githubusercontent.com/theforeman/foreman_ansible/master/extras/foreman_callback.py -O \
#  /etc/ansible/.plugins/callback_plugins/foreman_callback.py
#
#cat > /etc/ansible/ansible.cfg <<EOF
#[defaults]
#callback_whitelist = foreman
#callback_plugins = /etc/ansible/.plugins/callback_plugins/
#bin_ansible_callbacks = True
#[privilege_escalation]
#[paramiko_connection]
#[ssh_connection]
#[persistent_connection]
#connect_timeout = 30
#connect_retries = 30
#connect_interval = 1
#[accelerate]
#[selinux]
#[colors]
#[diff]
#EOF

## foreman ou smart-proxy tem que resolver o nome

test -d /usr/share/foreman-proxy/.ssh || mkdir /usr/share/foreman-proxy/.ssh
test -d /usr/share/foreman-proxy/.ansible || mkdir -p /usr/share/foreman-proxy/.ansible
chown foreman-proxy. /usr/share/foreman-proxy/.ansible
cat > /usr/share/foreman-proxy/.ssh/config << EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
chown -R foreman-proxy. /usr/share/foreman-proxy/.ssh
chmod 0700 /usr/share/foreman-proxy/.ssh
chmod 0600 /usr/share/foreman-proxy/.ssh/config
