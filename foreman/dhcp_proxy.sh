#!/bin/bash
source $1
proxy_hostname=$dhcp_hostname
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
  --foreman-proxy-puppet=false \
  --foreman-proxy-puppetca=false \
  --foreman-proxy-tftp=false \
  --foreman-proxy-dhcp=true \
  --foreman-proxy-dhcp-interface=$dhcp_iface \
  --foreman-proxy-dhcp-gateway=$gateway \
  --foreman-proxy-dhcp-range="$range" \
  --foreman-proxy-dhcp-nameservers="$dns" \
  --foreman-proxy-dhcp-pxeserver="$ip_tftp" \
  --foreman-proxy-trusted-hosts=$foreman_hostname \
  --foreman-proxy-trusted-hosts=$dhcp_hostname \
  --foreman-proxy-foreman-base-url=https://$foreman_hostname \
  --foreman-proxy-oauth-consumer-key="$consumer_key" \
  --foreman-proxy-oauth-consumer-secret="$consumer_secret" \
  --foreman-proxy-ssl-ca /etc/puppetlabs/puppet/ssl/certs/ca.pem \
  --foreman-proxy-ssl-cert /etc/puppetlabs/puppet/ssl/certs/$proxy_hostname.pem \
  --foreman-proxy-ssl-key /etc/puppetlabs/puppet/ssl/private_keys/$proxy_hostname.pem

iptables -t nat -nL POSTROUTING | grep "MASQUERADE  all  --  0.0.0.0/0            0.0.0.0/0" ||
  iptables -t nat -A POSTROUTING -j MASQUERADE &&
    systemctl enable rc-local &&
    {
      rclocal_path="/etc/rc.local"
      get_so -s | grep -q CentOS && rclocal_path="/etc/rc.d/rc.local"
      chmod +x $rclocal_path
      grep "iptables -t nat -A POSTROUTING -j MASQUERADE" $rclocal_path ||
      echo "iptables -t nat -A POSTROUTING -j MASQUERADE" >> $rclocal_path
    }

sysctl -w net.ipv4.ip_forward=1 &&
  echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/98-ip_forward.conf

source shell-functions/puppet-agent.sh
systemctl restart puppet
