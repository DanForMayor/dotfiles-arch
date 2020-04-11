#!/bin/bash

# just a wrapper script for playing/pausing
# lets me call the notification script on play/pause


mpc toggle
~/Scripts/song_notify/mpd_notification.sh

