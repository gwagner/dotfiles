#!/bin/bash

TEXT="󰒲 "
TOOLTIP="No clients inhibiting idle"
if hyprctl clients | grep -q "Idle: 1"; then

  CLIENTS="`hyprctl clients -j | jq -r '[.[] | select(.inhibitingIdle == true) | .title] | join(" and ")'`"

  TEXT="󱎴 "
  TOOLTIP="`hyprctl clients | grep "Idle: 1" | wc -l` clients inhibiting idle\n$CLIENTS"
fi


echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}";
