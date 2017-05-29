#!/bin/bash
export foreman_hostname=foreman.local
export ip_foreman=192.168.111.100

export proxy_hostname=puppet.local
export ip_proxy="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"

source gen_proxy.sh

foreman-installer \
  --no-enable-foreman \
  --no-enable-foreman-cli \
  --no-enable-foreman-plugin-bootdisk \
  --no-enable-foreman-plugin-setup \
  --foreman-proxy-tftp=false \
  --puppet-server-ca=false \
  --foreman-proxy-puppetca=false \
  --enable-puppet --enable-foreman-proxy \
  --foreman-proxy-trusted-hosts=$foreman_hostname \
  --foreman-proxy-trusted-hosts=$proxy_hostname \
  --puppet-ca-server=$foreman_hostname \
  --foreman-proxy-foreman-base-url=https://$foreman_hostname \
  --foreman-proxy-oauth-consumer-key="$consumer_key" \
  --foreman-proxy-oauth-consumer-secret="$consumer_secret"
