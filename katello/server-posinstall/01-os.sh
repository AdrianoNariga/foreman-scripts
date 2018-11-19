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
        --major 9 --minor 6 \
        --release-name "stretch" \
        --description "Debian Stretch"

hammer os create --name RedHat \
        --architectures x86_64 \
        --family Redhat \
        --major 7 --minor 6 \
        --description "RedHat 7.6"

hammer os create --name CentOS \
        --architectures x86_64 \
        --family Redhat \
        --major 6 --minor 10 \
        --description "CentOS 6.10"

hammer os create --name CentOS \
        --architectures x86_64 \
        --family Redhat \
        --major 7 --minor 6 \
        --description "CentOS 7.6"

hammer os create --name Windows \
        --architectures x86_64 \
        --family Windows \
        --major 10 \
        --description "Windows 10"
