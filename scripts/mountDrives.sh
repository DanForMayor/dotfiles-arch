#!/bin/bash
# Super simple script for mounting my google drives with RClone
# RClone has to have the remote setup first

rclone mount personal: /home/dan/Documents/Drive/ --vfs-cache-mode full &
#rclone mount personal:Music/ /home/dan/Music/ --vfs-cache-mode full &

