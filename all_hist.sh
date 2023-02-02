#!/bin/bash


. ./env.sh

declare -a EPOCH_LIST
declare -a EPOCH_LIST_FULL

DATAOUT=$(curl -s "https://ps.pndsn.com/v3/history/sub-key/${SUBKEY}/channel/${CHAN}?uuid=${UUID}&include_meta=false&stringtoken=true&string_message_token=true&include_message_type=true&include_uuid=true&max=100")

CH=$(echo $DATAOUT | jq .channels |  jq  keys  | sed -r 's/\[//' | sed -r 's/\]//' | tr -d \")
# echo 'CH ' ${#CH}

if [ ! $CH ]
then
echo "NO DATA in channel ${CHAN} "
echo "${DATAOUT}" | jq
exit 0
fi
echo 'before while' ${CH}
# exit 1
CNT=0
while [ ${#CH} != 0 ]
do

    E=$(echo $DATAOUT | jq .channels |  jq ' .'"${CHAN}"' | length') #
    END=$((E - 1))

    for i in $(seq 0 $END)
    do 
    ((CNT=CNT+1))
    # echo $i
    T1=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[$i].timetoken | tr -d \")
    # echo 'TT ' ${T1} 

    TT=$(echo ${T1} | cut -c 1-10)

    PT=$(date -r $TT)
    MSG=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[$i].message | tr '\n' ' ' | tr -d ' ')
    UUID=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[$i].uuid)
    echo "${CNT} $i - ${PT} ${MSG} ${UUID} ${T1}"
    EPOCH_LIST+=("${T1} ")
    EPOCH_LIST_FULL+=("${T1} ${CNT} $i - ${PT} ${MSG} ${UUID}")
    done
FIRST_TT=$(echo $DATAOUT | jq .channels |  jq  .${CHAN}[0].timetoken | tr -d \")

    # echo $DATAOUT > aa.txt

    echo 'FIRST_TT ' "${FIRST_TT}"
    DATAOUT=$(curl -s "https://ps.pndsn.com/v3/history/sub-key/${SUBKEY}/channel/${CHAN}?count=100&uuid=${UUID}&include_meta=false&stringtoken=true&string_message_token=true&include_message_type=true&include_uuid=true&max=100&start=${FIRST_TT}")


    CH=$(echo "$DATAOUT" | jq .channels |  jq  keys  | sed -r 's/\[//' | sed -r 's/\]//' | tr -d \")
    echo "CH========${CH} ${#CH}"
done



./count.sh

# echo "${EPOCH_LIST[*]}"
# echo "${#EPOCH_LIST[*]}"
echo "${EPOCH_LIST[0]}  $(./Print_PN_Time.sh "${EPOCH_LIST[0]}")  ${EPOCH_LIST[${#EPOCH_LIST[*]} - 1]}  $(./Print_PN_Time.sh "${EPOCH_LIST[${#EPOCH_LIST[*]} - 1]}")"

IFS=$'\n'
EPS=($(sort --numeric-sort <<<"${EPOCH_LIST[*]}"))
# EPS=$(echo "${EPOCH_LIST[*]}" | sort -g)
unset IFS

echo "======SORTED======"
# echo "${EPS[*]}"
# echo "${#EPS[*]}"
echo "${EPS[0]}  $(./Print_PN_Time.sh "${EPS[0]}")  ${EPS[${#EPS[*]} - 1]}  $(./Print_PN_Time.sh "${EPS[${#EPS[*]} - 1]}")"


IFS=$'\n'
# EPS=($(sort --numeric-sort -r <<<"${EPOCH_LIST_FULL[*]}"))
EPS=($(sort  <<<"${EPOCH_LIST_FULL[*]}"))
# EPS=$(echo "${EPOCH_LIST[*]}" | sort -g)
unset IFS

echo "======SORTED===FULL==="
echo "${EPS[*]}"
# echo "${#EPS[*]}"
echo "${EPS[0]}  $(./Print_PN_Time.sh "${EPS[0]}")  ${EPS[${#EPS[*]} - 1]}  $(./Print_PN_Time.sh "${EPS[${#EPS[*]} - 1]}")"
exit 0

CNT=0
for i in "${EPS[@]}" 
do
echo "${CNT} -- ${i}"
((CNT=CNT+1))
done


