#!/usr/bin/env bash

MAC="88:C9:E8:E9:44:90"
CARD="bluez_card.88_C9_E8_E9_44_90"

# Removed icon variables - using text format instead

get_battery() {
    BAT_PATH=$(upower -e | grep -i "headset_dev")
    if [ -z "$BAT_PATH" ]; then
        BAT_PATH=$(upower -e | grep -i "bluez" | grep "battery")
    fi
    upower -i "$BAT_PATH" | grep -i percentage | awk '{print $2}' | tr -d '%'
}

is_connected() {
    bluetoothctl info "$MAC" | grep -q "Connected: yes"
}

toggle_connection() {
    if is_connected; then
        bluetoothctl disconnect "$MAC" >/dev/null
    else
        bluetoothctl connect "$MAC" >/dev/null
    fi
}

force_reconnect() {
    bluetoothctl disconnect "$MAC" >/dev/null
    sleep 1
    bluetoothctl connect "$MAC" >/dev/null
}

toggle_profile() {
    PROFILE=$(pactl list cards | grep -A10 "$CARD" | grep "Active Profile" | awk '{print $3}')
    if [[ "$PROFILE" == a2dp* ]]; then
        pactl set-card-profile "$CARD" headset-head-unit >/dev/null
    else
        pactl set-card-profile "$CARD" a2dp-sink >/dev/null
    fi
}

# ----- 鼠标交互 -----
case "$1" in
    toggle) toggle_connection ;;
    reconnect) force_reconnect ;;
    profile) toggle_profile ;;
esac

# ----- 状态显示 -----
if is_connected; then
    PERCENT=$(get_battery)
    echo "${PERCENT}%"
else
    echo "Nan"
fi
