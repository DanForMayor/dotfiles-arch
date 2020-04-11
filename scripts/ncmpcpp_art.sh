#!/bin/bash

COVER=/tmp/cover.jpg

function reset_background
{
    printf "\e]20;;100x100+1000+1000\a"
}

{
    covers="/home/dan/Music/$(dirname "$(mpc status -f '%file%' | head -n1)")/cover.jpg"
    src="$(echo -n "$covers" | head -n1)"
    rm -f "$COVER" 
    if [[ -n "$src" ]] ; then
        #resize the image's width to 300px 
        convert "$src" -resize 300x "$COVER"
        if [[ -f "$COVER" ]] ; then
           #scale down the cover to 30% of the original
           #place it 1% away from left and 50% away from top.
           printf "\e]20;${covers};60x60+1+60:op=keep-aspect\a"
        else
            reset_background
        fi
    else
        reset_background
    fi
} &
