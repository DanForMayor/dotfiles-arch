#!/bin/bash

# This is kind of a temporary script that I don't intend to keep forever
# It's meant to let me set album art for all the music in an entire folder

#USAGE:
# ./setAlbumArt.sh /path/to/album/ /path/to/cover/image <<file type (usually mp3)>>

#first arg is the album location
albumFolder=$(dirname $1)

#Second arg is the cover art
coverArt=$2

#Third is the filetype
songType=$3


# Make the new folder
mkdir "$albumFolder/new"


wildcardFiles=

# Loop through all the files, adding album art to files of the correct type
for f in "$albumFolder"/*."$songType"; do 

	ffmpeg -i "$f" -i cover.jpg -map_metadata 0 -map 0 -map 1 "$albumFolder/new/$f";

done 

# Keep the originals nice and safe
mkdir "$albumFolder/backup"
mv "$albumFolder"/*."$songType" "$albumFolder/backup"


mv "$albumFolder/new/"* "$albumFolder"

