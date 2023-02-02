#!/bin/bash

echo "Start"

. ./env.sh

OUT=$(curl -s "https://ps.pndsn.com/v2/subscribe/${SUBKEY}/${CHAN}/0?uuid=${UUID}&tt=0")

TT=$(echo ${OUT} | jq .t.t | tr -d \")

REG=$(echo ${OUT} | jq .t.r)

while true
do
DATAOUT=$(curl -s "https://ps.pndsn.com/v2/subscribe/${SUBKEY}/${CHAN}/0?uuid=${UUID}&tt=${TT}&tr=${REG}")

# echo "OUT TT=${TT} REG=${REG}"

# echo $DATAOUT | jq 

CH1=$(echo ${DATAOUT} | jq .m | jq .[0].c | tr -d \")

# echo "Channel ${CH1}"

MSG=$(echo ${DATAOUT} | jq .m | jq .[0].d | tr -d \")



# echo "MSG ${MSG}"

TT=$(echo ${DATAOUT} | jq .m | jq .[0].p.t | tr -d \")

# echo "TT ${TT}"

PT=$(./Print_PN_time.sh ${TT})
# echo "PT ${PT}"

echo "${MSG}    |  on ${CH1}  @ ${PT}"


done




