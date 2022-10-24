#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE="$(cat /etc/timezone) UTC $(date +"%:z")"
USER=$(whoami)
OS=$(grep 'PRETTY_NAME=' /etc/os-release) | awk -F"\"" '{print ($2)}'
DATE=$(date) | awk '{print ($2,$3,$4, $5)}'
UPTIME=$(uptime --pretty)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
IP=$(ifconfig enp0s3) | grep "inet " | awk '{print ($2)}'
MASK=$(ifconfig enp0s3) | grep "inet " | awk '{print ($4)}'
GATEWAY=$(ip route) | grep "default" | awk '{print ($3)}'
RAM_TOTAL=$(free -m) | grep Mem: | awk '{printf ("%.3f GB\n", $2/1024)}'
RAM_USED=$(free -m) | grep Mem: | awk '{printf ("%.3f GB\n", $3/1024)}'
RAM_FREE=
SPACE_ROOT=
SPACE_ROOT_USED=
SPACE_ROOT_FREE=

function info_echo {
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(cat /etc/timezone) UTC $(date +"%:z")"
    echo "USER = $(whoami)"
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
