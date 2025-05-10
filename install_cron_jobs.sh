#!/bin/bash

script_dir=$(realpath $(dirname $0))
mapfile -t backup_scripts < <(find $script_dir -name '*backup*.sh')

current_crontab=$(crontab -l 2>/dev/null)
new_crontab="$current_crontab"

minute=0
hour=3

for script in "${backup_scripts[@]}"; do
  if echo "$current_crontab" | grep -Fq "$script"; then
    echo "Cron job for $script already exists. Skipping."
  else
    cron_entry="$minute $hour * * * $script"
    new_crontab="${new_crontab}"$'\n'"$cron_entry"
    echo "Adding cron job for $script at ${hour}:$(printf "%02d" $minute)"
    minute=$((minute + 1))
    if [[ "$minute" -ge 60 ]]; then
      echo "Warning: More than 60 scripts - wrapping around the hour."
      minute=0
    fi
  fi
done

if [[ "$new_crontab" != "$current_crontab" ]]; then
  echo "$new_crontab" | crontab -
  echo "Cron jobs updated."
else
  echo "No changes made to cron."
fi

