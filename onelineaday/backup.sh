#!/bin/bash

SCRIPT_DIR=$(dirname $(realpath $0))
cd $SCRIPT_DIR

BACKUP_FILE=$(${SCRIPT_DIR}/export.sh)

if [[ ! -f "$BACKUP_FILE" ]]; then
    echo "Backup failed!"
    exit 1
fi

REMOTE_PATH=backblaze:e13h-backups/onelineaday

rclone sync . "$REMOTE_PATH" --include "${BACKUP_FILE}" --delete-excluded

# Remove old local backup files
ls -t ${SCRIPT_DIR}/onelineaday_export_*.json | tail -n +2 | xargs -I {} rm {}
