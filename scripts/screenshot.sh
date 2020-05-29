#!/bin/bash

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

