#!/bin/sh

# This script is meant to be ONE OF the scripts called on song change
# Another script wraps this one, and any others that need to run on song change
#
# It grabs the song's album art
# (assuming it's a file in the same folder as the song that's
# currently playing, and that it's called 'cover.jpg')
# 
# In the case that no image is found, a default one will be used instead
# The default image's location should be:
# ~/Pictures/dunstIcons/defaultCover.jpg

TMP_ART_PATH="/tmp/cover.png"
DEFAULT_ART_PATH="/home/dan/Pictures/dunstIcons/defaultCover.png"
MUSIC_FOLDER="/home/dan/Music"

# The only argument to this function is the path to the temp art
function popup(){
	
	# this is meant to be sent to MPC to get the data, and arrange it nicely
	form="
<b>Artist:</b>	<span color='##6b59b3'>%artist%</span>
<b>Album:</b>	<span color='##8859b3'>%album%</span>
<b>Title:</b>	<span color='##9d55aa'>%title%</span>
"

	# Pull the mpc data using the form
	toprint="`mpc status -f \"$form\" | head -n4 | sed \"s:&:&amp;:g\"`"

	# Get the status (playing or paused)-- this is done really badly, I hate it
	playing_status=$(mpc status | head -n 2 | tail -n 1 | grep -Eo "playing|paused")

	# Display the whole thing in a dunst notification
	# Capitalize the playing_status
	dunstify -a MPD --timeout=5000 -r 1337 -i "$1" "${playing_status^}" "$toprint"

}

# Get the absolute path to the current song
songpath="$MUSIC_FOLDER/$(mpc status -f '%file%' | head -n1)"

# remove old cover
rm "$TMP_ART_PATH"

# Attempt to extract art from song
ffmpeg -i "$songpath" -vf scale=220:220 "$TMP_ART_PATH" > /dev/null 2>&1

# If the convert failed, use a default kept in ~/Pictures/dunstIcons
if [ $? -eq 1 ]; then
	convert -resize 220x220 "$DEFAULT_ART_PATH" "$TMP_ART_PATH"
fi

# Call the popup script which calls dunst (or whatever notifier)
popup "$TMP_ART_PATH"

