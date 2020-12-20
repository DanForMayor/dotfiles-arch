#!/bin/bash

# This is a little script that uses hacksaw and shotgun to operate
# allows for full screencaps to be taken, or for specifically selected
# screen regions to be captured

# USAGE:
#  - Region:	./THIS_SCRIPT -s
#  - Full cap:	./THIS_SCRIPT

filename=""

if [[ $1 =~ ^-[sS]$ ]]; then

	# Screen region
	filename="region_$(date '+%s').png"
	shotgun -g "$(hacksaw -f "%g")" $filename

else

	# Full Screenshot
	filename="scrsht_$(date '+%s').png"
	shotgun $filename


fi

if [[ filename != "" ]]; then

	xclip -selection clipboard -t "image/png" -i "$filename"

fi

