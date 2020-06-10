#!/bin/sh

# This script is meant to be called by ncmpcpp
# It grabs the song's album art
# (assuming it's a file in the same folder as the song that's
# currently playing, and that it's called 'cover.jpg')
# 
# In the case that no image is found, a default one will be used instead
# The default image's location should be:
# ~/Pictures/dunstIcons/defaultCover.jpg

TMP_ART_PATH="/tmp/cover"
DEFAULT_ART_PATH="/home/dan/Pictures/dunstIcons/defaultCover.png"

# The only argument to this function is the path to the temp art
function popup(){
	
	# this is meant to be sent to MPC to get the data, and arrange it nicely
	form="
<b>Artist:</b>	<span color='##a1b56c'>%artist%</span>
<b>Album:</b>	<span color='##6a9fb5'>%album%</span>
<b>Title:</b>	<span color='##ac4142'>%title%</span>
"

	# Pull the mpc data using the form
	toprint="`mpc status -f \"$form\" | head -n4 | sed \"s:&:&amp;:g\"`"

	# Get the status (playing or paused)-- this is done really badly, I hate it
	playing_status=$(mpc status | head -n 2 | tail -n 1 | grep -Eo "playing|paused")

	# Display the whole thing in a dunst notification
	# Capitalize the playing_status
	dunstify -a MPD --timeout=5000 -r 1337 -i "$1" "${playing_status^}" "$toprint"

}

# Get the path to the album art
artpath="/home/dan/Music/$(dirname "$(mpc status -f '%file%' | head -n1)")/cover.jpg"

# remove old cover
rm "$TMP_ART_PATH"


# If the convert failed, use a default kept in ~/Pictures/dunstIcons
if [ -f "$artpath" ]; then

	# Convert the image to a sensible size
	convert -resize 220x220 "$artpath" "$TMP_ART_PATH"

else

	# Convert the default image
	convert -resize 220x220 "$DEFAULT_ART_PATH" "$TMP_ART_PATH"

fi

# Call the popup script which calls dunst (or whatever notifier)
popup "$TMP_ART_PATH"

