#!/usr/bin/env sh

# Path for screenshot be saved at
IMG_PATH=~/Pictures/Screenshots/Screenshot_$(date +%F_%T).png

# Create screenshots directory if it doesn't exist
mkdir -p ~/Pictures/Screenshots

# Function to copy screenshot to keyboard and send notification
copy_and_notif() {
  if [ -f "$IMG_PATH" ]; then
    wl-copy -t image/png < "$IMG_PATH" 
    notify-send "Screenshot Saved" "Screenshots are stored at ~/Pictures/Screenshots" --icon="$IMG_PATH"
  else
    notify-send "Screenshot Cancelled" "Screenshot were cancelled" --icon="$IMG_PATH"
  fi
}

# Main.
case "$1" in
  full)
    grim "$IMG_PATH"
    copy_and_notif
    ;;
  zone)
    hyprpicker -r -z &
    sleep 0.3
    grim -g "$(slurp)" "$IMG_PATH"
    pkill hyprpicker
    copy_and_notif
    ;;
  *)
    echo "Usage: $0 {full|zone}"
    exit 1
    ;;
esac
