#!/bin/bash

TEXT="󰒲 "
TOOLTIP="No clients inhibiting idle"
if hyprctl clients | grep -q "Idle: 1"; then

  COUNT=$(hyprctl clients | grep "Idle: 1" | wc -l)
  LABEL="clients"

  if [ "$COUNT" -eq 1 ]; then
    LABEL="client"
  fi

  CLIENTS="`hyprctl clients -j | jq -r '[.[] | select(.inhibitingIdle == true) | .title] | join(" and ")'`"

  TEXT="󱎴 "
  TOOLTIP="$COUNT $LABEL inhibiting idle\n$CLIENTS"
fi


echo "{\"text\": \"$TEXT\", \"tooltip\": \"$TOOLTIP\"}";
