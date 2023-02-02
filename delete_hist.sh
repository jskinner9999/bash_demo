#!/bin/bash

. ./env.sh

START="${1}"
END="${2}"

DATAOUT=$(curl -s -X DELETE -i "https://ps.pndsn.com/v3/history/sub-key/${SUBKEY}/channel/${CHAN}")

echo "${DATAOUT}"
