#!/bin/bash

HOSTNAME=$(hostname)
if [ "$HOSTNAME" = framework ]; then
  waybar -c ~/.config/waybar/config-framework -s ~/.config/waybar/style-framework.css 
else
  waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css
fi

