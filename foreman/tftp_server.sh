#!/bin/bash
source $1
export proxy_hostname=$tftp_hostname
export ip_proxy="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"

source shell-functions/configure-ssh.sh
source shell-functions/installer-repo.sh
source shell-functions/gen_proxy.sh

yum install -y centos-release-scl-rh centos-release-scl
yum install -y rh-ruby22-ruby tfm-rubygem-smart_proxy_dynflow_core rubygem-smart_proxy_remote_execution_ssh

foreman-installer \
  --no-enable-foreman \
  --no-enable-foreman-cli \
  --no-enable-foreman-plugin-bootdisk \
  --no-enable-foreman-plugin-setup \
  --no-enable-puppet \
  --enable-foreman-proxy \
  --puppet-server=false \
  --foreman-proxy-puppet=false \
  --foreman-proxy-puppetca=false \
  --foreman-proxy-tftp=true \
  --foreman-proxy-tftp-servername=$ip_proxy \
  --foreman-proxy-trusted-hosts=$foreman_hostname \
  --foreman-proxy-trusted-hosts=$proxy_hostname \
  --foreman-proxy-foreman-base-url=https://$foreman_hostname \
  --foreman-proxy-oauth-consumer-key="$consumer_key" \
  --foreman-proxy-oauth-consumer-secret="$consumer_secret" \
  --enable-foreman-proxy-plugin-remote-execution-ssh
