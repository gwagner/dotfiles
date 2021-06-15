#!/bin/bash

killall -q picom
killall -q nitroen
killall -q dunst
killall -q teams
killall -q slack

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

/usr/bin/nitrogen --restore &

startApp picom
startApp dunst
startApp firefox
startApp teams
startApp slack