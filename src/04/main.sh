#!/bin/bash
. ./sysinfo.sh
source ./config.conf

chmod +x sysinfo.sh

export NUM_ARGS=$(awk 'END{print NR}' config.conf)
export ARG1=$column1_background
export ARG2=$column1_font_color
export ARG3=$column2_background
export ARG4=$column2_font_color

check_args

export -n NUM_ARGS
export -n ARG1
export -n ARG2
export -n ARG3
export -n ARG4