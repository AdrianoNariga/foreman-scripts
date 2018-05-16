#!/bin/bash
hammer compute-resource create --provider Libvirt \
        --name vostro \
        --organizations home \
        --locations stc \
        --display-type SPICE \
        --set-console-password false \
        --url qemu+ssh://nariga@192.168.111.251/system

hammer compute-resource create --provider Libvirt \
        --name lenovo \
        --organizations home \
        --locations stc \
        --display-type SPICE \
        --set-console-password false \
        --url qemu+ssh://root@192.168.111.252/system
