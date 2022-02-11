#!/bin/bash

DEFUALT_FIREFOX_PROFILE=`cat "$HOME/.mozilla/firefox/profiles.ini" | sed -n -e 's/^.*Path=//p' | grep "default-release" | head -n 1`
DEFUALT_FIREFOX_PROFILE_FP="$HOME/.mozilla/firefox/$DEFUALT_FIREFOX_PROFILE"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! -d "$DEFUALT_FIREFOX_PROFILE_FP/chrome/" ]; then
    mkdir "$DEFUALT_FIREFOX_PROFILE_FP/chrome/"
fi

ln -s $SCRIPT_DIR/userChrome.css "$DEFUALT_FIREFOX_PROFILE_FP/chrome/userChrome.css"