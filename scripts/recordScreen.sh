#!/bin/bash

# INFO ON PULSE STUFF RETRIEVED FROM THIS ARTICLE
# https://www.maartenbaert.be/simplescreenrecorder/recording-game-audio/

# Get hacksaw output
hck="$(hacksaw)"

# split size and offset
size="$(echo "$hck" | grep -oP "\d+x\d+")"
offset="$(echo "$hck" | grep -oP "\+\d+\+\d+")"

# Can't get offX without the + without pulling out some more regex trash
offX="$(echo "$offset" | grep -oP "^\+\d+")"
offX="${offX:1}"

# offY comes 
offY="$(echo "$offset" | grep -oP "\d+$")"

if [[ $hck = "" ]]; then
	exit 1
fi

if [[ $1 = "all" ]]; then
	# APPLICATION/NOTHING AND MIC
	ffmpeg \
		-video_size $size \
		-framerate 60 \
		-f x11grab \
		-thread_queue_size 512 \
		-i :0.0+$offX,$offY \
		-f pulse -ac 2 -i duplex_out.monitor output.mp4

elif [[ $1 = "nomic" ]]; then
	# ONLY APPLICATIONS OR NOTHING
	ffmpeg \
		-video_size $size \
		-framerate 60 \
		-f x11grab \
		-thread_queue_size 512 \
		-i :0.0+$offX,$offY \
		-f pulse -ac 2 -i application_out.monitor output.mp4

else
	echo "invalid mode (all/nomic)"
fi

