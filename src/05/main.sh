#!/bin/bash
. ./script.sh

time_start=`date +%s`
sleep 1

chmod +x ./script.sh

if [[ -n $1 ]]; then
    if [[ -d $1 ]]; then
        if [[ ${1: -1} = "/" ]]; then
            folders_count $1
            top5_folders $1
            files_count $1
            diff_files_count $1
            top10_files $1
            top10_exec_files $1
            run_time $time_start
        else
            echo "Path should be end with '/'"
        fi
    else
        echo "Directory is not exist. Enter a correct directory"
    fi
else
    echo "Please type directory path as argument"
fi

