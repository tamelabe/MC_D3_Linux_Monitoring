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

function check_args {
    if [[ $NUM_ARGS -eq 4 ]]; then
        reg="^[1-6]$"
        if [[ $ARG1 =~ $reg ]] && [[ $ARG2 =~ $reg ]] && [[ $ARG3 =~ $reg ]] && [[ $ARG4 =~ $reg ]]; then
            if [[ $ARG1 -ne $ARG2 ]] && [[ $ARG3 -ne $ARG4 ]]; then
                bg_v_names="\033[4$(color_convertion $ARG1)m"
                fc_v_names="\033[3$(color_convertion $ARG2)m"
                bg_v="\033[4$(color_convertion $ARG3)m"
                fc_v="\033[3$(color_convertion $ARG4)m"
                def_clr="\033[37m\033[0m"
                info_echo
            else
                echo "Background and font colors should'n be equal. Please type diff [1-2] and [3-4] args."
            fi
        else
            echo "Args should be a numbers [1-6]."
        fi
    else
        echo "Please type 4 color parameters."
    fi
}

function color_convertion {
    res=0
    case "$1" in
        1) res=7 ;;
        2) res=1 ;;
        3) res=2 ;;
        4) res=4 ;;
        5) res=5 ;;
        6) res=0 ;;
    esac

    echo $res
}

function num_to_text {
    c_name="default"
    c_num="$1"
    case "$1" in
        7) c_name="white" ;;
        1) c_name="red" ;;
        2) c_name="green" ;;
        4) c_name="blue" ;;
        5) c_name="purple" ;;
        0) c_name="black" ;;
    esac
    
    if [[ $2 -eq 1 ]] && [[ $c_name -eq "black" ]]; then
        c_num="default"
    elif [[ $2 -eq 2 ]] && [[ $c_name -eq "white" ]]; then
        c_num="default"
    elif [[ $2 -eq 3 ]] && [[ $c_name -eq "red" ]]; then
        c_num="default"
    elif [[ $2 -eq 4 ]] && [[ $c_name -eq "purple" ]]; then
        c_num="default"
    fi

    echo "$C_num ($c_name)"
}

function num_to_num {
        res="default"
    case "$1" in
        7) res=1 ;;
        1) res=2 ;;
        2) res=3 ;;
        4) res=4 ;;
        5) res=5 ;;
        0) res=6 ;;
    esac

    echo $res
}

function info_echo {
    echo -e "${bg_v_names}${fc_v_names}HOSTNAME${def_clr} = ${bg_v}${fc_v}$HOSTNAME${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}TIMEZONE${def_clr} = ${bg_v}${fc_v}$TIMEZONE${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}USER${def_clr} = ${bg_v}${fc_v}$USER${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}OS${def_clr} = ${bg_v}${fc_v}$OS${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}DATE${def_clr} = ${bg_v}${fc_v}$DATE${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}UPTIME${def_clr} = ${bg_v}${fc_v}$UPTIME${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}UPTIME_SEC${def_clr} = ${bg_v}${fc_v}$UPTIME_SEC${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}IP${def_clr} = ${bg_v}${fc_v}$IP${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}MASK${def_clr} = ${bg_v}${fc_v}$MASK${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}GATEWAY${def_clr} = ${bg_v}${fc_v}$GATEWAY${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}RAM_TOTAL${def_clr} = ${bg_v}${fc_v}$RAM_TOTAL${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}RAM_USED${def_clr} = ${bg_v}${fc_v}$RAM_USED${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}RAM_FREE${def_clr} = ${bg_v}${fc_v}$RAM_FREE${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}SPACE_ROOT${def_clr} = ${bg_v}${fc_v}$SPACE_ROOT${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}SPACE_ROOT_USED${def_clr} = ${bg_v}${fc_v}$SPACE_ROOT_USED${def_clr}"
    echo -e "${bg_v_names}${fc_v_names}SPACE_ROOT_FREE${def_clr} = ${bg_v}${fc_v}$SPACE_ROOT_FREE${def_clr}"
    echo ""
    conf_echo
}

function conf_echo {
    echo "Column 1 background = $(num_to_text $ARG1 1)"
    echo "Column 1 font color = $(num_to_text $ARG2 2)"
    echo "Column 2 background = $(num_to_text $ARG3 3)"
    echo "Column 2 font color = $(num_to_text $ARG4 4)"
}
