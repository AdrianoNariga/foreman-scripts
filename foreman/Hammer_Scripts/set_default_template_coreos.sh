for i in $(hammer template list | grep -i coreos | grep -v snippet | awk '{print $1}')
do
	hammer template add-operatingsystem --id $i --operatingsystem-id $(hammer os list | grep "CoreOS" | awk '{print $1}')
	hammer os set-default-template --config-template-id $i --id $(hammer os list | grep "CoreOS" | awk '{print $1}')
done
