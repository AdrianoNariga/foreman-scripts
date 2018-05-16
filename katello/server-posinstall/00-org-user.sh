#!/bin/bash
hammer organization create --name home
hammer location create --name stc
hammer location add-domain --domain home.stc --name stc
hammer organization add-domain --domain home.stc --name home
hammer organization add-location --location stc --name home
hammer organization add-smart-proxy --smart-proxy $HOSTNAME --name home
hammer location add-smart-proxy --smart-proxy $HOSTNAME --name stc
hammer user create \
        --auth-source-id 1 \
        --admin true \
        --locations stc \
        --default-location stc \
        --organizations home \
        --default-organization home \
        --firstname Nariga \
        --lastname Adriano \
        --mail nariga@home.stc \
        --login nariga \
        --password 'VuDa22)$cld'
