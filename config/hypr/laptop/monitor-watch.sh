#!/bin/sh

LOG_FILE=/tmp/monitor-watch.log
CHECK_FALLBACK=false

echo "" >> $LOG_FILE
echo "Starting up monitor-watch.sh" >> $LOG_FILE

resetWaybar() {
  echo "    Resetting Waybar" >> $LOG_FILE
  /usr/bin/pkill -f waybar-detect.sh
  /usr/bin/killall waybar
  /bin/sh ~/.config/hypr/waybar-detect.sh &
}

laptopDisplayOn() {
  echo "    Turning Laptop Display On" >> $LOG_FILE
  hyprctl dispatch dpms on eDP-1
  hyprctl keyword monitor eDP-1,2256x1504@60,0x0,1.566667
  resetWaybar


  echo "    Moving workspaces to monitor 1" >> $LOG_FILE
  workspaces=$(hyprctl workspaces -j | jq '.[] | .id')
  for workspace in ${workspaces}; do
    hyprctl dispatch moveworkspacetomonitor $workspace 1
  done
}

laptopDisplayOff() {
  echo "    Turning Laptop Display Off" >> $LOG_FILE

  # This sleep is important, we need to give the new mon a few seconds to get registered
  sleep 5

  hyprctl dispatch dpms off eDP-1
  hyprctl keyword monitor eDP-1,disabled
  resetWaybar

  echo "    Moving Workspaces to Monitor 0" >> $LOG_FILE
  workspaces=$(hyprctl workspaces -j | jq '.[] | .id')
  for workspace in ${workspaces}; do
    hyprctl dispatch moveworkspacetomonitor $workspace 0
  done
}

handle() {
  case $1 in
    # If external display added, disable the laptop display
    monitoradded\>\>*) 
      if [[ $1 == *"DP-3"* ]] || [[ $1 == *"DP-2"* ]]; then
        echo "Got $1 event" >> $LOG_FILE
        laptopDisplayOff
      fi
      ;;
    # if external display removed, enable the laptop display
    monitorremoved\>\>*) 
      if [[ $1 == *"DP-3"* ]] || [[ $1 == *"DP-2"* ]]; then 
        echo "Got $1 event" >> $LOG_FILE
        laptopDisplayOn
      fi
      ;;
  esac
}

MONITOR_COUNT=$(hyprctl monitors all -j | jq length)
if (($MONITOR_COUNT > 1)); then
  echo "Have $MONITOR_COUNT monitors attached" >> $LOG_FILE
  laptopDisplayOff
fi


echo "Preflight checks complete, start watching displays" >> $LOG_FILE

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
