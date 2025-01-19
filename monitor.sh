#!/bin/bash

# Get today's date in YYYY-MM-DD format
current_date=$(date +%Y-%m-%d)

# Source and destination folders
SRC="/home/Ubuntu/Desktop/stablea1111/stable-diffusion-webui/outputs/img2img-images/${current_date}/"
DEST="/home/Ubuntu/thindrives/m/stable-diffusion-webui/outputs/img2img-images/${current_date}/"

# Make sure the destination directory exists
mkdir -p "$DEST"

# Enter a loop that waits for filesystem events
while true
do
  # -r for recursive
  # -e create,modify,move events trigger a sync
  # --exclude '\.tmp$' ignores files ending in .tmp
  inotifywait -r --exclude '\.tmp$' -e create,modify,move "$SRC"

  # When an event is detected, use rsync to copy only new files.
  # --ignore-existing avoids overwriting files that already exist at the destination.
  # --exclude '*.tmp' skips copying any .tmp files that might appear.
  rsync -av --ignore-existing --exclude '*.tmp' "$SRC" "$DEST"
done
