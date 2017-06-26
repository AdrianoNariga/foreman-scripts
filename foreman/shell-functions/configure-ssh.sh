#!/bin/bash
ls ~/.ssh/id_rsa.pub || ssh-keygen -t rsa -f $HOME/.ssh/id_rsa -q -P ""

cat > $HOME/.ssh/config << EOF
Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null
EOF
ssh-copy-id root@$ip_foreman
