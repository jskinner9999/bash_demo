#!/bin/bash

. ./env.sh

DATAOUT=$(curl -s "https://ps.pndsn.com/v3/history/sub-key/${SUBKEY}/message-counts/${CHAN}?timetoken=1")

# echo $DATAOUT

# echo $DATAOUT | jq

T1=$(echo $DATAOUT | jq .channels.${CHAN} )
echo ${T1} 'Messges on ' ${CHAN}







