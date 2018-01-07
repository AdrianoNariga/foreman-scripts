#!/bin/bash
hammer os create --name Ubuntu --architectures x86_64 \
            --family Debian --major 16 --minor 04 --description "Ubuntu 16.04.3 LTS"

for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "Ubuntu 16.04.3 LTS" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "Ubuntu 16.04.3 LTS" | awk '{print $1}')
done

#hammer template list | grep -q ubuntu_finish ||
#  hammer template create --file Template_Scripts/ubuntu_finish.erb --type finish --name ubuntu_finish
