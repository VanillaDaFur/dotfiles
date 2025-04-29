#!/bin/bash

## SET GTK THEMES, ICONS, CURSORS AND FONTS VIA GSETTINGS

THEME='catppuccin-mocha-mauve-standard+rimless,normal'
ICONS='Papirus-Dark'
FONT='Readex Pro 11'
CURSOR='Bibata-Modern-Classic'

SCHEMA='gsettings set org.gnome.desktop.interface'

apply_themes() {
  ${SCHEMA} gtk-theme "$THEME"
  ${SCHEMA} icon-theme "$ICONS"
  ${SCHEMA} cursor-theme "$CURSOR"
  ${SCHEMA} font-name "$FONT"

  gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu'

  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
}

apply_themes
