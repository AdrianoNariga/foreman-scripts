#!/bin/bash
export foreman_hostname=foreman.local
export ip_foreman=192.168.111.100

export proxy_hostname=puppet.local
export ip_proxy="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"

source gen_proxy.sh

#mkdir -p /etc/foreman-proxy/ssl/certs/
#mkdir -p /etc/foreman-proxy/ssl/private_keys/
#ls /etc/foreman-proxy/ssl/certs/$proxy_hostname.pem ||
#  mv /etc/puppetlabs/puppet/ssl/certs/$proxy_hostname.pem /etc/foreman-proxy/ssl/certs/$proxy_hostname.pem
#
#ls /etc/foreman-proxy/ssl/private_keys/$proxy_hostname.pem ||
#  mv /etc/puppetlabs/puppet/ssl/private_keys/$proxy_hostname.pem /etc/foreman-proxy/ssl/private_keys/$proxy_hostname.pem
#
#ls /etc/foreman-proxy/ssl/certs/ca.pem ||
#  mv /etc/puppetlabs/puppet/ssl/certs/ca.pem /etc/foreman-proxy/ssl/certs/ca.pem
#
#rm /etc/puppetlabs/puppet/ssl/certs/$proxy_hostname.pem
#rm /etc/puppetlabs/puppet/ssl/private_keys/$proxy_hostname.pem
#rm /etc/puppetlabs/puppet/ssl/certs/ca.pem
#
#foreman-installer \
#  --no-enable-foreman \
#  --no-enable-foreman-cli \
#  --no-enable-foreman-plugin-bootdisk \
#  --no-enable-foreman-plugin-setup \
#  --foreman-proxy-tftp=false \
#  --enable-foreman-proxy \
#  --foreman-proxy-trusted-hosts=$foreman_hostname \
#  --foreman-proxy-trusted-hosts=$proxy_hostname \
#  --foreman-proxy-oauth-consumer-key="$consumer_key" \
#  --foreman-proxy-oauth-consumer-secret="$consumer_secret" \
#  --foreman-proxy-ssl-cert="/etc/foreman-proxy/ssl/certs/$proxy_hostname.pem" \
#  --foreman-proxy-ssl-key="/etc/foreman-proxy/ssl/private_keys/$proxy_hostname.pem" \
#  --foreman-proxy-ssl-ca="/etc/foreman-proxy/ssl/certs/ca.pem"

foreman-installer \
  --no-enable-foreman \
  --no-enable-foreman-cli \
  --no-enable-foreman-plugin-bootdisk \
  --no-enable-foreman-plugin-setup \
  --enable-puppet \
  --puppet-server-ca=false \
  --puppet-server-foreman-url=https://$foreman_hostname \
  --enable-foreman-proxy \
  --foreman-proxy-puppetca=false \
  --foreman-proxy-tftp=false \
  --foreman-proxy-foreman-base-url=https://$foreman_hostname \
  --foreman-proxy-trusted-hosts=$foreman_hostname \
  --foreman-proxy-trusted-hosts=$proxy_hostname \
  --foreman-proxy-puppetca=true \
  --enable-puppet --enable-foreman-proxy \
  --foreman-proxy-puppet=true \
  --foreman-proxy-trusted-hosts=$foreman_hostname \
  --foreman-proxy-trusted-hosts=$proxy_hostname \
  --puppet-ca-server=$proxy_hostname \
  --foreman-proxy-foreman-base-url=https://$foreman_hostname \
  --foreman-proxy-oauth-consumer-key="$consumer_key" \
  --foreman-proxy-oauth-consumer-secret="$consumer_secret"
