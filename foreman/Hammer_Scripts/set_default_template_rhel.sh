#!/bin/bash

for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "RedHat 7.4" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "RedHat 7.4" | awk '{print $1}')
done
