#!/bin/bash
hammer os create --name RedHat --architectures x86_64 \
            --family Redhat --major 7 --minor 3 --description "RHEL Server 7.3"

for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "RHEL Server 7.3" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "RHEL Server 7.3" | awk '{print $1}')
done
