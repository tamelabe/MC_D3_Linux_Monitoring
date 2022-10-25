#!/bin/bash
. ./sysinfo.sh

chmod +x sysinfo.sh

export NUM_ARGS=$#
export ARG1=$1
export ARG2=$2
export ARG3=$3
export ARG4=$4

check_args


export -n NUM_ARGS
export -n ARG1
export -n ARG2
export -n ARG3
export -n ARG4