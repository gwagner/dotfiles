#!/bin/bash

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  swaylock -f -C ~/.config/swaylock/config
else
  /usr/bin/i3lock -i /home/gwagner/backgrounds/lock-screen-background.jpg -F --ring-color=3b4252 --inside-color=2e3440 --insidever-color=2e3440 --ringver-color=2e3440 --insidewrong-color=2e3440 --ringwrong-color=2e3440 --keyhl-color=4c566a --bshl-color=4c566a --verif-color=FFFFFF --wrong-color=bf616a --modif-color=ebcb8b --noinput-text=""
fi
