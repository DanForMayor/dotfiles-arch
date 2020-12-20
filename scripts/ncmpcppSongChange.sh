#!/bin/bash

# This script runs every time a song is changed
# all it does is call other scripts
# ALL OUTPUT NEEDS TO BE QUIETED, OTHERWISE NCMPCPP GETS BUSTED

~/Scripts/song_notify/mpd_notification.sh > /dev/null 2>&1

# this is pretty busted. Not doing it right now
#~/Scripts/song_notify/ncmpcpp_art.sh

