#!/bin/bash

# Path for screenshot be saved at
IMG_PATH=~/Pictures/Screenshots/Screenshot_$(date +%F_%T).png

# Create screenshots directory if it doesn't exist
mkdir -p ~/Pictures/Screenshots

# Function to copy screenshot to keyboard and send notification
copy-and-notif() {
  if [ -f $IMG_PATH ]; then
    wl-copy < $IMG_PATH 
    notify-send "Screenshot Saved" "Screenshots are stored at ~/Pictures/Screenshots" --icon="$IMG_PATH"
  else
    notify-send "Screenshot Cancelled" "Screenshot were cancelled" --icon="$IMG_PATH"
  fi
}

# Main.
case "$1" in
  full)
    grim $IMG_PATH
    copy-and-notif
    ;;
  zone)
    hyprpicker -r -z &
    sleep 0.1
    grim -g "$(slurp)" $IMG_PATH
    pkill hyprpicker
    copy-and-notif
    ;;
  *)
    echo "Usage: $0 {full|zone}"
    exit 1
    ;;
esac
