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
killall -q qpwgraph

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

## Start on the desktop, not framework laptop
if [ "$HOSTNAME" != "framework" ]; then
    startApp "/usr/bin/qpwgraph -a -m"
    startApp "solaar -w hide"
    startApp "openrgb --startminimized -p Default"
#    startApp "/usr/bin/xss-lock -- /usr/bin/betterlockscreen -l dim"
    startApp "/usr/bin/xss-lock -- /usr/bin/i3lock -i /home/gwagner/backgrounds/lock-screen-background.jpg -F --ring-color=3b4252 --inside-color=2e3440 --insidever-color=2e3440 --ringver-color=2e3440 --insidewrong-color=2e3440 --ringwrong-color=2e3440 --keyhl-color=4c566a --bshl-color=4c566a --verif-color=FFFFFF --wrong-color=bf616a --modif-color=ebcb8b --noinput-text=\"\""
    startApp "lxpolkit"
fi

# startApp "/bin/scream -m /dev/shm/scream-ivshmem"
