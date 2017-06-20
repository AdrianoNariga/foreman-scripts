#!/bin/bash
foreman-installer --enable-foreman-plugin-ansible
foreman-installer --enable-foreman-proxy-plugin-ansible

yum install ansible tfm-rubygem-foreman_ansible -y
yum install python-requests

mkdir -p /etc/ansible/.plugins/callback_plugins/
wget https://raw.githubusercontent.com/theforeman/foreman_ansible/master/extras/foreman_callback.py -O \
  /etc/ansible/.plugins/callback_plugins/foreman_callback.py

cat > /etc/ansible/ansible.cfg <<EOF
[defaults]
callback_whitelist = foreman
callback_plugins = /etc/ansible/.plugins/callback_plugins/
bin_ansible_callbacks = True
[privilege_escalation]
[paramiko_connection]
[ssh_connection]
[persistent_connection]
connect_timeout = 30
connect_retries = 30
connect_interval = 1
[accelerate]
[selinux]
[colors]
[diff]
EOF

## foreman ou smart-proxy tem que resolver o nome

mkdir -p /usr/share/foreman-proxy/.ansible
chown foreman-proxy. /usr/share/foreman-proxy/.ansible
mkdir /usr/share/foreman-proxy/.ssh
chown foreman-proxy. /usr/share/foreman-proxy/.ssh
chmod 0700 /usr/share/foreman-proxy/.ssh
chmod 0600 /usr/share/foreman-proxy/.ssh/config
