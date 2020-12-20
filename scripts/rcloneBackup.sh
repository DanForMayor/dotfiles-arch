#!/bin/bash

# This will sync up my music to google drive
# It WILL take forever on the first run, but it shouldn't be too bad afterwards

# NOTE: THIS WILL DELETE SONGS.
# if a song is not present in the folder, that IS present in Drive, then it will be REMOVED FROM DRIVE

rclone sync --update --verbose --transfers 30 --checkers 8 --contimeout 100s --timeout 300s --retries 3 --low-level-retries 10 --stats 1s "/home/dan/Music" "personal:Music"

