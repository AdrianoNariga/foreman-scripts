#!/bin/bash
hammer os create --name Ubuntu \
        --architectures x86_64 \
        --family Debian \
        --major 16 --minor 04 \
        --release-name "xenial" \
        --description "Ubuntu Xenial"

hammer os create --name Ubuntu \
        --architectures x86_64 \
        --family Debian \
        --major 18 --minor 04 \
        --release-name "bionic" \
        --description "Ubuntu Bionic"

hammer os create --name Debian \
        --architectures x86_64 \
        --family Debian \
        --major 9 --minor 4 \
        --release-name "stretch" \
        --description "Debian Stretch"

hammer os create --name RedHat \
        --architectures x86_64 \
        --family Redhat \
        --major 7 --minor 4 \
        --description "RHEL Server 7.4"

hammer os create --name CentOS \
        --architectures x86_64 \
        --family Redhat \
        --major 6 --minor 9 \
        --description "CentOS 6.9"
