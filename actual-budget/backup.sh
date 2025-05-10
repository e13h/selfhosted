#!/bin/bash

SCRIPT_DIR=$(dirname $(realpath $0))
REMOTE_PATH=backblaze:e13h-backups/actual-budget

cd $SCRIPT_DIR
rclone sync actual-data "$REMOTE_PATH"

