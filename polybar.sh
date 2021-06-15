#!/bin/bash

killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

polybar --log=info -r main &> ~/.polybar.logs 2>&1 &
