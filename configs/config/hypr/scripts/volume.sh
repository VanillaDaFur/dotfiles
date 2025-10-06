#!/usr/bin/env sh

# Checks to set correct icon
notif_volume() {
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

  notify-send -a sys-notif -i "${ICON_PATH}" -t 3000 -r 2593 -u normal -h int:value:"${VOLUME}" -h string:synchronous:sys-notif "Volume: ${VOLUME}%"
}
notif_mic() {
  # Check to set correct icon
  MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -o "MUTED")
  if [ "$MUTED" = "MUTED" ]; then
    ICON="muted"
    TEXT="muted"
  else 
    ICON="high"
    TEXT="not muted"
  fi
  # Set full path to icon
  ICON_PATH=$HOME/.local/share/icons/Papirus/24x24/panel/microphone-sensitivity-${ICON}.svg

  notify-send -a sys-notif -i "${ICON_PATH}" -t 3000 -r 2593 -h string:synchronous:sys-notif "Microphone: ${TEXT}"

}
# Main
case $1 in
  up)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    notif_volume
    ;;
  down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    notif_volume
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    notif_volume
    ;;
  microphone)
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    notif_mic
    ;;
  *)
    echo "Usage: $0 {up|down|mute|microphone}"
    exit 1
    ;;
esac
