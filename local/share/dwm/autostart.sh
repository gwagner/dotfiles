#!/bin/bash

killall -q nitroen
killall -q picom
killall -q dunst
killall -q firefox
killall -q teams
killall -q slack
killall -q numlockx
killall -q solaar

startApp() {
    if pgrep -x "$1" >/dev/null
    then
        echo "$1 is running"
    else
        $1 &
        echo "$1 is starting"
    fi
}


sleep 1

startApp "/usr/bin/nitrogen --restore"
startApp picom
startApp dunst
startApp firefox
startApp teams
startApp slack
startApp numlockx
startApp solaar -w hide