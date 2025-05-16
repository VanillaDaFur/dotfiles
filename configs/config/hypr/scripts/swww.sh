#!/bin/sh

# Use random image
PIC_DIR="$HOME/.local/share/Wallpapers"
RANDOM_PIC=$(find "$PIC_DIR" -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | shuf -n 1)

# Set it as wallpaper using swww
swww img --transition-type outer --transition-pos 0.854,0.977 --transition-step 90 $RANDOM_PIC
