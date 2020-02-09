#!/bin/bash

# This script is for the Dunst song notification script
# it uses mpc and dunst to gather song data, and display it

#This expects that the desired album art already exists, and has /tmp/cover.png as it's path


# Super complicated form that is meant to be sent to MPC to get the data
form="\n<b>Artist:</b>\t<span color='##a1b56c'>%artist%</span>\n<b>Album:</b>\t<span color='##6a9fb5'>%album%</span>\n<b>Title:</b>\t<span color='##ac4142'>%title%</span>"

# Pull the mpc data using the form
toprint="`mpc status -f \"$form\" | head -n4 | sed \"s:&:&amp;:g\"`"

# Get the status (playing or paused)-- this is done really badly, I hate it
playing_status=$(mpc status | head -n 2 | tail -n 1 | grep -Eo "playing|paused")

# Display the whole thing in a dunst notification
# Capitalize the playing_status
dunstify -a MPD --timeout=5000 -r 1337 -i "/tmp/cover.png" "${playing_status^}" "$toprint"
