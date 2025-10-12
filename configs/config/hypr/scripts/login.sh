#!/bin/sh

# Run once to clear TTY
clear

while true; do
  # Show options
  printf "%s\n" \
    "Choose option:" \
    "1) Launch Hyprland (default)" \
    "2) Stay in TTY"

  printf "> "
  read -r choice

  case "$choice" in
  1 | "")
    if pidof systemd >/dev/null 2>&1; then
      exec Hyprland
    else
      # Hyprland without any dbus session runs terribly
      printf "Systemd not found, running with dbus-run-session..."
      exec dbus-run-session Hyprland
    fi
    ;;
  2)
    exit 0
    ;;
  *)
    printf "Invalid option, try again."
    sleep 1
    clear
    ;;
  esac
done
