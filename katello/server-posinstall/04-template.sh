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
