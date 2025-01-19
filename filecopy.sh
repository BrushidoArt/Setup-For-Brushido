#!/bin/bash

BASE_SRC="/home/Ubuntu/thindrives/m/stable-diffusion-webui/outputs"
BASE_DEST="/home/Ubuntu/Desktop/stablea1111/stable-diffusion-webui/outputs"

cd "$BASE_SRC" || {
  echo "Could not navigate to $BASE_SRC; exiting."
  exit 1
}

find_previous_date_folder() {
  local subdir="$1"
  local all_dirs=( $(ls -d "$subdir"/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] 2>/dev/null | sort -V) )
  local count=${#all_dirs[@]}
  if [ "$count" -lt 2 ]; then
    echo ""
  else
    local index=$((count - 2))
    echo "${all_dirs[$index]}"
  fi
}

###############################################################################
# 1. Find the latest *previous* date folder for img2img-images
###############################################################################
latest_prev_img2img=$(find_previous_date_folder "img2img-images")
if [ -n "$latest_prev_img2img" ]; then
  img2img_date=$(basename "$latest_prev_img2img")
  echo "Latest previous img2img date folder found: $img2img_date"

  mkdir -p "$BASE_DEST/img2img-images/$img2img_date"
  rsync -av --ignore-existing \
    "$latest_prev_img2img/" \
    "$BASE_DEST/img2img-images/$img2img_date/"
else
  echo "No second-latest date folder found in img2img-images. Skipping."
fi

###############################################################################
# 2. Find the latest *previous* date folder for txt2img-images
###############################################################################
latest_prev_txt2img=$(find_previous_date_folder "txt2img-images")
if [ -n "$latest_prev_txt2img" ]; then
  txt2img_date=$(basename "$latest_prev_txt2img")
  echo "Latest previous txt2img date folder found: $txt2img_date"

  mkdir -p "$BASE_DEST/txt2img-images/$txt2img_date"
  rsync -av --ignore-existing \
    "$latest_prev_txt2img/" \
    "$BASE_DEST/txt2img-images/$txt2img_date/"
else
  echo "No second-latest date folder found in txt2img-images. Skipping."
fi
