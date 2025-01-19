#!/bin/bash

###############################################################################
# This script:
# 1. Looks in /home/Ubuntu/thindrives/m/stable-diffusion-webui/outputs/
# 2. Finds the latest (alphabetically/largest) date folder in each of:
#       - img2img-images
#       - txt2img-images
# 3. Copies that folder to your Desktop under stablea1111/stable-diffusion-webui/outputs/
#    while skipping files that already exist (--ignore-existing).
###############################################################################

# Base paths
BASE_SRC="/home/Ubuntu/thindrives/m/stable-diffusion-webui/outputs"
BASE_DEST="/home/Ubuntu/Desktop/stablea1111/stable-diffusion-webui/outputs"

# Navigate to the outputs directory
cd "$BASE_SRC" || {
  echo "Could not navigate to $BASE_SRC; exiting."
  exit 1
}

###############################################################################
# Function to find the latest date folder within a given subdirectory name.
#   E.g., subdir="img2img-images" 
#   It will look for subfolders: img2img-images/2025-01-14, etc.
#   Then it picks the latest (lexically highest) date folder.
###############################################################################
find_latest_date_folder() {
  local subdir="$1"
  # Use ls to list directories of the form YYYY-MM-DD, sort them, and take the last one
  #  -d: list directories matching the pattern
  #  2>/dev/null: suppress errors if no matching directories exist
  #  sort -V: sorts in version order (which works well for YYYY-MM-DD)
  #  tail -n1: take the last (latest) entry
  latest_dir=$(ls -d "$subdir"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] 2>/dev/null \
    | sort -V \
    | tail -n1)

  echo "$latest_dir"
}

###############################################################################
# 1. Find latest date folder for img2img-images
###############################################################################
latest_img2img=$(find_latest_date_folder "img2img-images")
if [ -n "$latest_img2img" ]; then
  # Extract just the date part (e.g., 2025-01-18) from the directory path
  img2img_date=$(basename "$latest_img2img")

  echo "Latest img2img date folder found: $img2img_date"

  # Ensure destination directory exists
  mkdir -p "$BASE_DEST/img2img-images/$img2img_date"

  # Sync
  rsync -av --ignore-existing \
    "$latest_img2img/" \
    "$BASE_DEST/img2img-images/$img2img_date/"
else
  echo "No date folders found in img2img-images. Skipping."
fi

###############################################################################
# 2. Find latest date folder for txt2img-images
###############################################################################
latest_txt2img=$(find_latest_date_folder "txt2img-images")
if [ -n "$latest_txt2img" ]; then
  # Extract just the date part (e.g., 2025-01-18) from the directory path
  txt2img_date=$(basename "$latest_txt2img")

  echo "Latest txt2img date folder found: $txt2img_date"

  # Ensure destination directory exists
  mkdir -p "$BASE_DEST/txt2img-images/$txt2img_date"

  # Sync
  rsync -av --ignore-existing \
    "$latest_txt2img/" \
    "$BASE_DEST/txt2img-images/$txt2img_date/"
else
  echo "No date folders found in txt2img-images. Skipping."
fi
