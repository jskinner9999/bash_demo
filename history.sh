#!/bin/bash

. ./env.sh

#v3
DATAOUT=$(curl -s "https://ps.pndsn.com/v3/history/sub-key/${SUBKEY}/channel/${CHAN}?uuid=${UUID}&include_meta=false&stringtoken=true&string_message_token=true&include_message_type=true&include_uuid=true&max=100")
#v2
# DATAOUT=$(curl -s "https://ps.pndsn.com/v2/history/sub-key/${SUBKEY}/channel/${CHAN}?uuid=${UUID}&include_meta=false&stringtoken=true&string_message_token=true&include_token=true&include_uuid=true&count=20")

CH=$(echo $DATAOUT | jq .channels |  jq  keys  | sed -r 's/\[//' | sed -r 's/\]//' | tr -d \")
# echo 'CH ' ${#CH}

if [ ! $CH ]
then
echo "NO DATA in channel ${CHAN} "
echo "${DATAOUT}" | jq
exit 0
fi

# E=$(echo $DATAOUT | jq .channels |  jq ' .rest2 | length')
E=$(echo $DATAOUT | jq .channels |  jq ' .'"${CHAN}"' | length')
END=$((E - 1))

for i in $(seq 0 $END)
do 
# echo $i
T1=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[$i].timetoken | tr -d \")
# echo 'TT ' ${T1} 

FIRST_TT=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[0].timetoken | tr -d \")

TT=$(echo ${T1} | cut -c 1-10)

PT=$(date -r $TT)
MSG=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[$i].message | tr '\n' ' ' | tr -d ' ')
UUID=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[$i].uuid)
echo "$i - ${PT} ${MSG} ${UUID} ${T1}"
done


# echo $DATAOUT > history.txt

echo 'FIRST_TT ' ${FIRST_TT} " $(./Print_PN_time.sh ${FIRST_TT}) "


./count.sh







