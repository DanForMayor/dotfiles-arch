#!/bin/sh

# This script is meant to be called after a change to mpc
# It grabs the song's album art
# (assuming it's a file in the same folder as the song that's
# currently playing, and that it's called 'cover.jpg')
# 
# In the case that no image is found, a default one will be used instead
# The default image's location should be:
# ~/Pictures/dunstIcons/defaultCover.jpg


# Make sure that there aren't any more of these running
script_name=${BASH_SOURCE[0]}
for pid in $(pidof -x $script_name); do
	if [ $pid != $$ ]; then
		kill -9 $pid
	fi
done


while true; do
	
	mpcOut=$(mpc idle)

	if [ $mpcOut = "player" ]
	then

		# Get the path to the album art
		artpath="/home/dan/Music/$(dirname "$(mpc status -f '%file%' | head -n1)")/cover.jpg"

		# remove old cover
		rm /tmp/cover.png

		# Convert the image to a sensible size
		convert -resize 220x220 "$artpath" /tmp/cover.png

		# If the convert failed, use a default kept in ~/Pictures/dunstIcons
		if [ "$?" -ne "0" ]; then
			$(convert -resize 256x256 ~/Pictures/dunstIcons/defaultCover.jpg /tmp/cover.png)
		fi

		~/Scripts/song_notify/popup.sh
	fi
done
