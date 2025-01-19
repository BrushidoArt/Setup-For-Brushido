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
# Function to find the *most recent* date folder within a given subdirectory.
#   E.g., subdir="img2img-images"
#   It will look for subfolders named: img2img-images/2025-01-14, etc.
#   Then it picks the newest one (lexically highest date).
###############################################################################
find_latest_date_folder() {
  local subdir="$1"

  # Gather an array of all YYYY-MM-DD directories, sorted ascending
  local all_dirs=( $(ls -d "$subdir"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] 2>/dev/null | sort -V) )
  local count=${#all_dirs[@]}

  # If none were found, return empty
  if [ "$count" -eq 0 ]; then
    echo ""
  else
    # Last item in the array is the most recent date
    local index=$((count - 1))
    echo "${all_dirs[$index]}"
  fi
}

###############################################################################
# 1. Find the *most recent* date folder for img2img-images
###############################################################################
latest_img2img=$(find_latest_date_folder "img2img-images")
if [ -n "$latest_img2img" ]; then
  # Extract just the date part (e.g., 2025-01-19) from the directory path
  img2img_date=$(basename "$latest_img2img")

  echo "Most recent img2img date folder found: $img2img_date"

  # Ensure destination directory exists
  mkdir -p "$BASE_DEST/img2img-images/$img2img_date"

  # Sync only new files without overwriting existing ones
  rsync -av --ignore-existing \
    "$latest_img2img/" \
    "$BASE_DEST/img2img-images/$img2img_date/"
else
  echo "No date folders found in img2img-images. Skipping."
fi

###############################################################################
# 2. Find the *most recent* date folder for txt2img-images
###############################################################################
latest_txt2img=$(find_latest_date_folder "txt2img-images")
if [ -n "$latest_txt2img" ]; then
  txt2img_date=$(basename "$latest_txt2img")

  echo "Most recent txt2img date folder found: $txt2img_date"

  mkdir -p "$BASE_DEST/txt2img-images/$txt2img_date"
  rsync -av --ignore-existing \
    "$latest_txt2img/" \
    "$BASE_DEST/txt2img-images/$txt2img_date/"
else
  echo "No date folders found in txt2img-images. Skipping."
fi
