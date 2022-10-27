#!/bin/bash

function folders_count {
    echo "Total number of folders (including all nested ones) = $(find $1 -mindepth 1 -type d | wc -l)"
}

function top5_folders {
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    du -h $1 | sort -hr | head -5 | nl | awk '{printf "%d - %s, %sB\n", $1, $3, $2}'
}

function files_count {
    echo "Total number of files = $(find $1 -type f | wc -l)"
}

function diff_files_count {
    echo "Number of: "
    echo "Configuration files (with the .conf extension) = $(find $1 -type f -name "*.conf" | wc -l)"
    echo "Text files = $(find $1 -type f -exec file {} + | grep "text" | wc -l)"
    echo "Executable files = $(find $1 -type f -executable | wc -l)"
    echo "Log files (with the extension .log) = $(find $1 -type f -name "*.log" | wc -l)"
    echo "Archive files = $(find $1 -type f -exec file {} + | grep -E "compressed|archive" | wc -l)"
    echo "Symbolic links = $(find $1 -type l | wc -l)"
}

function top10_files {
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    find $1 -type f -exec du -h {} + | sort -hr | head | awk '{printf "%d - %s, %s", NR, $2, $1; if (match($2, "[^./]+$")) printf ", %s\n", substr($2,RSTART,RLENGTH); else printf "\n"}'
}

function top10_exec_files {
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    find $1 -type f -executable -exec du -h {} + | sort -hr | head > info.tmp
    awk '{system("md5sum " $2)}' info.tmp | awk '{print $1}' > md5.tmp
    awk '{printf "%d - %s, %s, \n", NR, $2, $1}' info.tmp > info_pretty.tmp
    awk 'FNR==NR {a[NR]=$1; next} {$5=a[FNR]}1' md5.tmp info_pretty.tmp
    rm info.tmp info_pretty.tmp md5.tmp
}

function run_time {
    time_exit=`date +%s`
    echo "Script execution time (in seconds) = $(($time_exit-$1))"
}