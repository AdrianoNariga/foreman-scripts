#!/bin/bash
foreman_server=$1

echo "deb http://deb.theforeman.org/ xenial 1.15" > /etc/apt/sources.list.d/foreman.list
apt-get -y install ca-certificates
wget -q https://deb.theforeman.org/pubkey.gpg -O- | apt-key add -
apt-get update && sudo apt-get install ruby-hammer-cli ruby-hammer-cli-foreman -y
mkdir ~/.hammer/cli.modules.d/ -p
cat > ~/.hammer/cli.modules.d/foreman.yml <<EOF
:foreman:
    :host: 'https://$foreman_server/'
    :username: 'nariga'
    :password: '$senha'
    :refresh_cache: false
    :request_timeout: 120
EOF

sudo hammer --fetch-ca-cert https://$foreman_server/
sudo install ~/.hammer/certs/${foreman_server}_443.pem /usr/local/share/ca-certificates/
sudo update-ca-certificates
