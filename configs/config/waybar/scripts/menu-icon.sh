#!/usr/bin/env sh

id=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')

if [ "$id" = "void" ]; then
  icon=""
elif [ "$id" = "arch" ]; then
  icon="󰣇"
elif [ "$id" = "fedora" ]; then
  icon=""
else
  icon=""
fi
 
echo $icon
