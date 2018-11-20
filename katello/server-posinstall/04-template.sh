#!/bin/bash
cd ../Templates_Scripts/snnipet/
for i in *
do
	echo $i
	echo
        hammer template create \
                --file $i \
                --type snippet \
                --organizations home \
                --locations stc \
                --name $(echo $i | cut -d '.' -f 1)
done
cd -

cd ../Templates_Scripts/finish/
for i in *
do
	echo $i
	echo
        hammer template update \
                --file $i \
                --type finish \
                --organizations home \
                --locations stc \
                --name $(echo $i | cut -d '.' -f 1)
done
cd -

echo "configurando cento 6.10"
for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "CentOS 6.10" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "CentOS 6.10" | awk '{print $1}')
done

echo "configuranfo red hat"
for i in $(hammer template list | egrep 'Kickstart|rhel_katello' | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "RedHat 7.6" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "RedHat 7.6" | awk '{print $1}')
done

echo "configurando ubuntu xenial"
for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "Ubuntu Xenial" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "Ubuntu Xenial" | awk '{print $1}')
done

echo "configurando ubuntu bionic"
for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "Ubuntu Bionic" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "Ubuntu Bionic" | awk '{print $1}')
done

echo "configurando debian stretch"
for i in $(hammer template list | grep Kickstart | egrep -v 'finish|Atomic' | awk '{print $1}')
do
        hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "Debian Stretch" | awk '{print $1}')
        hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "Debian Stretch" | awk '{print $1}')
done
