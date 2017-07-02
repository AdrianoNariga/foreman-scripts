#!/bin/bash
echo "deb http://deb.theforeman.org/ xenial 1.15" > /etc/apt/sources.list.d/foreman.list
sudo apt-get -y install ca-certificates
sudo wget -q https://deb.theforeman.org/pubkey.gpg -O- | sudo apt-key add -
sudo apt-get update && sudo apt-get install ruby-hammer-cli ruby-hammer-cli-foreman
mkdir ~/.hammer/cli.modules.d/ -p
cat > ~/.hammer/cli.modules.d/foreman.yml <<EOF
:foreman:
    :host: 'https://foreman.local/'
    :username: 'nariga'
    :password: '$senha'
    :refresh_cache: false
    :request_timeout: 120
EOF

sudo hammer --fetch-ca-cert https://foreman.local/
sudo install /home/nariga/.hammer/certs/foreman.local_443.pem /usr/local/share/ca-certificates/
sudo update-ca-certificates
