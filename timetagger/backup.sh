#!/bin/bash

SCRIPT_DIR=$(dirname $(realpath $0))
REMOTE_PATH=backblaze:e13h-backups/timetagger

cd $SCRIPT_DIR
rclone sync timetagger-data "$REMOTE_PATH"

