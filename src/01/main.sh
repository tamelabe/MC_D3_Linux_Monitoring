#!/bin/bash

if (( $# != 1 )); then
    echo "Only 1 arg accepted!"
else
    chmod +x check.sh
    bash ./check.sh "$1"
fi