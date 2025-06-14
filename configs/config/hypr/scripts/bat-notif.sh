#!/bin/sh

# Two temp files to prevent multiple notifications
EMPTY=/tmp/bat_empty
CHARGE=/tmp/bat_charging
FULL=/tmp/bat_full

while true; do
  # Battery stats
  WARNING=15
  DISCHARGING=$(acpi -b | grep -c "Discharging")
  CHARGING=$(acpi -b | grep -c "Charging")
  BATTERY=$(acpi -b | grep -o -P "[0-9]+(?=%)")

  # Reset notifications if the laptop charging/discharging
  if [ $DISCHARGING -eq 1 ] && [ -f $FULL ]; then
    rm -- $FULL
  elif [ $DISCHARGING -eq 0 ] && [ -f $EMPTY ]; then
    rm -- $EMPTY
  fi

  # Send notification
  if [ $BATTERY -gt 95 ] && [ $DISCHARGING -eq 0 ] && [ ! -f $FULL ]; then
    dunstify -a "battery" -i /home/Vanilla/.local/share/icons/Papirus/24x24/panel/battery-100.svg -t 2000 -r 2593 -u low "Battery Charged" "Battery is fully charged."
    touch $FULL
  elif [ $BATTERY -le $WARNING ] && [ $DISCHARGING -eq 1 ] && [ ! -f $EMPTY ]; then
    dunstify -a "battery" -i /home/Vanilla/.local/share/icons/Papirus/24x24/panel/battery-010.svg -t 10000 -r 2593 -u critical "Low Battery" "${BATTERY}% of battery remaining."
    touch $EMPTY
  fi
  sleep 120
done
