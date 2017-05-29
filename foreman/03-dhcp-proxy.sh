#!/bin/bash
range="192.168.11.2 192.168.11.13"
dns="192.168.11.14,8.8.8.8"
gateway=192.168.11.1
dhcp_iface=eth1

export foreman_hostname=foreman.local
export ip_foreman=192.168.111.100

export proxy_hostname=proxy.local
export ip_proxy="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"

source gen_proxy.sh

foreman-installer \
  --no-enable-foreman \
  --no-enable-foreman-cli \
  --no-enable-foreman-plugin-bootdisk \
  --no-enable-foreman-plugin-setup \
  --no-enable-puppet \
  --enable-foreman-proxy \
  --foreman-proxy-puppet=false \
  --foreman-proxy-puppetca=false \
  --foreman-proxy-tftp=false \
  --foreman-proxy-dhcp=true \
  --foreman-proxy-dhcp-interface=$dhcp_iface \
  --foreman-proxy-dhcp-gateway=$gateway \
  --foreman-proxy-dhcp-range="$range" \
  --foreman-proxy-dhcp-nameservers="$dns"
