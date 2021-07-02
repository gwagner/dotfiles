#!/bin/bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

MONS="$(polybar -m)"
S="$(echo $MONS | cut -f2 -d ' ')"
M="$(echo $MONS | cut -f1 -d ':')"
W="$(echo $MONS | cut -f2 -d ' ' | cut -f1 -d '+' | cut -f1 -d 'x')"
W="$(expr $W - 8)"
H="$(echo $MONS | cut -f1 -d '+' | cut -f2 -d 'x')"


MONITOR=$M RESOLUTION=$S WIDTH=$W HEIGHT=$H polybar --log=info -r main &> ~/.polybar.logs 2>&1 &

