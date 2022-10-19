#!/bin/bash

function info_echo {
    echo "HOSTNAME = $HOSTNAME"
    echo "TIMEZONE = $(cat /etc/timezone) UTC $(date +"%:z")"
    echo "USER = $USER"
    echo "$(grep 'PRETTY_NAME=' /etc/os-release)" | awk -F"\"" '{print ("OS = " $2)}'
    echo "$(date)" | awk '{print ("DATE = " $2,$3,$4, $5)}'
    echo "UPTIME = $(uptime --pretty)"
    echo "UPTIME_SEC = $(cat /proc/uptime | awk '{print $1}')"
    echo "$(ifconfig enp0s3)" | grep "inet " | awk '{print ("IP = " $2)}'
    echo "$(ifconfig enp0s3)" | grep "inet " | awk '{print ("MASK = " $4)}'
    echo "$(ip route)" | grep "default" | awk '{print ("GATEWAY = " $3)}'
    echo "$(free -m)" | grep Mem: | awk '{printf ("RAM_TOTAL = %.3f GB\n", $2/1024)}'
    echo "$(free -m)" | grep Mem: | awk '{printf ("RAM_USED = %.3f GB\n", $3/1024)}'
    echo "$(free -m)" | grep Mem: | awk '{printf ("RAM_FREE = %.3f GB\n", $4/1024)}'
    echo "$(df /root/)" | grep "\/$" | awk '{printf ("SPACE_ROOT = %.2f Mb\n", $2/1024)}'
    echo "$(df /root/)" | grep "\/$" | awk '{printf ("SPACE_ROOT_USED = %.2f Mb\n", $3/1024)}'
    echo "$(df /root/)" | grep "\/$" | awk '{printf ("SPACE_ROOT_FREE = %.2f Mb\n", $4/1024)}'
}

function question {
    read -p "Do you want to write this information in file (Y/N)?" ans
    if [ "$ans" = "y" ] || [ "$ans" = "Y" ]; then
        current_date=$(date "+%d_%m_%y_%H_%M_%S")
        filename="$current_date.status"
        info_echo >> $filename
    fi
}