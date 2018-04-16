#!/bin/bash
hammer os create --name CentOS --architectures x86_64 \
            --family Redhat --major 6 --minor 9

for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "CentOS 6.9" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "CentOS 6.9" | awk '{print $1}')
done

hammer template list | grep -q centos6_finish ||
  hammer template create --file Template_Scripts/centos6_finish.erb --type finish --name centos6_finish
