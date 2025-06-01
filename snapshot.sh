#!/bin/bash
DATE=$(date +'%Y-%m-%d')
TIME=$(date +'%H-%M-%S')
FOLDER="/home/youruser/snapshots/$DATE"
mkdir -p "$FOLDER"
/usr/bin/ffmpeg -rtsp_transport tcp -i "rtsp://admin:pk@0639544615@ramrome.thddns.net:3381/stream1" -vframes 1 "$FOLDER/snapshot_$TIME.jpg"
cp "$FOLDER/snapshot_$TIME.jpg" "/home/youruser/snapshots/latest.jpg"
