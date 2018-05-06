#!/bin/bash
for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "RHEL Server 7.3" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "RHEL Server 7.3" | awk '{print $1}')
done

hammer template list | grep -q rhel_finish ||
  hammer template create --file Template_Scripts/rhel_finish.erb --type finish --name rhel_finish
