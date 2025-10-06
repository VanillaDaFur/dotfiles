#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
## style-6   style-7   style-8   style-9   style-10

# Current Theme
dir="$HOME/.config/rofi/powermenu"
theme="style"

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"

# Options
shutdown='󰤆'
reboot='󰜉'
lock=''
suspend='󰤁'
logout='󰍃'
yes=''
no='󰅖'

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p "  Uptime: $uptime" \
    -theme "${dir}/${theme}".rasi
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 330px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you sure?' \
    -theme "${dir}/${theme}".rasi
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      if pidof systemd >/dev/null 2>&1; then
        # On systemd systems
        systemctl poweroff
      else
        # else.
        loginctl poweroff
      fi
    elif [[ $1 == '--reboot' ]]; then
      if pidof systemd >/dev/null 2>&1; then
        # On systemd systems
        systemctl reboot
      else
        # Else.
        loginctl reboot
      fi
    elif [[ $1 == '--suspend' ]]; then
      mpc -q pause
      amixer set Master mute
      if pidof systemd >/dev/null 2>&1; then
        # On systemd systems
        systemctl suspend
      else
        # Else.
        loginctl suspend
      fi
    elif [[ $1 == '--logout' ]]; then
      if [[ "$XDG_CURRENT_DESKTOP" == 'openbox' ]]; then
        openbox --exit
      elif [[ "$XDG_CURRENT_DESKTOP" == 'bspwm' ]]; then
        bspc quit
      elif [[ "$XDG_CURRENT_DESKTOP" == 'i3' ]]; then
        i3-msg exit
      elif [[ "$XDG_CURRENT_DESKTOP" == 'plasma' ]]; then
        qdbus org.kde.ksmserver /KSMServer logout 0 0 0
      elif [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
        hyprctl dispatch exit
      fi
    fi
  else
    exit 0
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
"$shutdown")
  run_cmd --shutdown
  ;;
"$reboot")
  run_cmd --reboot
  ;;
"$lock")
  if [[ -x '/usr/bin/betterlockscreen' ]]; then
    betterlockscreen -l
  elif [[ -x '/usr/bin/i3lock' ]]; then
    i3lock
  elif [[ -x '/usr/bin/hyprlock' ]]; then
    hyprlock
  fi
  ;;
"$suspend")
  run_cmd --suspend
  ;;
"$logout")
  run_cmd --logout
  ;;
esac
