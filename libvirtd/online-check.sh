#!/bin/bash

while true
do
	if ping -c3 $1
	then
		systemctl disable online-check.service
		break
	fi
done
