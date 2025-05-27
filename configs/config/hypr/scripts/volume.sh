#!/bin/sh

# Get an volume percentage
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d\n", $2 * 100}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")

# Checks to set correct icon
if [ "$MUTED" = "MUTED" ]; then
  ICON="muted"
else
  if [ "$VOLUME" -eq 0 ]; then
    ICON="muted"
  elif [ "$VOLUME" -le 30 ]; then
    ICON='low'
  elif [ "$VOLUME" -le 70 ]; then
    ICON='medium'
  else
    ICON='high'
  fi
fi

# Set full path to icon
ICON_PATH=$HOME/.local/share/icons/Papirus/24x24/panel/audio-volume-${ICON}.svg

# Call dunst to send a notification
dunstify -a "changeVolume" -i ${ICON_PATH} -t 2000 -r 2593 -u normal -h int:value:"${VOLUME}" "Volume: ${VOLUME}%"
