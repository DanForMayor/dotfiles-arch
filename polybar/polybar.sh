#!/usr/bin/env sh

# This is for polybar
# This just makes sure that there is only one instance of polybar active
# per monitor

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    export MONITOR=$m
	polybar --reload top &
    polybar --reload bottom &
  done
else
  polybar --reload example &
fi

