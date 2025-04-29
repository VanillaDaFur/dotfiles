#!/bin/sh

# Get an battery percentage
BAT="/sys/class/power_supply/BAT0"
CHARGE=$(cat $BAT/capacity)
STATUS=$(cat $BAT/status)

# Set icon if STATUS is discharging
if [ "$STATUS" = "Discharging" ]; then
  if [ "$CHARGE" -le 10 ]; then
    ICON="󰁺"
  elif [ "$CHARGE" -le 20 ]; then
    ICON="󰁻"
  elif [ "$CHARGE" -le 30 ]; then
    ICON="󰁼"
  elif [ "$CHARGE" -le 40 ]; then
    ICON="󰁽"
  elif [ "$CHARGE" -le 50 ]; then
    ICON="󰁾"
  elif [ "$CHARGE" -le 60 ]; then
    ICON="󰁿"
  elif [ "$CHARGE" -le 70 ]; then
    ICON="󰂀"
  elif [ "$CHARGE" -le 80 ]; then
    ICON="󰂁"
  elif [ "$CHARGE" -le 90 ]; then
    ICON="󰂂"
  else
    ICON="󰁹"
  fi

# Same but with charging status
elif [ "$STATUS" = "Charging" ]; then
  if [ "$CHARGE" -le 10 ]; then
    ICON="󰢜"
  elif [ "$CHARGE" -le 20 ]; then
    ICON="󰂆"
  elif [ "$CHARGE" -le 30 ]; then
    ICON="󰂇"
  elif [ "$CHARGE" -le 40 ]; then
    ICON="󰂈"
  elif [ "$CHARGE" -le 50 ]; then
    ICON="󰢝"
  elif [ "$CHARGE" -le 60 ]; then
    ICON="󰂉"
  elif [ "$CHARGE" -le 70 ]; then
    ICON="󰢞"
  elif [ "$CHARGE" -le 80 ]; then
    ICON="󰂊"
  elif [ "$CHARGE" -le 90 ]; then
    ICON="󰂋"
  else
    ICON="󰂅"
  fi
else
  ICON="󱈏"
fi

echo $ICON \ $CHARGE%
