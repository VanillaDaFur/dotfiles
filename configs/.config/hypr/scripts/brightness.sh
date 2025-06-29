#!/bin/sh 

# Variables

# ! IMPORTANT !, define your monitor from /sys/class/backlight 
# for example: intel_backlight
BACKLIGHT_IFACE="intel_backlight"
MAX_BRIGHT=$(cat /sys/class/backlight/$BACKLIGHT_IFACE/max_brightness)
ICON_PATH="/home/Vanilla/.local/share/icons/Papirus/24x24/panel/xfpm-brightness-lcd.svg"

# Function to calculate current brightness, just to show it
brightness() {
  CURRENT_BRIGHT=$(cat /sys/class/backlight/intel_backlight/brightness)
  BRIGHT_PERCENT=$(( CURRENT_BRIGHT * 100 / MAX_BRIGHT ))
}

# Main
case $1 in
  up)
    brightnessctl s 10%+
    brightness
    ;;
  down)
    brightnessctl s 10%-
    brightness
    ;;
  *)
    echo "Usage: $0 {up|down}"
    exit 1
    ;;
esac

notify-send -a sys-notif -i ${ICON_PATH} -t 3000 -r 2593 -u normal -h int:value:"$BRIGHT_PERCENT" -h string:synchronous:sys-notif "Brightness: ${BRIGHT_PERCENT}%"
