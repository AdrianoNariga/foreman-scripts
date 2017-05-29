#!/bin/bash
export foreman_hostname=foreman.local
export ip_foreman=192.168.111.100
export proxy_hostname=proxy.local
export ip_proxy="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"
source gen_proxy.sh

dns_iface=eth1
zona_name="local"
reverse="11.168.192"
dns_forward="192.168.111.254"

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
  --foreman-proxy-dns-forwarders=8.8.4.4
