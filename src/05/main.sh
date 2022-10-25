#!/bin/bash
. ./script.sh

time_start=`date +%s`
sleep 1

chmod +x ./script.sh

folders_count $1
top5_folders $1
files_count $1
diff_files_count $1
top10_files $1
top10_exec_files $1
run_time $time_start

