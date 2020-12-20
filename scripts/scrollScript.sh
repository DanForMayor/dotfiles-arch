#!/bin/bash

# This is for a custom polybar extension
# I use it so that songs that are too long will get displayed within 40 characters of space

zscroll --length 40 \
		-p "        " \
		--before-text "♪ x" --delay 0.2 \
		--match-command "mpc status" \
		--match-text "playing" "--before-text '♪ '" \
		--match-text "paused" "--before-text '♪ ' --scroll 0" \
		--update-check true "mpc current" &

wait

