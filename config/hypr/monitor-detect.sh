#!/bin/bash

if [ "$HOSTNAME" = framework ]; then
   hyprctl keyword monitor eDP-1,2256x1504@60,0x0,1.566667  
fi

