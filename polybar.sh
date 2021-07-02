#!/bin/bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --log=info -r main &> ~/.polybar.logs 2>&1 &
  done
else
  polybar --log=info -r main &> ~/.polybar.logs 2>&1 &
fi

