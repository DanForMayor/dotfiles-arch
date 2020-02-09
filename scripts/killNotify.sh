#!/bin/bash

# This script is just for stopping dunst song notifications
# The reason this is it's own script is just in case
# this is used in any configs, I won't need to change anything if
# killing the notifications changes for some reason

killall prepareNotify.sh > /dev/null 2>&1

