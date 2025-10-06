#!/usr/bin/env bash

compositor="  Compositor"
monitors=" 󰍺 Monitors"
keybinds="  Keybinds"
windowrules="  Windowrules"
environment="  Environment"
input="  Input"
autostart=" 󰐥 Autostart"

# Variables
terminal="kitty"
confdir="$HOME/.config/hypr/modules/"

# Current theme
dir="$HOME/.config/rofi/hyprconfig"
theme="style"

rofi_cmd() {
  rofi -dmenu \
    -p " Configuration" \
    -theme "${dir}/${theme}".rasi
}

choices="$compositor\n$monitors\n$keybinds\n$windowrules\n$environment\n$input\n$autostart"
chosen=$(echo -e "$choices" | rofi_cmd )

case "$chosen" in
  "$compositor")
    $terminal nvim "$confdir"/compositor.conf
    ;;
  "$monitors")
    $terminal nvim "$confdir"/monitors.conf
    ;;
  "$keybinds")
    $terminal nvim "$confdir"/keybinds.conf
    ;;
  "$windowrules")
    $terminal nvim "$confdir"/windowrules.conf
    ;;
  "$environment")
    $terminal nvim "$confdir"/environment.conf
    ;;
  "$input")
    $terminal nvim "$confdir"/input.conf
    ;;
  "$autostart")
    $terminal nvim "$confdir"/autostart.conf
    ;;
esac
