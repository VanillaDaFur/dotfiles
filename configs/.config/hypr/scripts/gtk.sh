#!/bin/bash

# Set theme variables
THEME='catppuccin-mocha-mauve-standard+rimless,normal'
ICONS='Papirus-Dark'
FONT='Readex Pro 11'
CURSOR='Bibata-Modern-Ice'

# Template
SCHEMA='gsettings set org.gnome.desktop.interface'

# Apply them
apply_themes() {
  ${SCHEMA} gtk-theme "$THEME"
  ${SCHEMA} icon-theme "$ICONS"
  ${SCHEMA} cursor-theme "$CURSOR"
  ${SCHEMA} font-name "$FONT"

  gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu'

  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
}
apply_themes
