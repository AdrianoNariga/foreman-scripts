for i in $(hammer template list | grep Preseed | egrep -v 'finish|Atomic|RHEL' | awk '{print $1}')
do
	hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "Debian" | awk '{print $1}')
	hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "Debian" | awk '{print $1}')
done
