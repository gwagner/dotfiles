#!/usr/bin/env bash

# Create a virtual sink that can be set as a monitor in OBS
pactl load-module module-null-sink sink_name=GStreamerMic sink_properties=device.description=VirtualSpeaker
pactl load-module module-null-sink sink_name=OBSMonitor sink_properties=device.description=VirtualSpeaker

# Link it with a virtual source that is visible in pulseaudio apps like Zoom
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=StreamInput channel_map=front-left,front-right
pw-link OBSMonitor:monitor_FL StreamInput:input_FL
pw-link OBSMonitor:monitor_FR StreamInput:input_FR