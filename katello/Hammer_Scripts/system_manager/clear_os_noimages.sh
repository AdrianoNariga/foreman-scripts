#!/bin/bash
hammer os list | egrep -v 'CentOS 6.9|CentOS 7.5.1804|Debian Stretch|RedHat 7.5|Ubuntu Xenial|Ubuntu Bionic|Windows 10|Windows 8.1|RELEASE NAME' | grep ' | ' | awk '{print $1}' | while read i
do
	hammer os delete --id $i
done
