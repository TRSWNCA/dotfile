#!/usr/bin/env bash

MAC="88:C9:E8:E9:44:90"

is_connected() {
  echo "info $MAC" | bluetoothctl --agent noagent | grep -q "Connected: yes"
}

get_battery() {
  BAT_PATH=$(upower -e | grep -i "headset_dev")
  if [ -z "$BAT_PATH" ]; then
    BAT_PATH=$(upower -e | grep -i "bluez" | grep "battery")
  fi
  if [ -n "$BAT_PATH" ]; then
    echo "info 88:C9:E8:E9:44:90" | bluetoothctl --agent noagent | grep "Percentage" | sed 's/.*(\([0-9]*\)).*/\1/'
    # upower -i "$BAT_PATH" | grep -i percentage | awk '{print $2}' | tr -d '%'
  else
    echo "0"
  fi
}

get_battery_icon() {
  local battery=$1
  if [ "$battery" -eq 0 ]; then
    echo ""
  elif [ "$battery" -le 20 ]; then
    echo "󰂎"
  elif [ "$battery" -le 40 ]; then
    echo "󰂃"
  elif [ "$battery" -le 60 ]; then
    echo "󰂄"
  elif [ "$battery" -le 80 ]; then
    echo "󰂅"
  elif [ "$battery" -le 99 ]; then
    echo "󰂆"
  else
    echo "󰁹"
  fi
}

# ----- 状态显示 -----
if is_connected; then
  PERCENT=$(get_battery)
  ICON=$(get_battery_icon "$PERCENT")
  echo "${ICON} ${PERCENT}%"
else
  echo "󰤮 Disconnected"
fi
