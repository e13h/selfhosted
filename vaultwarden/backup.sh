#!/bin/bash

# Make a new database backup
docker exec -it vaultwarden /vaultwarden backup

DATA_DIR=vaultwarden-data
REMOTE_PATH=backblaze:e13h-backups/vaultwarden

rclone sync "$DATA_DIR" "$REMOTE_PATH" \
    --include 'db_*.sqlite3' \
    --include attachments \
    --include sends \
    --include config.json \
    --include 'rsa_key*'

# Remove old local backup files
ls -t ${DATA_DIR}/db_*.sqlite3 | tail -n +2 | xargs -I {} rm {}
