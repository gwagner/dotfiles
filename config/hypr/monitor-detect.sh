#!/bin/bash

if [ "$HOSTNAME" = framework ]; then
  hyprctl keyword monitor eDP-1,2256x1504@60,0x0,1.566667  
  WORKSPACE_ID="$(hyprctl activeworkspace -j | jq '.id')"

  hyprctl --batch "dispatch workspace 2; dispatch layoutmsg orientationleft; dispatch workspace 1; dispatch layoutmsg orientationleft; dispatch layoutmsg mfact .7; dispatch workspace $WORKSPACE_ID"
else
  hyprctl keyword monitor HDMI-A-1,3440x1440,auto,1
fi

