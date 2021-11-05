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

startApp() {
    CMD="$(echo $1 | cut -f1 -d ' ' )"
    if pgrep -x "$1" >/dev/null
    then
        echo "$CMD is running"
    else
        $1 &
        echo "$CMD is starting"
    fi
}


sleep 1

startApp "nitrogen --restore"
startApp picom
startApp dunst
startApp firefox
startApp numlockx
startApp "solaar -w hide"
startApp "scream -m /dev/shm/scream-ivshmem"
