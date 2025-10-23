#!/usr/bin/env sh

if pidof pipewire >/dev/null 2>&1 || pidof systemd >/dev/null 2>&1; then
  printf "Pipewire/Systemd is already running, aborting...\n"
  exit 0
fi

pipewire &
sleep 1 &&
wireplumber &
pipewire-pulse &

printf "Pipewire initialized"
