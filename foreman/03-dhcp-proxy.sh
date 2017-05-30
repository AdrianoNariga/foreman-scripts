#!/bin/bash
export foreman_hostname=foreman.local
export ip_foreman=192.168.111.100
export proxy_hostname=dhcp.local
export ip_proxy="$(ip -o -4 a s $(ip r s | grep default | awk '{print $5}' | head -n1) | awk '{print $4}' | cut -d \/ -f 1)"
source gen_proxy.sh

range="192.168.11.2 192.168.11.11"
dns="192.168.11.13,8.8.8.8"
gateway=192.168.11.1
dhcp_iface=eth1

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
  --foreman-proxy-dhcp-nameservers="$dns" \
  --foreman-proxy-trusted-hosts=$foreman_hostname \
  --foreman-proxy-trusted-hosts=$proxy_hostname \
  --foreman-proxy-foreman-base-url=https://$foreman_hostname \
  --foreman-proxy-oauth-consumer-key="$consumer_key" \
  --foreman-proxy-oauth-consumer-secret="$consumer_secret"

#net=$(ip -o -4 a s $dhcp_iface | awk '{print $4}')
#ssh -t $ip_foreman "ip route add $net dev \$\(ip r s | grep default | awk \'\{print \$5\}\'\)"

iptables -t nat -nL POSTROUTING | grep "MASQUERADE  all  --  0.0.0.0/0            0.0.0.0/0" ||
  iptables -t nat -A POSTROUTING -j MASQUERADE &&
    systemctl enable rc-local &&
    {
      chmod +x /etc/rc.d/rc.local
      grep "iptables -t nat -A POSTROUTING -j MASQUERADE" /etc/rc.d/rc.local ||
      echo "iptables -t nat -A POSTROUTING -j MASQUERADE" >> /etc/rc.d/rc.local
    }

sysctl -w net.ipv4.ip_forward=1 &&
  echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/98-ip_forward.conf
