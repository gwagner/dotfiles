#!/bin/bash

killall -q nitroen
killall -q picom
killall -q dunst
killall -q firefox
killall -q obs
killall -q teams
killall -q slack
killall -q numlockx
killall -q solaar
killall -q scream
killall -q xss-lock
killall -q lxpolkit

startApp() {
    CMD="$(echo $1 | cut -f1 -d ' ' )"
    if pgrep -xf "$1" >/dev/null
    then
        echo "$CMD is running"
    else
        eval $1 &
        echo "$CMD is starting"
    fi
}


sleep 1

startApp "nitrogen --restore"
startApp picom
startApp dunst
startApp firefox
startApp "solaar -w hide"
startApp "openrgb --startminimized -p Default"
startApp "/usr/bin/xss-lock -- /usr/bin/betterlockscreen -l"
#startApp "/bin/scream -m /dev/shm/scream-ivshmem"
startApp "lxpolkit"