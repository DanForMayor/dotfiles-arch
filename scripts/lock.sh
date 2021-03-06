#!/bin/bash

# this just locks the screen
# takes a screencap, then blurs it, and adds a little icon image on top
# then calls i3lock

TMPBG=/tmp/screen.png
LOCK=$HOME/Pictures/lock.png
RES=$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')
 
ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=20:10,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG -loglevel quiet
i3lock -i $TMPBG
rm $TMPBG

