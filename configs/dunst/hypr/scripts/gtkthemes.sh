#!/bin/bash

## SET GTK THEMES, ICONS, CURSORS AND FONTS VIA GSETTINGS

THEME='Catppuccin-mocha-mauve-standard+normal,rimless'
ICONS='Papirus-Dark'
FONT='Readex Pro 10'
CURSOR='Bibata-Modern-Ice'

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
