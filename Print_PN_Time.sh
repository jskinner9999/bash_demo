#!/bin/bash

PN_EPOCH=$1

EPOCH=$(echo "${PN_EPOCH}" | cut -c 1-10)

PT=$(date -r $EPOCH)

echo "${PT}"
