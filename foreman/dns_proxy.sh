#!/bin/bash
source HOSTS
proxy_hostname=$dns_hostname
export ip_proxy="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"

source shell-functions/configure-ssh.sh
source shell-functions/installer-repo.sh
source shell-functions/gen_proxy.sh

foreman-installer \
  --no-enable-foreman \
  --no-enable-foreman-cli \
  --no-enable-foreman-plugin-bootdisk \
  --no-enable-foreman-plugin-setup \
  --no-enable-puppet \
  --enable-foreman-proxy \
  --foreman-proxy-tftp=false \
  --foreman-proxy-puppet=false \
  --foreman-proxy-puppetca=false \
  --foreman-proxy-dns=true \
  --foreman-proxy-dns-interface=$dns_iface \
  --foreman-proxy-dns-zone=$zona_name \
  --foreman-proxy-dns-reverse=$reverse.in-addr.arpa \
  --foreman-proxy-dns-forwarders=$dns_forward \
  --foreman-proxy-dns-forwarders=8.8.4.4 \
  --foreman-proxy-trusted-hosts=$foreman_hostname \
  --foreman-proxy-trusted-hosts=$proxy_hostname \
  --foreman-proxy-foreman-base-url=https://$foreman_hostname \
  --foreman-proxy-oauth-consumer-key="$consumer_key" \
  --foreman-proxy-oauth-consumer-secret="$consumer_secret"

cat >> /var/named/dynamic/db.$zona_name << EOF
$dhcp_hostname. IN A $ip1_dhcp
$tftp_hostname. IN A $ip_tftp
$puppet_hostname. IN A $ip_puppet
$foreman_hostname. IN A $ip_foreman
EOF

systemctl restart named foreman-proxy
