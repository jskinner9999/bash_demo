#!/bin/bash

echo "Start"
name=yoyo
myvar=foobar
# curl https://ps.pndsn.com/time/0?uuid=jim123
ctime=$(curl -s https\:\/\/ps.pndsn.com\/time\/0\?uuid\=jim123  | sed -r 's/\[//' | sed -r 's/\]//')

echo ${ctime} 
# echo ${#ctime}

newctime=$(echo ${ctime} | cut -c 1-10)
# echo ${#newctime}

# date -r $newctime
# epoch=$(date +'%s')

# echo ${epoch} '    ' ${#epoch}

# date -r $ctime
./Print_PN_Time.sh "${ctime}"


