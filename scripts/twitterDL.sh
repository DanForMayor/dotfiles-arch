#!/bin/bash

# MUST BE A m3u8 URL
videoURL=$1
outputName=$2

ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$videoURL" -c copy "$outputName"

