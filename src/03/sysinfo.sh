#!/bin/bash

HOSTNAME=$(hostname)
TIMEZONE="$(cat /etc/timezone) UTC $(date +"%:z")"
USER=$(whoami)
OS=$(grep 'PRETTY_NAME=' /etc/os-release | awk -F"\"" '{print ($2)}')
DATE=$(date | awk '{print ($2,$3,$4, $5)}')
UPTIME=$(uptime --pretty)
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
IP=$(ifconfig enp0s3 | grep "inet " | awk '{print ($2)}')
MASK=$(ifconfig enp0s3 | grep "inet " | awk '{print ($4)}')
GATEWAY=$(ip route | grep "default" | awk '{print ($3)}')
RAM_TOTAL=$(free -m | grep Mem: | awk '{printf ("%.3f GB\n", $2/1024)}')
RAM_USED=$(free -m | grep Mem: | awk '{printf ("%.3f GB\n", $3/1024)}')
RAM_FREE=$(free -m | grep Mem: | awk '{printf ("%.3f GB\n", $4/1024)}')
SPACE_ROOT=$(df /root/ | grep "\/$" | awk '{printf ("%.2f Mb\n", $2/1024)}')
SPACE_ROOT_USED=$(df /root/ | grep "\/$" | awk '{printf ("%.2f Mb\n", $3/1024)}')
SPACE_ROOT_FREE=$(df /root/ | grep "\/$" | awk '{printf ("SPACE_ROOT_FREE = %.2f Mb\n", $4/1024)}')

function info_echo {
    echo "HOSTNAME = $HOSTNAME"
    echo "TIMEZONE = $TIMEZONE"
    echo "USER = $USER"
    echo "OS = $OS"
    echo "DATE = $DATE"
    echo "UPTIME = $UPTIME"
    echo "UPTIME_SEC = $UPTIME_SEC"
    echo "IP = $IP"
    echo "MASK = $MASK"
    echo "GATEWAY = $GATEWAY"
    echo "RAM_TOTAL = $RAM_TOTAL"
    echo "RAM_USED = $RAM_USED"
    echo "RAM_FREE = $RAM_FREE"
    echo "SPACE_ROOT = $SPACE_ROOT"
    echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
    echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
}
