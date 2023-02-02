#!/bin/bash

if [ ! $1 ]
then
echo 'no arg 1'
exit 1
fi

. ./env.sh

DATAOUT=$(curl -s -X POST   -H "Content-type: application/json"  \
 "https://ps.pndsn.com/publish/${PUBKEY}/${SUBKEY}/0/${CHAN}/0?store=1&uuid=${UUID}" \
   -d "{\"message\":\"${1}\"}")

EPOCH=$(echo ${DATAOUT} | jq .[2])

STATUS=$(echo ${DATAOUT} | jq .[1])

echo "Message was ${STATUS} PubNub epoch is ${EPOCH}"
newctime=$(echo ${EPOCH} | sed -r 's/\"//' | cut -c 1-10)
# echo ${#newctime} '  ' ${newctime}

echo "PubNub date of publish: $(date -r $newctime) " 

